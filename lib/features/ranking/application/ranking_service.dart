import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/ranking_item_model.dart';
import '../domain/ranking_response_model.dart';
import '../data/openai_repository.dart';

part 'ranking_service.g.dart';

/// Service for ranking operations with pagination support
@riverpod
class RankingService extends _$RankingService {
  @override
  RankingService build() => this;

  static const _imageGenerationDelayMs = 1000;
  static const _maxPodiumRank = 3;

  OpenAiRepository _repository = OpenAiRepository();

  @visibleForTesting
  set openAiRepository(OpenAiRepository repo) => _repository = repo;

  OpenAiRepository get _openAiRepository => _repository;

  Stream<RankingResponse> getRankingStream({
    required String query,
    int offset = 0,
    int limit = 10,
    int? userLimit,
  }) {
    late StreamController<RankingResponse> controller;

    RankingResponse? lastEmittedResponse;
    List<RankingItem> currentItems = [];
    final Set<int> triggeredRanks = {};
    int activeImageGenerations = 0;
    bool isTextStreamDone = false;

    void emitResponseIfNeeded() {
      if (lastEmittedResponse != null && !controller.isClosed) {
        controller.add(lastEmittedResponse!.copyWith(items: currentItems));
      }
    }

    void tryCloseController() {
      if (isTextStreamDone &&
          activeImageGenerations == 0 &&
          !controller.isClosed) {
        controller.close();
      }
    }

    Future<void> generateImageInBackground(RankingItem item) async {
      await Future.delayed(
        Duration(milliseconds: (item.rank - 1) * _imageGenerationDelayMs),
      );

      try {
        final prompt = _buildImagePrompt(item, query);
        final imageUrl = await _openAiRepository.generateImage(prompt);

        if (imageUrl != null && !controller.isClosed) {
          _updateItemWithImage(item.rank, imageUrl, currentItems);
          emitResponseIfNeeded();
        }
      } catch (_) {
      } finally {
        activeImageGenerations--;
        tryCloseController();
      }
    }

    void triggerPodiumImageGeneration() {
      for (final item in currentItems) {
        if (item.rank <= _maxPodiumRank &&
            !triggeredRanks.contains(item.rank) &&
            item.imageUrl == null) {
          triggeredRanks.add(item.rank);
          activeImageGenerations++;
          generateImageInBackground(item);
        }
      }
    }

    controller = StreamController<RankingResponse>(
      onListen: () async {
        final sourceStream = _openAiRepository.generateRankingStream(
          query: query,
          offset: offset,
          limit: limit,
        );

        try {
          await for (final response in sourceStream) {
            currentItems = _mergeItems(response.items, currentItems);
            lastEmittedResponse = response.copyWith(items: currentItems);

            if (!controller.isClosed) {
              controller.add(lastEmittedResponse!);
            }

            triggerPodiumImageGeneration();
          }
        } catch (e, st) {
          if (!controller.isClosed) controller.addError(e, st);
        } finally {
          isTextStreamDone = true;
          tryCloseController();
        }
      },
    );

    return controller.stream;
  }

  /// Load more items (10 items batch)
  Stream<RankingResponse> loadMoreStream({
    required String query,
    required int currentCount,
    required int additionalItems,
    List<RankingItem> previousItems = const [],
  }) async* {
    if (currentCount >= 100) return;

    yield* _openAiRepository.generateRankingStream(
      query: query,
      offset: currentCount,
      limit: additionalItems,
      previousItems: previousItems,
    );
  }

  String _buildImagePrompt(RankingItem item, String query) {
    return 'A high quality, vibrant 3D render icon of "${item.title}". '
        '${item.description ?? query}. '
        'Minimalist style, isolated on dark background, high resolution, game asset style.';
  }

  List<RankingItem> _mergeItems(
    List<RankingItem> newItems,
    List<RankingItem> existingItems,
  ) {
    return newItems.map((newItem) {
      final existing = existingItems.firstWhere(
        (e) => e.rank == newItem.rank,
        orElse: () => newItem,
      );

      if (existing.imageUrl != null) {
        return newItem.copyWith(imageUrl: existing.imageUrl);
      }
      return newItem;
    }).toList();
  }

  void _updateItemWithImage(
    int rank,
    String imageUrl,
    List<RankingItem> items,
  ) {
    final index = items.indexWhere((i) => i.rank == rank);
    if (index != -1) {
      items[index] = items[index].copyWith(imageUrl: imageUrl);
    }
  }
}
