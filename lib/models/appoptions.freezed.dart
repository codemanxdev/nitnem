// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appoptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppOptions {

 String get themeName; bool get bold; bool get showStatus; double get textScaleValue; String get languageName; bool get screenAwake; bool get saveScrollPosition; Map<String, ScrollInfo> get scrollOffset; List<dynamic> get baaniOrderedIds; List<ReadingSession> get readingSessions; int get dailyGoalMinutes; int get totalReadingDuration; int get totalSessionsCount; int get currentStreak; DateTime? get lastReadDate;
/// Create a copy of AppOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppOptionsCopyWith<AppOptions> get copyWith => _$AppOptionsCopyWithImpl<AppOptions>(this as AppOptions, _$identity);

  /// Serializes this AppOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppOptions&&(identical(other.themeName, themeName) || other.themeName == themeName)&&(identical(other.bold, bold) || other.bold == bold)&&(identical(other.showStatus, showStatus) || other.showStatus == showStatus)&&(identical(other.textScaleValue, textScaleValue) || other.textScaleValue == textScaleValue)&&(identical(other.languageName, languageName) || other.languageName == languageName)&&(identical(other.screenAwake, screenAwake) || other.screenAwake == screenAwake)&&(identical(other.saveScrollPosition, saveScrollPosition) || other.saveScrollPosition == saveScrollPosition)&&const DeepCollectionEquality().equals(other.scrollOffset, scrollOffset)&&const DeepCollectionEquality().equals(other.baaniOrderedIds, baaniOrderedIds)&&const DeepCollectionEquality().equals(other.readingSessions, readingSessions)&&(identical(other.dailyGoalMinutes, dailyGoalMinutes) || other.dailyGoalMinutes == dailyGoalMinutes)&&(identical(other.totalReadingDuration, totalReadingDuration) || other.totalReadingDuration == totalReadingDuration)&&(identical(other.totalSessionsCount, totalSessionsCount) || other.totalSessionsCount == totalSessionsCount)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.lastReadDate, lastReadDate) || other.lastReadDate == lastReadDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeName,bold,showStatus,textScaleValue,languageName,screenAwake,saveScrollPosition,const DeepCollectionEquality().hash(scrollOffset),const DeepCollectionEquality().hash(baaniOrderedIds),const DeepCollectionEquality().hash(readingSessions),dailyGoalMinutes,totalReadingDuration,totalSessionsCount,currentStreak,lastReadDate);

@override
String toString() {
  return 'AppOptions(themeName: $themeName, bold: $bold, showStatus: $showStatus, textScaleValue: $textScaleValue, languageName: $languageName, screenAwake: $screenAwake, saveScrollPosition: $saveScrollPosition, scrollOffset: $scrollOffset, baaniOrderedIds: $baaniOrderedIds, readingSessions: $readingSessions, dailyGoalMinutes: $dailyGoalMinutes, totalReadingDuration: $totalReadingDuration, totalSessionsCount: $totalSessionsCount, currentStreak: $currentStreak, lastReadDate: $lastReadDate)';
}


}

/// @nodoc
abstract mixin class $AppOptionsCopyWith<$Res>  {
  factory $AppOptionsCopyWith(AppOptions value, $Res Function(AppOptions) _then) = _$AppOptionsCopyWithImpl;
@useResult
$Res call({
 String themeName, bool bold, bool showStatus, double textScaleValue, String languageName, bool screenAwake, bool saveScrollPosition, Map<String, ScrollInfo> scrollOffset, List<dynamic> baaniOrderedIds, List<ReadingSession> readingSessions, int dailyGoalMinutes, int totalReadingDuration, int totalSessionsCount, int currentStreak, DateTime? lastReadDate
});




}
/// @nodoc
class _$AppOptionsCopyWithImpl<$Res>
    implements $AppOptionsCopyWith<$Res> {
  _$AppOptionsCopyWithImpl(this._self, this._then);

  final AppOptions _self;
  final $Res Function(AppOptions) _then;

/// Create a copy of AppOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeName = null,Object? bold = null,Object? showStatus = null,Object? textScaleValue = null,Object? languageName = null,Object? screenAwake = null,Object? saveScrollPosition = null,Object? scrollOffset = null,Object? baaniOrderedIds = null,Object? readingSessions = null,Object? dailyGoalMinutes = null,Object? totalReadingDuration = null,Object? totalSessionsCount = null,Object? currentStreak = null,Object? lastReadDate = freezed,}) {
  return _then(_self.copyWith(
themeName: null == themeName ? _self.themeName : themeName // ignore: cast_nullable_to_non_nullable
as String,bold: null == bold ? _self.bold : bold // ignore: cast_nullable_to_non_nullable
as bool,showStatus: null == showStatus ? _self.showStatus : showStatus // ignore: cast_nullable_to_non_nullable
as bool,textScaleValue: null == textScaleValue ? _self.textScaleValue : textScaleValue // ignore: cast_nullable_to_non_nullable
as double,languageName: null == languageName ? _self.languageName : languageName // ignore: cast_nullable_to_non_nullable
as String,screenAwake: null == screenAwake ? _self.screenAwake : screenAwake // ignore: cast_nullable_to_non_nullable
as bool,saveScrollPosition: null == saveScrollPosition ? _self.saveScrollPosition : saveScrollPosition // ignore: cast_nullable_to_non_nullable
as bool,scrollOffset: null == scrollOffset ? _self.scrollOffset : scrollOffset // ignore: cast_nullable_to_non_nullable
as Map<String, ScrollInfo>,baaniOrderedIds: null == baaniOrderedIds ? _self.baaniOrderedIds : baaniOrderedIds // ignore: cast_nullable_to_non_nullable
as List<dynamic>,readingSessions: null == readingSessions ? _self.readingSessions : readingSessions // ignore: cast_nullable_to_non_nullable
as List<ReadingSession>,dailyGoalMinutes: null == dailyGoalMinutes ? _self.dailyGoalMinutes : dailyGoalMinutes // ignore: cast_nullable_to_non_nullable
as int,totalReadingDuration: null == totalReadingDuration ? _self.totalReadingDuration : totalReadingDuration // ignore: cast_nullable_to_non_nullable
as int,totalSessionsCount: null == totalSessionsCount ? _self.totalSessionsCount : totalSessionsCount // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,lastReadDate: freezed == lastReadDate ? _self.lastReadDate : lastReadDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppOptions].
extension AppOptionsPatterns on AppOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppOptions value)  $default,){
final _that = this;
switch (_that) {
case _AppOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppOptions value)?  $default,){
final _that = this;
switch (_that) {
case _AppOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String themeName,  bool bold,  bool showStatus,  double textScaleValue,  String languageName,  bool screenAwake,  bool saveScrollPosition,  Map<String, ScrollInfo> scrollOffset,  List<dynamic> baaniOrderedIds,  List<ReadingSession> readingSessions,  int dailyGoalMinutes,  int totalReadingDuration,  int totalSessionsCount,  int currentStreak,  DateTime? lastReadDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppOptions() when $default != null:
return $default(_that.themeName,_that.bold,_that.showStatus,_that.textScaleValue,_that.languageName,_that.screenAwake,_that.saveScrollPosition,_that.scrollOffset,_that.baaniOrderedIds,_that.readingSessions,_that.dailyGoalMinutes,_that.totalReadingDuration,_that.totalSessionsCount,_that.currentStreak,_that.lastReadDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String themeName,  bool bold,  bool showStatus,  double textScaleValue,  String languageName,  bool screenAwake,  bool saveScrollPosition,  Map<String, ScrollInfo> scrollOffset,  List<dynamic> baaniOrderedIds,  List<ReadingSession> readingSessions,  int dailyGoalMinutes,  int totalReadingDuration,  int totalSessionsCount,  int currentStreak,  DateTime? lastReadDate)  $default,) {final _that = this;
switch (_that) {
case _AppOptions():
return $default(_that.themeName,_that.bold,_that.showStatus,_that.textScaleValue,_that.languageName,_that.screenAwake,_that.saveScrollPosition,_that.scrollOffset,_that.baaniOrderedIds,_that.readingSessions,_that.dailyGoalMinutes,_that.totalReadingDuration,_that.totalSessionsCount,_that.currentStreak,_that.lastReadDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String themeName,  bool bold,  bool showStatus,  double textScaleValue,  String languageName,  bool screenAwake,  bool saveScrollPosition,  Map<String, ScrollInfo> scrollOffset,  List<dynamic> baaniOrderedIds,  List<ReadingSession> readingSessions,  int dailyGoalMinutes,  int totalReadingDuration,  int totalSessionsCount,  int currentStreak,  DateTime? lastReadDate)?  $default,) {final _that = this;
switch (_that) {
case _AppOptions() when $default != null:
return $default(_that.themeName,_that.bold,_that.showStatus,_that.textScaleValue,_that.languageName,_that.screenAwake,_that.saveScrollPosition,_that.scrollOffset,_that.baaniOrderedIds,_that.readingSessions,_that.dailyGoalMinutes,_that.totalReadingDuration,_that.totalSessionsCount,_that.currentStreak,_that.lastReadDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppOptions implements AppOptions {
  const _AppOptions({required this.themeName, required this.bold, required this.showStatus, required this.textScaleValue, required this.languageName, required this.screenAwake, required this.saveScrollPosition, required final  Map<String, ScrollInfo> scrollOffset, required final  List<dynamic> baaniOrderedIds, required final  List<ReadingSession> readingSessions, required this.dailyGoalMinutes, required this.totalReadingDuration, required this.totalSessionsCount, required this.currentStreak, this.lastReadDate}): _scrollOffset = scrollOffset,_baaniOrderedIds = baaniOrderedIds,_readingSessions = readingSessions;
  factory _AppOptions.fromJson(Map<String, dynamic> json) => _$AppOptionsFromJson(json);

@override final  String themeName;
@override final  bool bold;
@override final  bool showStatus;
@override final  double textScaleValue;
@override final  String languageName;
@override final  bool screenAwake;
@override final  bool saveScrollPosition;
 final  Map<String, ScrollInfo> _scrollOffset;
@override Map<String, ScrollInfo> get scrollOffset {
  if (_scrollOffset is EqualUnmodifiableMapView) return _scrollOffset;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scrollOffset);
}

 final  List<dynamic> _baaniOrderedIds;
@override List<dynamic> get baaniOrderedIds {
  if (_baaniOrderedIds is EqualUnmodifiableListView) return _baaniOrderedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_baaniOrderedIds);
}

 final  List<ReadingSession> _readingSessions;
@override List<ReadingSession> get readingSessions {
  if (_readingSessions is EqualUnmodifiableListView) return _readingSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readingSessions);
}

@override final  int dailyGoalMinutes;
@override final  int totalReadingDuration;
@override final  int totalSessionsCount;
@override final  int currentStreak;
@override final  DateTime? lastReadDate;

/// Create a copy of AppOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppOptionsCopyWith<_AppOptions> get copyWith => __$AppOptionsCopyWithImpl<_AppOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppOptions&&(identical(other.themeName, themeName) || other.themeName == themeName)&&(identical(other.bold, bold) || other.bold == bold)&&(identical(other.showStatus, showStatus) || other.showStatus == showStatus)&&(identical(other.textScaleValue, textScaleValue) || other.textScaleValue == textScaleValue)&&(identical(other.languageName, languageName) || other.languageName == languageName)&&(identical(other.screenAwake, screenAwake) || other.screenAwake == screenAwake)&&(identical(other.saveScrollPosition, saveScrollPosition) || other.saveScrollPosition == saveScrollPosition)&&const DeepCollectionEquality().equals(other._scrollOffset, _scrollOffset)&&const DeepCollectionEquality().equals(other._baaniOrderedIds, _baaniOrderedIds)&&const DeepCollectionEquality().equals(other._readingSessions, _readingSessions)&&(identical(other.dailyGoalMinutes, dailyGoalMinutes) || other.dailyGoalMinutes == dailyGoalMinutes)&&(identical(other.totalReadingDuration, totalReadingDuration) || other.totalReadingDuration == totalReadingDuration)&&(identical(other.totalSessionsCount, totalSessionsCount) || other.totalSessionsCount == totalSessionsCount)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.lastReadDate, lastReadDate) || other.lastReadDate == lastReadDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeName,bold,showStatus,textScaleValue,languageName,screenAwake,saveScrollPosition,const DeepCollectionEquality().hash(_scrollOffset),const DeepCollectionEquality().hash(_baaniOrderedIds),const DeepCollectionEquality().hash(_readingSessions),dailyGoalMinutes,totalReadingDuration,totalSessionsCount,currentStreak,lastReadDate);

@override
String toString() {
  return 'AppOptions(themeName: $themeName, bold: $bold, showStatus: $showStatus, textScaleValue: $textScaleValue, languageName: $languageName, screenAwake: $screenAwake, saveScrollPosition: $saveScrollPosition, scrollOffset: $scrollOffset, baaniOrderedIds: $baaniOrderedIds, readingSessions: $readingSessions, dailyGoalMinutes: $dailyGoalMinutes, totalReadingDuration: $totalReadingDuration, totalSessionsCount: $totalSessionsCount, currentStreak: $currentStreak, lastReadDate: $lastReadDate)';
}


}

/// @nodoc
abstract mixin class _$AppOptionsCopyWith<$Res> implements $AppOptionsCopyWith<$Res> {
  factory _$AppOptionsCopyWith(_AppOptions value, $Res Function(_AppOptions) _then) = __$AppOptionsCopyWithImpl;
@override @useResult
$Res call({
 String themeName, bool bold, bool showStatus, double textScaleValue, String languageName, bool screenAwake, bool saveScrollPosition, Map<String, ScrollInfo> scrollOffset, List<dynamic> baaniOrderedIds, List<ReadingSession> readingSessions, int dailyGoalMinutes, int totalReadingDuration, int totalSessionsCount, int currentStreak, DateTime? lastReadDate
});




}
/// @nodoc
class __$AppOptionsCopyWithImpl<$Res>
    implements _$AppOptionsCopyWith<$Res> {
  __$AppOptionsCopyWithImpl(this._self, this._then);

  final _AppOptions _self;
  final $Res Function(_AppOptions) _then;

/// Create a copy of AppOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeName = null,Object? bold = null,Object? showStatus = null,Object? textScaleValue = null,Object? languageName = null,Object? screenAwake = null,Object? saveScrollPosition = null,Object? scrollOffset = null,Object? baaniOrderedIds = null,Object? readingSessions = null,Object? dailyGoalMinutes = null,Object? totalReadingDuration = null,Object? totalSessionsCount = null,Object? currentStreak = null,Object? lastReadDate = freezed,}) {
  return _then(_AppOptions(
themeName: null == themeName ? _self.themeName : themeName // ignore: cast_nullable_to_non_nullable
as String,bold: null == bold ? _self.bold : bold // ignore: cast_nullable_to_non_nullable
as bool,showStatus: null == showStatus ? _self.showStatus : showStatus // ignore: cast_nullable_to_non_nullable
as bool,textScaleValue: null == textScaleValue ? _self.textScaleValue : textScaleValue // ignore: cast_nullable_to_non_nullable
as double,languageName: null == languageName ? _self.languageName : languageName // ignore: cast_nullable_to_non_nullable
as String,screenAwake: null == screenAwake ? _self.screenAwake : screenAwake // ignore: cast_nullable_to_non_nullable
as bool,saveScrollPosition: null == saveScrollPosition ? _self.saveScrollPosition : saveScrollPosition // ignore: cast_nullable_to_non_nullable
as bool,scrollOffset: null == scrollOffset ? _self._scrollOffset : scrollOffset // ignore: cast_nullable_to_non_nullable
as Map<String, ScrollInfo>,baaniOrderedIds: null == baaniOrderedIds ? _self._baaniOrderedIds : baaniOrderedIds // ignore: cast_nullable_to_non_nullable
as List<dynamic>,readingSessions: null == readingSessions ? _self._readingSessions : readingSessions // ignore: cast_nullable_to_non_nullable
as List<ReadingSession>,dailyGoalMinutes: null == dailyGoalMinutes ? _self.dailyGoalMinutes : dailyGoalMinutes // ignore: cast_nullable_to_non_nullable
as int,totalReadingDuration: null == totalReadingDuration ? _self.totalReadingDuration : totalReadingDuration // ignore: cast_nullable_to_non_nullable
as int,totalSessionsCount: null == totalSessionsCount ? _self.totalSessionsCount : totalSessionsCount // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,lastReadDate: freezed == lastReadDate ? _self.lastReadDate : lastReadDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
