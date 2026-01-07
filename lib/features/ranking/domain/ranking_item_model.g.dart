// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankingItem _$RankingItemFromJson(Map<String, dynamic> json) => _RankingItem(
  rank: (json['rank'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  location: json['location'] as String?,
);

Map<String, dynamic> _$RankingItemToJson(_RankingItem instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'location': instance.location,
    };
