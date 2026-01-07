import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:labhouse/core/errors/ranking_exception.dart';
import 'package:labhouse/features/ranking/domain/ranking_item_model.dart';
import 'package:labhouse/features/ranking/domain/ranking_response_model.dart';
import 'package:labhouse/features/ranking/application/ranking_service.dart';

part 'ranking_screen_controller.g.dart';
part 'ranking_screen_controller.freezed.dart';

@riverpod
class RankingScreenController extends _$RankingScreenController {
  static const _maxItems = 100;
  static const _loadMoreBatchSize = 10;
  static const _initialBatchSize = 25;

  @override
  RankingScreenState build() => const RankingScreenState();

  void _setSearchQuery(String query) =>
      state = state.copyWith(searchQuery: query);

  void onTitleAnimationCompleted() =>
      state = state.copyWith(isPodiumVisible: true);

  void onPodiumAnimationCompleted() =>
      state = state.copyWith(listAnimationStarted: true);

  void onListAnimationCompleted() =>
      state = state.copyWith(listAnimationCompleted: true);

  Future<void> initialize(String? initialQuery) async {
    if (initialQuery != null && initialQuery.isNotEmpty) {
      _setSearchQuery(initialQuery);
      await submitQuery(initialQuery);
    } else {
      final ranking = state.ranking.value;
      if (ranking != null) {
        _setSearchQuery(ranking.query);
      }
    }
  }

  Future<void> submitQuery(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    state = state.copyWith(ranking: const AsyncValue.loading());

    try {
      final service = ref.read(rankingServiceProvider);
      final stream = service.getRankingStream(
        query: trimmedQuery,
        limit: _initialBatchSize,
      );

      await for (final response in stream) {
        if (!ref.mounted) break;

        state = state.copyWith(ranking: AsyncValue.data(response));
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = state.copyWith(ranking: AsyncValue.error(e, st));
      }
    }
  }

  Future<void> retryQuery() async {
    if (state.searchQuery.isEmpty) return;
    await submitQuery(state.searchQuery);
  }

  Future<void> loadMoreItems() async {
    final currentRanking = state.ranking.value;
    if (state.isLoadingMore || currentRanking == null) return;
    if (currentRanking.items.length >= _maxItems) return;

    state = state.copyWith(isLoadingMore: true);
    final loadingQuery = currentRanking.query;

    try {
      final service = ref.read(rankingServiceProvider);
      final stream = service.loadMoreStream(
        query: currentRanking.query,
        currentCount: currentRanking.items.length,
        additionalItems: _loadMoreBatchSize,
        previousItems: currentRanking.items,
      );

      final initialItems = currentRanking.items;
      final existingTitles = initialItems
          .map((i) => i.title.toLowerCase())
          .toSet();

      RankingResponse? finalResponse;
      await for (final response in stream) {
        if (!ref.mounted) break;
        // Race condition check: ensure query hasn't changed
        if (state.searchQuery != loadingQuery) break;
        finalResponse = response;
      }

      if (ref.mounted &&
          finalResponse != null &&
          state.searchQuery == loadingQuery) {
        _appendNewItems(initialItems, finalResponse.items, existingTitles);
      }
    } finally {
      if (ref.mounted) {
        state = state.copyWith(isLoadingMore: false);
      }
    }
  }

  void _appendNewItems(
    List<RankingItem> initialItems,
    List<RankingItem> newItems,
    Set<String> existingTitles,
  ) {
    final uniqueNewItems = newItems
        .where((item) => !existingTitles.contains(item.title.toLowerCase()))
        .toList();

    if (uniqueNewItems.isEmpty) return;

    // Enforce sequential ranking
    final startRank = initialItems.length + 1;
    final reRankedItems = uniqueNewItems.asMap().entries.map((entry) {
      return entry.value.copyWith(rank: startRank + entry.key);
    }).toList();

    final mergedItems = [...initialItems, ...reRankedItems];
    final currentRanking = state.ranking.value;

    if (currentRanking != null) {
      state = state.copyWith(
        ranking: AsyncValue.data(currentRanking.copyWith(items: mergedItems)),
      );
    }
  }

  ({RankingErrorType type, String message})? getErrorFromException(
    Object error,
  ) {
    if (error is RankingException) {
      return (type: error.type, message: error.message);
    }
    return (
      type: RankingErrorType.unknown,
      message: error is Exception ? error.toString() : 'Unknown error',
    );
  }

  bool isEmptyResult(RankingResponse? response) {
    return response != null && !response.isGenerating && response.items.isEmpty;
  }
}

@freezed
abstract class RankingScreenState with _$RankingScreenState {
  const factory RankingScreenState({
    @Default(false) bool isLoadingMore,
    @Default(false) bool listAnimationStarted,
    @Default(false) bool listAnimationCompleted,

    @Default(false) bool isPodiumVisible,
    @Default('') String searchQuery,
    @Default(AsyncValue.data(null)) AsyncValue<RankingResponse?> ranking,
  }) = _RankingScreenState;
}
