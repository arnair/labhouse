import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../../core/env/env.dart';
import '../../../core/errors/ranking_exception.dart';

import '../domain/ranking_item_model.dart';
import '../domain/ranking_response_model.dart';

/// Uses streaming NDJSON (Newline Delimited JSON) for real-time results.
class OpenAiRepository {
  OpenAiRepository({Dio? client, String? apiKey})
    : _client = client ?? Dio(),
      _apiKey = apiKey;

  final Dio _client;
  final String? _apiKey;

  static const _contentType = 'application/json';
  static const _streamDoneMarker = 'data: [DONE]';
  static const _dataPrefix = 'data: ';

  Stream<RankingResponse> generateRankingStream({
    required String query,
    int offset = 0,
    int limit = 10,
    List<RankingItem> previousItems = const [],
  }) async* {
    _validateApiKey();

    final itemsToGenerate = (limit + 1).clamp(1, 100);
    if (itemsToGenerate <= 0) return;

    const url =
        '${AppConstants.openAiBaseUrl}${AppConstants.chatCompletionsEndpoint}';

    final systemPrompt = _buildSystemPrompt(
      offset: offset,
      itemsToGenerate: itemsToGenerate,
      previousItems: previousItems,
    );

    try {
      final response = await _client.post(
        url,
        options: Options(
          headers: _buildHeaders(),
          responseType: ResponseType.stream,
        ),
        data: {
          'model': AppConstants.openAiModel,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': query},
          ],
          'temperature': 0.7,
          'stream': true,
        },
      );

      yield* _processRankingStream(response, query, itemsToGenerate);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw RankingException.unknown('Unexpected error: $e');
    }
  }

  Future<String?> generateImage(String prompt) async {
    if (_effectiveApiKey.isEmpty) return null;

    const url = '${AppConstants.openAiBaseUrl}/images/generations';

    try {
      final response = await _client.post(
        url,
        options: Options(headers: _buildHeaders()),
        data: {
          'model': 'dall-e-2',
          'prompt': prompt,
          'n': 1,
          'size': '256x256',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['data']?[0]?['url'] as String?;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  void _validateApiKey() {
    if (_effectiveApiKey.isEmpty) {
      throw RankingException.unknown('API Key not configured');
    }
  }

  String get _effectiveApiKey => _apiKey ?? Env.openAiApiKey;

  Map<String, String> _buildHeaders() => {
    'Content-Type': _contentType,
    'Authorization': 'Bearer $_effectiveApiKey',
  };

  String _buildSystemPrompt({
    required int offset,
    required int itemsToGenerate,
    required List<RankingItem> previousItems,
  }) {
    final startRank = offset + 1;
    final endRank = offset + itemsToGenerate;

    String contextString = '';
    if (previousItems.isNotEmpty) {
      final itemsList = previousItems
          .map(
            (i) =>
                '${i.rank}. ${i.title}${i.rating != null ? " (${i.rating})" : ""}',
          )
          .join(', ');
      contextString =
          'Already ranked: $itemsList. Continue from rank $startRank without repeating.';
    }

    return '''
You are a ranking expert. Generate a ranking list for the given topic.

Output format: NDJSON (Newline Delimited JSON)
Line 1: {"topic":"Title","criteria":"Criteria"}
Lines 2+: Items, each as {"rank":N,"title":"Name","description":"...","rating":4.5}

SAFETY & PERMISSIVENESS RULES:
- Refuse ONLY for: Illegal acts, violence, hate speech, or explicit sexual content.
- Future topics (e.g. "2025", "2030") are ALWAYS SAFE. Provide predictions, anticipated items, or announced schedules.
- Historical, scientific, and pop culture topics are ALWAYS SAFE.
- Subjective or "best" lists are ALWAYS SAFE.

REFUSAL LOGIC (USE ONLY FOR TRUE ENFORCEMENT):
- If truly UNSAFE (illegal, violent, hate speech): Return exactly {"error": "safety"}
- If the topic contains SIGNIFICANT TYPOS, is GIBBERISH, or is NONSENSE/UNINTELLIGIBLE: Return exactly {"error": "unknown"}
- NEVER refuse valid topics. If you are unsure of the data, provide your best expert estimate or general knowledge.

RANKING LOGIC:
- Aim for exactly $itemsToGenerate items (ranks $startRank to $endRank).
- Use "Anticipated" or "Scheduled" as the criteria for future events.

$contextString
''';
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      throw RankingException.network('Connection failed');
    }

    if (e.error is SocketException) {
      throw RankingException.network('No internet connection');
    }

    throw RankingException.unknown('Unexpected error: ${e.message}');
  }

  Stream<RankingResponse> _processRankingStream(
    Response<dynamic> response,
    String query,
    int itemsToGenerate,
  ) async* {
    if (response.statusCode != 200) {
      throw RankingException.unknown('API Error: ${response.statusCode}');
    }

    String buffer = '';
    String lineBuffer = '';
    String? currentTopic = 'Generating...';
    String? currentCriteria;
    final List<RankingItem> accumulatedItems = [];

    RankingResponse createResponse({bool isGenerating = true}) {
      return RankingResponse(
        query: query,
        topic: currentTopic ?? 'Loading...',
        criteria: currentCriteria,
        items: List.from(accumulatedItems),
        timestamp: DateTime.now(),
        totalAvailable: itemsToGenerate,
        isGenerating: isGenerating,
      );
    }

    yield createResponse();

    bool isDone = false;
    final stream = response.data.stream as Stream<List<int>>;

    try {
      await for (final chunk in stream.cast<List<int>>().transform(
        utf8.decoder,
      )) {
        if (isDone) break;

        buffer += chunk;

        while (buffer.contains('\n')) {
          final lineEndIndex = buffer.indexOf('\n');
          final line = buffer.substring(0, lineEndIndex).trim();
          buffer = buffer.substring(lineEndIndex + 1);

          if (line.isEmpty) continue;
          if (line.startsWith(_streamDoneMarker)) {
            isDone = true;
            break;
          }
          if (!line.startsWith(_dataPrefix)) continue;

          final jsonStr = line.substring(_dataPrefix.length);

          try {
            final data = jsonDecode(jsonStr);
            final content =
                data['choices']?[0]?['delta']?['content'] as String?;

            if (content != null) {
              lineBuffer += content;

              while (lineBuffer.contains('\n')) {
                final ndJsonEndIndex = lineBuffer.indexOf('\n');
                final ndJsonLine = lineBuffer
                    .substring(0, ndJsonEndIndex)
                    .trim();
                lineBuffer = lineBuffer.substring(ndJsonEndIndex + 1);

                if (ndJsonLine.isEmpty) continue;

                final parsed = _parseNdJsonLine(ndJsonLine, accumulatedItems);

                if (parsed != null) {
                  if (parsed.containsKey('topic')) {
                    currentTopic = parsed['topic'] as String?;
                    currentCriteria = parsed['criteria'] as String?;
                    yield createResponse();
                  } else if (parsed.containsKey('item')) {
                    accumulatedItems.add(parsed['item'] as RankingItem);
                    yield createResponse();
                  }
                }
              }
            }
          } catch (e) {
            if (e is RankingException) rethrow;
          }
        }
      }
    } catch (e) {
      if (e is DioException) {
        _handleDioError(e);
      }
      rethrow;
    }

    yield createResponse(isGenerating: false);
  }

  Map<String, dynamic>? _parseNdJsonLine(
    String line,
    List<RankingItem> existingItems,
  ) {
    try {
      final obj = jsonDecode(line);

      if (obj.containsKey('error')) {
        final errorType = obj['error'] as String?;
        if (errorType == 'safety') {
          throw RankingException.safety('Safety policy refusal');
        } else if (errorType == 'unknown') {
          throw RankingException.clarification('Unknown or nonsense topic');
        }
      }

      if (obj.containsKey('topic')) {
        return {'topic': obj['topic'], 'criteria': obj['criteria']};
      }

      if (obj.containsKey('rank') || obj.containsKey('title')) {
        final item = RankingItem(
          rank: obj['rank'] as int? ?? (existingItems.length + 1),
          title: obj['title'] as String? ?? 'Unknown',
          description: obj['description'] as String?,
          rating: (obj['rating'] as num?)?.toDouble(),
        );

        // Avoid duplicates
        if (!existingItems.any((i) => i.title == item.title)) {
          return {'item': item};
        }
      }

      return null;
    } catch (e) {
      if (e is RankingException) rethrow;
      return null;
    }
  }
}
