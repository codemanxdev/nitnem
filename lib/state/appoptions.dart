import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nitnem/data/languagedata.dart';
import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/models/themes.dart';

part 'appoptions.freezed.dart';
part 'appoptions.g.dart';

@freezed
abstract class AppOptions with _$AppOptions {
  const factory AppOptions({
    required String themeName,
    required bool bold,
    required bool showStatus,
    required double textScaleValue,
    required String languageName,
    required bool screenAwake,
    required bool saveScrollPosition,
    required Map<String, ScrollInfo> scrollOffset,
    required List<dynamic> baaniOrderedIds,
    required List<ReadingSession> readingSessions,
    required int dailyGoalMinutes,
    required int totalReadingDuration,
    required int totalSessionsCount,
    required int currentStreak,
    DateTime? lastReadDate,
  }) = _AppOptions;

  factory AppOptions.initial() => AppOptions(
        themeName: ThemeName.Default.toString(),
        bold: false,
        showStatus: false,
        textScaleValue: 1.0,
        languageName: languages[0].title,
        screenAwake: false,
        saveScrollPosition: false,
        scrollOffset: Map.fromIterable(
          PathTileData.items,
          key: (v) => v.id.toString(),
          value: (v) => ScrollInfo(id: v.id, scrollOffset: 0.0, maxOffset: 0.0),
        ),
        baaniOrderedIds: PathTileData.items.map((item) => item.id).toList(),
        readingSessions: [],
        dailyGoalMinutes: 20,
        totalReadingDuration: 0,
        totalSessionsCount: 0,
        currentStreak: 0,
        lastReadDate: null,
      );

  factory AppOptions.fromJson(Map<String, dynamic> json) =>
      _$AppOptionsFromJson(json);
}
