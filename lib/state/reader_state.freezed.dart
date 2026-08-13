// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReaderState {

 bool get showReaderOptions; String get pathData; String get pathFilePrefix; String get pathTitle; int get pathId; double get scrollOffset; double get maxOffset;
/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderStateCopyWith<ReaderState> get copyWith => _$ReaderStateCopyWithImpl<ReaderState>(this as ReaderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderState&&(identical(other.showReaderOptions, showReaderOptions) || other.showReaderOptions == showReaderOptions)&&(identical(other.pathData, pathData) || other.pathData == pathData)&&(identical(other.pathFilePrefix, pathFilePrefix) || other.pathFilePrefix == pathFilePrefix)&&(identical(other.pathTitle, pathTitle) || other.pathTitle == pathTitle)&&(identical(other.pathId, pathId) || other.pathId == pathId)&&(identical(other.scrollOffset, scrollOffset) || other.scrollOffset == scrollOffset)&&(identical(other.maxOffset, maxOffset) || other.maxOffset == maxOffset));
}


@override
int get hashCode => Object.hash(runtimeType,showReaderOptions,pathData,pathFilePrefix,pathTitle,pathId,scrollOffset,maxOffset);

@override
String toString() {
  return 'ReaderState(showReaderOptions: $showReaderOptions, pathData: $pathData, pathFilePrefix: $pathFilePrefix, pathTitle: $pathTitle, pathId: $pathId, scrollOffset: $scrollOffset, maxOffset: $maxOffset)';
}


}

/// @nodoc
abstract mixin class $ReaderStateCopyWith<$Res>  {
  factory $ReaderStateCopyWith(ReaderState value, $Res Function(ReaderState) _then) = _$ReaderStateCopyWithImpl;
@useResult
$Res call({
 bool showReaderOptions, String pathData, String pathFilePrefix, String pathTitle, int pathId, double scrollOffset, double maxOffset
});




}
/// @nodoc
class _$ReaderStateCopyWithImpl<$Res>
    implements $ReaderStateCopyWith<$Res> {
  _$ReaderStateCopyWithImpl(this._self, this._then);

  final ReaderState _self;
  final $Res Function(ReaderState) _then;

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showReaderOptions = null,Object? pathData = null,Object? pathFilePrefix = null,Object? pathTitle = null,Object? pathId = null,Object? scrollOffset = null,Object? maxOffset = null,}) {
  return _then(_self.copyWith(
showReaderOptions: null == showReaderOptions ? _self.showReaderOptions : showReaderOptions // ignore: cast_nullable_to_non_nullable
as bool,pathData: null == pathData ? _self.pathData : pathData // ignore: cast_nullable_to_non_nullable
as String,pathFilePrefix: null == pathFilePrefix ? _self.pathFilePrefix : pathFilePrefix // ignore: cast_nullable_to_non_nullable
as String,pathTitle: null == pathTitle ? _self.pathTitle : pathTitle // ignore: cast_nullable_to_non_nullable
as String,pathId: null == pathId ? _self.pathId : pathId // ignore: cast_nullable_to_non_nullable
as int,scrollOffset: null == scrollOffset ? _self.scrollOffset : scrollOffset // ignore: cast_nullable_to_non_nullable
as double,maxOffset: null == maxOffset ? _self.maxOffset : maxOffset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ReaderState].
extension ReaderStatePatterns on ReaderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReaderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReaderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReaderState value)  $default,){
final _that = this;
switch (_that) {
case _ReaderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReaderState value)?  $default,){
final _that = this;
switch (_that) {
case _ReaderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool showReaderOptions,  String pathData,  String pathFilePrefix,  String pathTitle,  int pathId,  double scrollOffset,  double maxOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReaderState() when $default != null:
return $default(_that.showReaderOptions,_that.pathData,_that.pathFilePrefix,_that.pathTitle,_that.pathId,_that.scrollOffset,_that.maxOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool showReaderOptions,  String pathData,  String pathFilePrefix,  String pathTitle,  int pathId,  double scrollOffset,  double maxOffset)  $default,) {final _that = this;
switch (_that) {
case _ReaderState():
return $default(_that.showReaderOptions,_that.pathData,_that.pathFilePrefix,_that.pathTitle,_that.pathId,_that.scrollOffset,_that.maxOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool showReaderOptions,  String pathData,  String pathFilePrefix,  String pathTitle,  int pathId,  double scrollOffset,  double maxOffset)?  $default,) {final _that = this;
switch (_that) {
case _ReaderState() when $default != null:
return $default(_that.showReaderOptions,_that.pathData,_that.pathFilePrefix,_that.pathTitle,_that.pathId,_that.scrollOffset,_that.maxOffset);case _:
  return null;

}
}

}

/// @nodoc


class _ReaderState implements ReaderState {
  const _ReaderState({required this.showReaderOptions, required this.pathData, required this.pathFilePrefix, required this.pathTitle, required this.pathId, this.scrollOffset = 0.0, this.maxOffset = 0.0});
  

@override final  bool showReaderOptions;
@override final  String pathData;
@override final  String pathFilePrefix;
@override final  String pathTitle;
@override final  int pathId;
@override@JsonKey() final  double scrollOffset;
@override@JsonKey() final  double maxOffset;

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderStateCopyWith<_ReaderState> get copyWith => __$ReaderStateCopyWithImpl<_ReaderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderState&&(identical(other.showReaderOptions, showReaderOptions) || other.showReaderOptions == showReaderOptions)&&(identical(other.pathData, pathData) || other.pathData == pathData)&&(identical(other.pathFilePrefix, pathFilePrefix) || other.pathFilePrefix == pathFilePrefix)&&(identical(other.pathTitle, pathTitle) || other.pathTitle == pathTitle)&&(identical(other.pathId, pathId) || other.pathId == pathId)&&(identical(other.scrollOffset, scrollOffset) || other.scrollOffset == scrollOffset)&&(identical(other.maxOffset, maxOffset) || other.maxOffset == maxOffset));
}


@override
int get hashCode => Object.hash(runtimeType,showReaderOptions,pathData,pathFilePrefix,pathTitle,pathId,scrollOffset,maxOffset);

@override
String toString() {
  return 'ReaderState(showReaderOptions: $showReaderOptions, pathData: $pathData, pathFilePrefix: $pathFilePrefix, pathTitle: $pathTitle, pathId: $pathId, scrollOffset: $scrollOffset, maxOffset: $maxOffset)';
}


}

/// @nodoc
abstract mixin class _$ReaderStateCopyWith<$Res> implements $ReaderStateCopyWith<$Res> {
  factory _$ReaderStateCopyWith(_ReaderState value, $Res Function(_ReaderState) _then) = __$ReaderStateCopyWithImpl;
@override @useResult
$Res call({
 bool showReaderOptions, String pathData, String pathFilePrefix, String pathTitle, int pathId, double scrollOffset, double maxOffset
});




}
/// @nodoc
class __$ReaderStateCopyWithImpl<$Res>
    implements _$ReaderStateCopyWith<$Res> {
  __$ReaderStateCopyWithImpl(this._self, this._then);

  final _ReaderState _self;
  final $Res Function(_ReaderState) _then;

/// Create a copy of ReaderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showReaderOptions = null,Object? pathData = null,Object? pathFilePrefix = null,Object? pathTitle = null,Object? pathId = null,Object? scrollOffset = null,Object? maxOffset = null,}) {
  return _then(_ReaderState(
showReaderOptions: null == showReaderOptions ? _self.showReaderOptions : showReaderOptions // ignore: cast_nullable_to_non_nullable
as bool,pathData: null == pathData ? _self.pathData : pathData // ignore: cast_nullable_to_non_nullable
as String,pathFilePrefix: null == pathFilePrefix ? _self.pathFilePrefix : pathFilePrefix // ignore: cast_nullable_to_non_nullable
as String,pathTitle: null == pathTitle ? _self.pathTitle : pathTitle // ignore: cast_nullable_to_non_nullable
as String,pathId: null == pathId ? _self.pathId : pathId // ignore: cast_nullable_to_non_nullable
as int,scrollOffset: null == scrollOffset ? _self.scrollOffset : scrollOffset // ignore: cast_nullable_to_non_nullable
as double,maxOffset: null == maxOffset ? _self.maxOffset : maxOffset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
