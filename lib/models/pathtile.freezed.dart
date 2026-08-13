// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pathtile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PathTile {

 int get id; String get title; String get gurmukhi; String get filePrefix;
/// Create a copy of PathTile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathTileCopyWith<PathTile> get copyWith => _$PathTileCopyWithImpl<PathTile>(this as PathTile, _$identity);

  /// Serializes this PathTile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PathTile&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.gurmukhi, gurmukhi) || other.gurmukhi == gurmukhi)&&(identical(other.filePrefix, filePrefix) || other.filePrefix == filePrefix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,gurmukhi,filePrefix);

@override
String toString() {
  return 'PathTile(id: $id, title: $title, gurmukhi: $gurmukhi, filePrefix: $filePrefix)';
}


}

/// @nodoc
abstract mixin class $PathTileCopyWith<$Res>  {
  factory $PathTileCopyWith(PathTile value, $Res Function(PathTile) _then) = _$PathTileCopyWithImpl;
@useResult
$Res call({
 int id, String title, String gurmukhi, String filePrefix
});




}
/// @nodoc
class _$PathTileCopyWithImpl<$Res>
    implements $PathTileCopyWith<$Res> {
  _$PathTileCopyWithImpl(this._self, this._then);

  final PathTile _self;
  final $Res Function(PathTile) _then;

/// Create a copy of PathTile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? gurmukhi = null,Object? filePrefix = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,gurmukhi: null == gurmukhi ? _self.gurmukhi : gurmukhi // ignore: cast_nullable_to_non_nullable
as String,filePrefix: null == filePrefix ? _self.filePrefix : filePrefix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PathTile].
extension PathTilePatterns on PathTile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PathTile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PathTile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PathTile value)  $default,){
final _that = this;
switch (_that) {
case _PathTile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PathTile value)?  $default,){
final _that = this;
switch (_that) {
case _PathTile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String gurmukhi,  String filePrefix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PathTile() when $default != null:
return $default(_that.id,_that.title,_that.gurmukhi,_that.filePrefix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String gurmukhi,  String filePrefix)  $default,) {final _that = this;
switch (_that) {
case _PathTile():
return $default(_that.id,_that.title,_that.gurmukhi,_that.filePrefix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String gurmukhi,  String filePrefix)?  $default,) {final _that = this;
switch (_that) {
case _PathTile() when $default != null:
return $default(_that.id,_that.title,_that.gurmukhi,_that.filePrefix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PathTile implements PathTile {
  const _PathTile({required this.id, required this.title, required this.gurmukhi, required this.filePrefix});
  factory _PathTile.fromJson(Map<String, dynamic> json) => _$PathTileFromJson(json);

@override final  int id;
@override final  String title;
@override final  String gurmukhi;
@override final  String filePrefix;

/// Create a copy of PathTile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PathTileCopyWith<_PathTile> get copyWith => __$PathTileCopyWithImpl<_PathTile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PathTileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PathTile&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.gurmukhi, gurmukhi) || other.gurmukhi == gurmukhi)&&(identical(other.filePrefix, filePrefix) || other.filePrefix == filePrefix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,gurmukhi,filePrefix);

@override
String toString() {
  return 'PathTile(id: $id, title: $title, gurmukhi: $gurmukhi, filePrefix: $filePrefix)';
}


}

/// @nodoc
abstract mixin class _$PathTileCopyWith<$Res> implements $PathTileCopyWith<$Res> {
  factory _$PathTileCopyWith(_PathTile value, $Res Function(_PathTile) _then) = __$PathTileCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String gurmukhi, String filePrefix
});




}
/// @nodoc
class __$PathTileCopyWithImpl<$Res>
    implements _$PathTileCopyWith<$Res> {
  __$PathTileCopyWithImpl(this._self, this._then);

  final _PathTile _self;
  final $Res Function(_PathTile) _then;

/// Create a copy of PathTile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? gurmukhi = null,Object? filePrefix = null,}) {
  return _then(_PathTile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,gurmukhi: null == gurmukhi ? _self.gurmukhi : gurmukhi // ignore: cast_nullable_to_non_nullable
as String,filePrefix: null == filePrefix ? _self.filePrefix : filePrefix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
