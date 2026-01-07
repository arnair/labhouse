// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_screen_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RankingScreenState {

 bool get isLoadingMore; bool get listAnimationStarted; bool get listAnimationCompleted; bool get isPodiumVisible; String get searchQuery; AsyncValue<RankingResponse?> get ranking;
/// Create a copy of RankingScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingScreenStateCopyWith<RankingScreenState> get copyWith => _$RankingScreenStateCopyWithImpl<RankingScreenState>(this as RankingScreenState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingScreenState&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.listAnimationStarted, listAnimationStarted) || other.listAnimationStarted == listAnimationStarted)&&(identical(other.listAnimationCompleted, listAnimationCompleted) || other.listAnimationCompleted == listAnimationCompleted)&&(identical(other.isPodiumVisible, isPodiumVisible) || other.isPodiumVisible == isPodiumVisible)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.ranking, ranking) || other.ranking == ranking));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingMore,listAnimationStarted,listAnimationCompleted,isPodiumVisible,searchQuery,ranking);

@override
String toString() {
  return 'RankingScreenState(isLoadingMore: $isLoadingMore, listAnimationStarted: $listAnimationStarted, listAnimationCompleted: $listAnimationCompleted, isPodiumVisible: $isPodiumVisible, searchQuery: $searchQuery, ranking: $ranking)';
}


}

/// @nodoc
abstract mixin class $RankingScreenStateCopyWith<$Res>  {
  factory $RankingScreenStateCopyWith(RankingScreenState value, $Res Function(RankingScreenState) _then) = _$RankingScreenStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingMore, bool listAnimationStarted, bool listAnimationCompleted, bool isPodiumVisible, String searchQuery, AsyncValue<RankingResponse?> ranking
});




}
/// @nodoc
class _$RankingScreenStateCopyWithImpl<$Res>
    implements $RankingScreenStateCopyWith<$Res> {
  _$RankingScreenStateCopyWithImpl(this._self, this._then);

  final RankingScreenState _self;
  final $Res Function(RankingScreenState) _then;

/// Create a copy of RankingScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingMore = null,Object? listAnimationStarted = null,Object? listAnimationCompleted = null,Object? isPodiumVisible = null,Object? searchQuery = null,Object? ranking = null,}) {
  return _then(_self.copyWith(
isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,listAnimationStarted: null == listAnimationStarted ? _self.listAnimationStarted : listAnimationStarted // ignore: cast_nullable_to_non_nullable
as bool,listAnimationCompleted: null == listAnimationCompleted ? _self.listAnimationCompleted : listAnimationCompleted // ignore: cast_nullable_to_non_nullable
as bool,isPodiumVisible: null == isPodiumVisible ? _self.isPodiumVisible : isPodiumVisible // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as AsyncValue<RankingResponse?>,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingScreenState].
extension RankingScreenStatePatterns on RankingScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingScreenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingScreenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingScreenState value)  $default,){
final _that = this;
switch (_that) {
case _RankingScreenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingScreenState value)?  $default,){
final _that = this;
switch (_that) {
case _RankingScreenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoadingMore,  bool listAnimationStarted,  bool listAnimationCompleted,  bool isPodiumVisible,  String searchQuery,  AsyncValue<RankingResponse?> ranking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingScreenState() when $default != null:
return $default(_that.isLoadingMore,_that.listAnimationStarted,_that.listAnimationCompleted,_that.isPodiumVisible,_that.searchQuery,_that.ranking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoadingMore,  bool listAnimationStarted,  bool listAnimationCompleted,  bool isPodiumVisible,  String searchQuery,  AsyncValue<RankingResponse?> ranking)  $default,) {final _that = this;
switch (_that) {
case _RankingScreenState():
return $default(_that.isLoadingMore,_that.listAnimationStarted,_that.listAnimationCompleted,_that.isPodiumVisible,_that.searchQuery,_that.ranking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoadingMore,  bool listAnimationStarted,  bool listAnimationCompleted,  bool isPodiumVisible,  String searchQuery,  AsyncValue<RankingResponse?> ranking)?  $default,) {final _that = this;
switch (_that) {
case _RankingScreenState() when $default != null:
return $default(_that.isLoadingMore,_that.listAnimationStarted,_that.listAnimationCompleted,_that.isPodiumVisible,_that.searchQuery,_that.ranking);case _:
  return null;

}
}

}

/// @nodoc


class _RankingScreenState implements RankingScreenState {
  const _RankingScreenState({this.isLoadingMore = false, this.listAnimationStarted = false, this.listAnimationCompleted = false, this.isPodiumVisible = false, this.searchQuery = '', this.ranking = const AsyncValue.data(null)});
  

@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool listAnimationStarted;
@override@JsonKey() final  bool listAnimationCompleted;
@override@JsonKey() final  bool isPodiumVisible;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  AsyncValue<RankingResponse?> ranking;

/// Create a copy of RankingScreenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingScreenStateCopyWith<_RankingScreenState> get copyWith => __$RankingScreenStateCopyWithImpl<_RankingScreenState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingScreenState&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.listAnimationStarted, listAnimationStarted) || other.listAnimationStarted == listAnimationStarted)&&(identical(other.listAnimationCompleted, listAnimationCompleted) || other.listAnimationCompleted == listAnimationCompleted)&&(identical(other.isPodiumVisible, isPodiumVisible) || other.isPodiumVisible == isPodiumVisible)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.ranking, ranking) || other.ranking == ranking));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingMore,listAnimationStarted,listAnimationCompleted,isPodiumVisible,searchQuery,ranking);

@override
String toString() {
  return 'RankingScreenState(isLoadingMore: $isLoadingMore, listAnimationStarted: $listAnimationStarted, listAnimationCompleted: $listAnimationCompleted, isPodiumVisible: $isPodiumVisible, searchQuery: $searchQuery, ranking: $ranking)';
}


}

/// @nodoc
abstract mixin class _$RankingScreenStateCopyWith<$Res> implements $RankingScreenStateCopyWith<$Res> {
  factory _$RankingScreenStateCopyWith(_RankingScreenState value, $Res Function(_RankingScreenState) _then) = __$RankingScreenStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingMore, bool listAnimationStarted, bool listAnimationCompleted, bool isPodiumVisible, String searchQuery, AsyncValue<RankingResponse?> ranking
});




}
/// @nodoc
class __$RankingScreenStateCopyWithImpl<$Res>
    implements _$RankingScreenStateCopyWith<$Res> {
  __$RankingScreenStateCopyWithImpl(this._self, this._then);

  final _RankingScreenState _self;
  final $Res Function(_RankingScreenState) _then;

/// Create a copy of RankingScreenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingMore = null,Object? listAnimationStarted = null,Object? listAnimationCompleted = null,Object? isPodiumVisible = null,Object? searchQuery = null,Object? ranking = null,}) {
  return _then(_RankingScreenState(
isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,listAnimationStarted: null == listAnimationStarted ? _self.listAnimationStarted : listAnimationStarted // ignore: cast_nullable_to_non_nullable
as bool,listAnimationCompleted: null == listAnimationCompleted ? _self.listAnimationCompleted : listAnimationCompleted // ignore: cast_nullable_to_non_nullable
as bool,isPodiumVisible: null == isPodiumVisible ? _self.isPodiumVisible : isPodiumVisible // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as AsyncValue<RankingResponse?>,
  ));
}


}

// dart format on
