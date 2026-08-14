// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appoptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppOptions _$AppOptionsFromJson(Map<String, dynamic> json) => _AppOptions(
  themeName: json['themeName'] as String,
  bold: json['bold'] as bool,
  showStatus: json['showStatus'] as bool,
  textScaleValue: (json['textScaleValue'] as num).toDouble(),
  languageName: json['languageName'] as String,
  screenAwake: json['screenAwake'] as bool,
  saveScrollPosition: json['saveScrollPosition'] as bool,
  scrollOffset: (json['scrollOffset'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, ScrollInfo.fromJson(e as Map<String, dynamic>)),
  ),
  baaniOrderedIds: json['baaniOrderedIds'] as List<dynamic>,
  readingSessions: (json['readingSessions'] as List<dynamic>)
      .map((e) => ReadingSession.fromJson(e as Map<String, dynamic>))
      .toList(),
  dailyGoalMinutes: (json['dailyGoalMinutes'] as num).toInt(),
  totalReadingDuration: (json['totalReadingDuration'] as num).toInt(),
  totalSessionsCount: (json['totalSessionsCount'] as num).toInt(),
  currentStreak: (json['currentStreak'] as num).toInt(),
  lastReadDate: json['lastReadDate'] == null
      ? null
      : DateTime.parse(json['lastReadDate'] as String),
);

Map<String, dynamic> _$AppOptionsToJson(_AppOptions instance) =>
    <String, dynamic>{
      'themeName': instance.themeName,
      'bold': instance.bold,
      'showStatus': instance.showStatus,
      'textScaleValue': instance.textScaleValue,
      'languageName': instance.languageName,
      'screenAwake': instance.screenAwake,
      'saveScrollPosition': instance.saveScrollPosition,
      'scrollOffset': instance.scrollOffset,
      'baaniOrderedIds': instance.baaniOrderedIds,
      'readingSessions': instance.readingSessions,
      'dailyGoalMinutes': instance.dailyGoalMinutes,
      'totalReadingDuration': instance.totalReadingDuration,
      'totalSessionsCount': instance.totalSessionsCount,
      'currentStreak': instance.currentStreak,
      'lastReadDate': instance.lastReadDate?.toIso8601String(),
    };
