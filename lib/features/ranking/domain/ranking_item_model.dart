import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_item_model.freezed.dart';
part 'ranking_item_model.g.dart';

@freezed
abstract class RankingItem with _$RankingItem {
  const factory RankingItem({
    required int rank,
    required String title,
    String? description,
    String? imageUrl,
    double? rating,
    String? location,
  }) = _RankingItem;

  factory RankingItem.fromJson(Map<String, dynamic> json) =>
      _$RankingItemFromJson(json);
}
