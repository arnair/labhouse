// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankingResponse {

 String get query; String get topic; List<RankingItem> get items; String? get criteria; DateTime get timestamp; int get totalAvailable; bool get isGenerating;
/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingResponseCopyWith<RankingResponse> get copyWith => _$RankingResponseCopyWithImpl<RankingResponse>(this as RankingResponse, _$identity);

  /// Serializes this RankingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingResponse&&(identical(other.query, query) || other.query == query)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.criteria, criteria) || other.criteria == criteria)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.totalAvailable, totalAvailable) || other.totalAvailable == totalAvailable)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,topic,const DeepCollectionEquality().hash(items),criteria,timestamp,totalAvailable,isGenerating);

@override
String toString() {
  return 'RankingResponse(query: $query, topic: $topic, items: $items, criteria: $criteria, timestamp: $timestamp, totalAvailable: $totalAvailable, isGenerating: $isGenerating)';
}


}

/// @nodoc
abstract mixin class $RankingResponseCopyWith<$Res>  {
  factory $RankingResponseCopyWith(RankingResponse value, $Res Function(RankingResponse) _then) = _$RankingResponseCopyWithImpl;
@useResult
$Res call({
 String query, String topic, List<RankingItem> items, String? criteria, DateTime timestamp, int totalAvailable, bool isGenerating
});




}
/// @nodoc
class _$RankingResponseCopyWithImpl<$Res>
    implements $RankingResponseCopyWith<$Res> {
  _$RankingResponseCopyWithImpl(this._self, this._then);

  final RankingResponse _self;
  final $Res Function(RankingResponse) _then;

/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? topic = null,Object? items = null,Object? criteria = freezed,Object? timestamp = null,Object? totalAvailable = null,Object? isGenerating = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RankingItem>,criteria: freezed == criteria ? _self.criteria : criteria // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,totalAvailable: null == totalAvailable ? _self.totalAvailable : totalAvailable // ignore: cast_nullable_to_non_nullable
as int,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingResponse].
extension RankingResponsePatterns on RankingResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingResponse value)  $default,){
final _that = this;
switch (_that) {
case _RankingResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  String topic,  List<RankingItem> items,  String? criteria,  DateTime timestamp,  int totalAvailable,  bool isGenerating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
return $default(_that.query,_that.topic,_that.items,_that.criteria,_that.timestamp,_that.totalAvailable,_that.isGenerating);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  String topic,  List<RankingItem> items,  String? criteria,  DateTime timestamp,  int totalAvailable,  bool isGenerating)  $default,) {final _that = this;
switch (_that) {
case _RankingResponse():
return $default(_that.query,_that.topic,_that.items,_that.criteria,_that.timestamp,_that.totalAvailable,_that.isGenerating);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  String topic,  List<RankingItem> items,  String? criteria,  DateTime timestamp,  int totalAvailable,  bool isGenerating)?  $default,) {final _that = this;
switch (_that) {
case _RankingResponse() when $default != null:
return $default(_that.query,_that.topic,_that.items,_that.criteria,_that.timestamp,_that.totalAvailable,_that.isGenerating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingResponse implements RankingResponse {
  const _RankingResponse({required this.query, required this.topic, required final  List<RankingItem> items, this.criteria, required this.timestamp, this.totalAvailable = 0, this.isGenerating = false}): _items = items;
  factory _RankingResponse.fromJson(Map<String, dynamic> json) => _$RankingResponseFromJson(json);

@override final  String query;
@override final  String topic;
 final  List<RankingItem> _items;
@override List<RankingItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? criteria;
@override final  DateTime timestamp;
@override@JsonKey() final  int totalAvailable;
@override@JsonKey() final  bool isGenerating;

/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingResponseCopyWith<_RankingResponse> get copyWith => __$RankingResponseCopyWithImpl<_RankingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingResponse&&(identical(other.query, query) || other.query == query)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.criteria, criteria) || other.criteria == criteria)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.totalAvailable, totalAvailable) || other.totalAvailable == totalAvailable)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,topic,const DeepCollectionEquality().hash(_items),criteria,timestamp,totalAvailable,isGenerating);

@override
String toString() {
  return 'RankingResponse(query: $query, topic: $topic, items: $items, criteria: $criteria, timestamp: $timestamp, totalAvailable: $totalAvailable, isGenerating: $isGenerating)';
}


}

/// @nodoc
abstract mixin class _$RankingResponseCopyWith<$Res> implements $RankingResponseCopyWith<$Res> {
  factory _$RankingResponseCopyWith(_RankingResponse value, $Res Function(_RankingResponse) _then) = __$RankingResponseCopyWithImpl;
@override @useResult
$Res call({
 String query, String topic, List<RankingItem> items, String? criteria, DateTime timestamp, int totalAvailable, bool isGenerating
});




}
/// @nodoc
class __$RankingResponseCopyWithImpl<$Res>
    implements _$RankingResponseCopyWith<$Res> {
  __$RankingResponseCopyWithImpl(this._self, this._then);

  final _RankingResponse _self;
  final $Res Function(_RankingResponse) _then;

/// Create a copy of RankingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? topic = null,Object? items = null,Object? criteria = freezed,Object? timestamp = null,Object? totalAvailable = null,Object? isGenerating = null,}) {
  return _then(_RankingResponse(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RankingItem>,criteria: freezed == criteria ? _self.criteria : criteria // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,totalAvailable: null == totalAvailable ? _self.totalAvailable : totalAvailable // ignore: cast_nullable_to_non_nullable
as int,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
