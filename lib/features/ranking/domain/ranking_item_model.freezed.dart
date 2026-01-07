// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankingItem {

 int get rank; String get title; String? get description; String? get imageUrl; double? get rating; String? get location;
/// Create a copy of RankingItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingItemCopyWith<RankingItem> get copyWith => _$RankingItemCopyWithImpl<RankingItem>(this as RankingItem, _$identity);

  /// Serializes this RankingItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingItem&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,title,description,imageUrl,rating,location);

@override
String toString() {
  return 'RankingItem(rank: $rank, title: $title, description: $description, imageUrl: $imageUrl, rating: $rating, location: $location)';
}


}

/// @nodoc
abstract mixin class $RankingItemCopyWith<$Res>  {
  factory $RankingItemCopyWith(RankingItem value, $Res Function(RankingItem) _then) = _$RankingItemCopyWithImpl;
@useResult
$Res call({
 int rank, String title, String? description, String? imageUrl, double? rating, String? location
});




}
/// @nodoc
class _$RankingItemCopyWithImpl<$Res>
    implements $RankingItemCopyWith<$Res> {
  _$RankingItemCopyWithImpl(this._self, this._then);

  final RankingItem _self;
  final $Res Function(RankingItem) _then;

/// Create a copy of RankingItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? title = null,Object? description = freezed,Object? imageUrl = freezed,Object? rating = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingItem].
extension RankingItemPatterns on RankingItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingItem value)  $default,){
final _that = this;
switch (_that) {
case _RankingItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingItem value)?  $default,){
final _that = this;
switch (_that) {
case _RankingItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  String title,  String? description,  String? imageUrl,  double? rating,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingItem() when $default != null:
return $default(_that.rank,_that.title,_that.description,_that.imageUrl,_that.rating,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  String title,  String? description,  String? imageUrl,  double? rating,  String? location)  $default,) {final _that = this;
switch (_that) {
case _RankingItem():
return $default(_that.rank,_that.title,_that.description,_that.imageUrl,_that.rating,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  String title,  String? description,  String? imageUrl,  double? rating,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _RankingItem() when $default != null:
return $default(_that.rank,_that.title,_that.description,_that.imageUrl,_that.rating,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingItem implements RankingItem {
  const _RankingItem({required this.rank, required this.title, this.description, this.imageUrl, this.rating, this.location});
  factory _RankingItem.fromJson(Map<String, dynamic> json) => _$RankingItemFromJson(json);

@override final  int rank;
@override final  String title;
@override final  String? description;
@override final  String? imageUrl;
@override final  double? rating;
@override final  String? location;

/// Create a copy of RankingItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingItemCopyWith<_RankingItem> get copyWith => __$RankingItemCopyWithImpl<_RankingItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingItem&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rank,title,description,imageUrl,rating,location);

@override
String toString() {
  return 'RankingItem(rank: $rank, title: $title, description: $description, imageUrl: $imageUrl, rating: $rating, location: $location)';
}


}

/// @nodoc
abstract mixin class _$RankingItemCopyWith<$Res> implements $RankingItemCopyWith<$Res> {
  factory _$RankingItemCopyWith(_RankingItem value, $Res Function(_RankingItem) _then) = __$RankingItemCopyWithImpl;
@override @useResult
$Res call({
 int rank, String title, String? description, String? imageUrl, double? rating, String? location
});




}
/// @nodoc
class __$RankingItemCopyWithImpl<$Res>
    implements _$RankingItemCopyWith<$Res> {
  __$RankingItemCopyWithImpl(this._self, this._then);

  final _RankingItem _self;
  final $Res Function(_RankingItem) _then;

/// Create a copy of RankingItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? title = null,Object? description = freezed,Object? imageUrl = freezed,Object? rating = freezed,Object? location = freezed,}) {
  return _then(_RankingItem(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
