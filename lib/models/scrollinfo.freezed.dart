// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrollinfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScrollInfo {

 int get id; double get scrollOffset; double get maxOffset;
/// Create a copy of ScrollInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrollInfoCopyWith<ScrollInfo> get copyWith => _$ScrollInfoCopyWithImpl<ScrollInfo>(this as ScrollInfo, _$identity);

  /// Serializes this ScrollInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrollInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.scrollOffset, scrollOffset) || other.scrollOffset == scrollOffset)&&(identical(other.maxOffset, maxOffset) || other.maxOffset == maxOffset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scrollOffset,maxOffset);

@override
String toString() {
  return 'ScrollInfo(id: $id, scrollOffset: $scrollOffset, maxOffset: $maxOffset)';
}


}

/// @nodoc
abstract mixin class $ScrollInfoCopyWith<$Res>  {
  factory $ScrollInfoCopyWith(ScrollInfo value, $Res Function(ScrollInfo) _then) = _$ScrollInfoCopyWithImpl;
@useResult
$Res call({
 int id, double scrollOffset, double maxOffset
});




}
/// @nodoc
class _$ScrollInfoCopyWithImpl<$Res>
    implements $ScrollInfoCopyWith<$Res> {
  _$ScrollInfoCopyWithImpl(this._self, this._then);

  final ScrollInfo _self;
  final $Res Function(ScrollInfo) _then;

/// Create a copy of ScrollInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scrollOffset = null,Object? maxOffset = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,scrollOffset: null == scrollOffset ? _self.scrollOffset : scrollOffset // ignore: cast_nullable_to_non_nullable
as double,maxOffset: null == maxOffset ? _self.maxOffset : maxOffset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScrollInfo].
extension ScrollInfoPatterns on ScrollInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScrollInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScrollInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScrollInfo value)  $default,){
final _that = this;
switch (_that) {
case _ScrollInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScrollInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ScrollInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  double scrollOffset,  double maxOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrollInfo() when $default != null:
return $default(_that.id,_that.scrollOffset,_that.maxOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  double scrollOffset,  double maxOffset)  $default,) {final _that = this;
switch (_that) {
case _ScrollInfo():
return $default(_that.id,_that.scrollOffset,_that.maxOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  double scrollOffset,  double maxOffset)?  $default,) {final _that = this;
switch (_that) {
case _ScrollInfo() when $default != null:
return $default(_that.id,_that.scrollOffset,_that.maxOffset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrollInfo implements ScrollInfo {
  const _ScrollInfo({required this.id, required this.scrollOffset, required this.maxOffset});
  factory _ScrollInfo.fromJson(Map<String, dynamic> json) => _$ScrollInfoFromJson(json);

@override final  int id;
@override final  double scrollOffset;
@override final  double maxOffset;

/// Create a copy of ScrollInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrollInfoCopyWith<_ScrollInfo> get copyWith => __$ScrollInfoCopyWithImpl<_ScrollInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrollInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrollInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.scrollOffset, scrollOffset) || other.scrollOffset == scrollOffset)&&(identical(other.maxOffset, maxOffset) || other.maxOffset == maxOffset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scrollOffset,maxOffset);

@override
String toString() {
  return 'ScrollInfo(id: $id, scrollOffset: $scrollOffset, maxOffset: $maxOffset)';
}


}

/// @nodoc
abstract mixin class _$ScrollInfoCopyWith<$Res> implements $ScrollInfoCopyWith<$Res> {
  factory _$ScrollInfoCopyWith(_ScrollInfo value, $Res Function(_ScrollInfo) _then) = __$ScrollInfoCopyWithImpl;
@override @useResult
$Res call({
 int id, double scrollOffset, double maxOffset
});




}
/// @nodoc
class __$ScrollInfoCopyWithImpl<$Res>
    implements _$ScrollInfoCopyWith<$Res> {
  __$ScrollInfoCopyWithImpl(this._self, this._then);

  final _ScrollInfo _self;
  final $Res Function(_ScrollInfo) _then;

/// Create a copy of ScrollInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? scrollOffset = null,Object? maxOffset = null,}) {
  return _then(_ScrollInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,scrollOffset: null == scrollOffset ? _self.scrollOffset : scrollOffset // ignore: cast_nullable_to_non_nullable
as double,maxOffset: null == maxOffset ? _self.maxOffset : maxOffset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
