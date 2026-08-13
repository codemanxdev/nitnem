// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'readingsession.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingSession {

 int get pathId; String get pathTitle; DateTime get startTime; DateTime get endTime; int get durationSeconds;
/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSessionCopyWith<ReadingSession> get copyWith => _$ReadingSessionCopyWithImpl<ReadingSession>(this as ReadingSession, _$identity);

  /// Serializes this ReadingSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSession&&(identical(other.pathId, pathId) || other.pathId == pathId)&&(identical(other.pathTitle, pathTitle) || other.pathTitle == pathTitle)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pathId,pathTitle,startTime,endTime,durationSeconds);

@override
String toString() {
  return 'ReadingSession(pathId: $pathId, pathTitle: $pathTitle, startTime: $startTime, endTime: $endTime, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $ReadingSessionCopyWith<$Res>  {
  factory $ReadingSessionCopyWith(ReadingSession value, $Res Function(ReadingSession) _then) = _$ReadingSessionCopyWithImpl;
@useResult
$Res call({
 int pathId, String pathTitle, DateTime startTime, DateTime endTime, int durationSeconds
});




}
/// @nodoc
class _$ReadingSessionCopyWithImpl<$Res>
    implements $ReadingSessionCopyWith<$Res> {
  _$ReadingSessionCopyWithImpl(this._self, this._then);

  final ReadingSession _self;
  final $Res Function(ReadingSession) _then;

/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pathId = null,Object? pathTitle = null,Object? startTime = null,Object? endTime = null,Object? durationSeconds = null,}) {
  return _then(_self.copyWith(
pathId: null == pathId ? _self.pathId : pathId // ignore: cast_nullable_to_non_nullable
as int,pathTitle: null == pathTitle ? _self.pathTitle : pathTitle // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingSession].
extension ReadingSessionPatterns on ReadingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSession value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSession value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pathId,  String pathTitle,  DateTime startTime,  DateTime endTime,  int durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
return $default(_that.pathId,_that.pathTitle,_that.startTime,_that.endTime,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pathId,  String pathTitle,  DateTime startTime,  DateTime endTime,  int durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _ReadingSession():
return $default(_that.pathId,_that.pathTitle,_that.startTime,_that.endTime,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pathId,  String pathTitle,  DateTime startTime,  DateTime endTime,  int durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
return $default(_that.pathId,_that.pathTitle,_that.startTime,_that.endTime,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSession implements ReadingSession {
  const _ReadingSession({required this.pathId, required this.pathTitle, required this.startTime, required this.endTime, required this.durationSeconds});
  factory _ReadingSession.fromJson(Map<String, dynamic> json) => _$ReadingSessionFromJson(json);

@override final  int pathId;
@override final  String pathTitle;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  int durationSeconds;

/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSessionCopyWith<_ReadingSession> get copyWith => __$ReadingSessionCopyWithImpl<_ReadingSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSession&&(identical(other.pathId, pathId) || other.pathId == pathId)&&(identical(other.pathTitle, pathTitle) || other.pathTitle == pathTitle)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pathId,pathTitle,startTime,endTime,durationSeconds);

@override
String toString() {
  return 'ReadingSession(pathId: $pathId, pathTitle: $pathTitle, startTime: $startTime, endTime: $endTime, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$ReadingSessionCopyWith<$Res> implements $ReadingSessionCopyWith<$Res> {
  factory _$ReadingSessionCopyWith(_ReadingSession value, $Res Function(_ReadingSession) _then) = __$ReadingSessionCopyWithImpl;
@override @useResult
$Res call({
 int pathId, String pathTitle, DateTime startTime, DateTime endTime, int durationSeconds
});




}
/// @nodoc
class __$ReadingSessionCopyWithImpl<$Res>
    implements _$ReadingSessionCopyWith<$Res> {
  __$ReadingSessionCopyWithImpl(this._self, this._then);

  final _ReadingSession _self;
  final $Res Function(_ReadingSession) _then;

/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pathId = null,Object? pathTitle = null,Object? startTime = null,Object? endTime = null,Object? durationSeconds = null,}) {
  return _then(_ReadingSession(
pathId: null == pathId ? _self.pathId : pathId // ignore: cast_nullable_to_non_nullable
as int,pathTitle: null == pathTitle ? _self.pathTitle : pathTitle // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
