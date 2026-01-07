import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:labhouse/features/ranking/domain/ranking_item_model.dart';

part 'ranking_response_model.freezed.dart';
part 'ranking_response_model.g.dart';

@freezed
abstract class RankingResponse with _$RankingResponse {
  const factory RankingResponse({
    required String query,
    required String topic,
    required List<RankingItem> items,
    String? criteria,
    required DateTime timestamp,
    @Default(0) int totalAvailable,
    @Default(false) bool isGenerating,
  }) = _RankingResponse;

  factory RankingResponse.fromJson(Map<String, dynamic> json) =>
      _$RankingResponseFromJson(json);
}
