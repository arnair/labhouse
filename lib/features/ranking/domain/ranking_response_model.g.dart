// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankingResponse _$RankingResponseFromJson(Map<String, dynamic> json) =>
    _RankingResponse(
      query: json['query'] as String,
      topic: json['topic'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => RankingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      criteria: json['criteria'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      totalAvailable: (json['totalAvailable'] as num?)?.toInt() ?? 0,
      isGenerating: json['isGenerating'] as bool? ?? false,
    );

Map<String, dynamic> _$RankingResponseToJson(_RankingResponse instance) =>
    <String, dynamic>{
      'query': instance.query,
      'topic': instance.topic,
      'items': instance.items,
      'criteria': instance.criteria,
      'timestamp': instance.timestamp.toIso8601String(),
      'totalAvailable': instance.totalAvailable,
      'isGenerating': instance.isGenerating,
    };
