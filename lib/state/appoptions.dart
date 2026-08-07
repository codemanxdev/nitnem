import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nitnem/constants/sharedprefkeys.dart';
import 'package:nitnem/data/languagedata.dart';
import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/models/themes.dart';

@immutable
@JsonSerializable()
class AppOptions {
  AppOptions({
    required this.themeName,
    required this.bold,
    required this.showStatus,
    required this.textScaleValue,
    required this.languageName,
    required this.screenAwake,
    required this.saveScrollPosition,
    required this.scrollOffset,
    required this.baaniOrderedIds,
    required this.readingSessions,
    required this.dailyGoalMinutes,
    required this.totalReadingDuration,
    required this.totalSessionsCount,
    required this.currentStreak,
    this.lastReadDate,
  });

  final String themeName;
  final bool bold;
  final bool showStatus;
  final double textScaleValue;
  final String languageName;
  final bool screenAwake;
  final bool saveScrollPosition;
  final Map<String, ScrollInfo> scrollOffset;
  final List<dynamic> baaniOrderedIds;
  final List<ReadingSession> readingSessions;
  final int dailyGoalMinutes;
  final int totalReadingDuration;
  final int totalSessionsCount;
  final int currentStreak;
  final DateTime? lastReadDate;

  factory AppOptions.initial() => AppOptions(
    themeName: ThemeName.Default.toString(),
    bold: false,
    showStatus: false,
    textScaleValue: 1.0,
    languageName: languages[0].toString(),
    screenAwake: false,
    saveScrollPosition: false,
    scrollOffset: new Map.fromIterable(
      PathTileData.items,
      key: (v) => v.id.toString(),
      value: (v) => new ScrollInfo(v.id, 0.0, 0.0),
    ),
    baaniOrderedIds: PathTileData.items.map((item) => item.id).toList(),
    readingSessions: [],
    dailyGoalMinutes: 20,
    totalReadingDuration: 0,
    totalSessionsCount: 0,
    currentStreak: 0,
    lastReadDate: null,
  );

  AppOptions copyWith({
    String? themeName,
    bool? bold,
    bool? showStatus,
    double? textScaleValue,
    String? languageName,
    bool? screenAwake,
    bool? saveScrollPosition,
    Map<String, ScrollInfo>? scrollOffset,
    List<dynamic>? baaniOrderedIds,
    List<ReadingSession>? readingSessions,
    int? dailyGoalMinutes,
    int? totalReadingDuration,
    int? totalSessionsCount,
    int? currentStreak,
    DateTime? lastReadDate,
  }) {
    return AppOptions(
      themeName: themeName ?? this.themeName,
      bold: bold ?? this.bold,
      showStatus: showStatus ?? this.showStatus,
      textScaleValue: textScaleValue ?? this.textScaleValue,
      languageName: languageName ?? this.languageName,
      screenAwake: screenAwake ?? this.screenAwake,
      saveScrollPosition: saveScrollPosition ?? this.saveScrollPosition,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      baaniOrderedIds: baaniOrderedIds ?? this.baaniOrderedIds,
      readingSessions: readingSessions ?? this.readingSessions,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      totalReadingDuration: totalReadingDuration ?? this.totalReadingDuration,
      totalSessionsCount: totalSessionsCount ?? this.totalSessionsCount,
      currentStreak: currentStreak ?? this.currentStreak,
      lastReadDate: lastReadDate ?? this.lastReadDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType) return false;
    final AppOptions typedOther = other as AppOptions;
    return themeName == typedOther.themeName &&
        bold == typedOther.bold &&
        showStatus == typedOther.showStatus &&
        textScaleValue == typedOther.textScaleValue &&
        languageName == typedOther.languageName &&
        screenAwake == typedOther.screenAwake &&
        saveScrollPosition == typedOther.saveScrollPosition &&
        scrollOffset == typedOther.scrollOffset &&
        baaniOrderedIds == typedOther.baaniOrderedIds &&
        listEquals(readingSessions, typedOther.readingSessions) &&
        dailyGoalMinutes == typedOther.dailyGoalMinutes &&
        totalReadingDuration == typedOther.totalReadingDuration &&
        totalSessionsCount == typedOther.totalSessionsCount &&
        currentStreak == typedOther.currentStreak &&
        lastReadDate == typedOther.lastReadDate;
  }

  @override
  int get hashCode => Object.hashAll([
    themeName,
    bold,
    showStatus,
    textScaleValue,
    languageName,
    screenAwake,
    saveScrollPosition,
    scrollOffset,
    baaniOrderedIds,
    readingSessions,
    dailyGoalMinutes,
    totalReadingDuration,
    totalSessionsCount,
    currentStreak,
    lastReadDate,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map[SharedPrefKeys.THEME_NAME] = this.themeName;
    map[SharedPrefKeys.BOLD] = this.bold;
    map[SharedPrefKeys.SHOW_STATUS] = this.showStatus;
    map[SharedPrefKeys.TEXT_SCALE_VALUE] = this.textScaleValue;
    map[SharedPrefKeys.LANGUAGE_NAME] = this.languageName;
    map[SharedPrefKeys.SCREEN_AWAKE] = this.screenAwake;
    map[SharedPrefKeys.SAVE_SCROLL_POSITION] = this.saveScrollPosition;
    map[SharedPrefKeys.SCROLL_OFFSET] = json.encode(this.scrollOffset);
    map[SharedPrefKeys.BAANI_ORDERED_IDS] = this.baaniOrderedIds;
    map[SharedPrefKeys.READING_SESSIONS] =
        this.readingSessions.map((s) => s.toJson()).toList();
    map[SharedPrefKeys.DAILY_GOAL_MINUTES] = this.dailyGoalMinutes;
    map[SharedPrefKeys.TOTAL_READING_DURATION] = this.totalReadingDuration;
    map[SharedPrefKeys.TOTAL_SESSIONS_COUNT] = this.totalSessionsCount;
    map[SharedPrefKeys.CURRENT_STREAK] = this.currentStreak;
    map[SharedPrefKeys.LAST_READ_DATE] = this.lastReadDate?.toIso8601String();
    return map;
  }

  @override
  String toString() {
    //construct scroll position offsets
    String pos = "";
    scrollOffset.forEach((k, v) => pos += "$k: ${v.scrollOffset}, ");

    return '[theme: $themeName, bold: $bold, status: $showStatus, scale: $textScaleValue, lang: $languageName, '
        'awake: $screenAwake, savepos: $saveScrollPosition, pos: $pos, order: $baaniOrderedIds]';
  }
}
