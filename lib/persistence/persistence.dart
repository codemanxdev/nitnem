import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../common/printmessage.dart';
import '../constants/appconstants.dart';
import '../constants/sharedprefkeys.dart';
import '../data/pathtiledata.dart';
import '../models/readingsession.dart';
import '../models/scrollinfo.dart';
import '../state/appoptions.dart';

Future<AppOptions> loadOptionsFromPrefs() async {
  AppOptions options = AppOptions.initial();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var optionsString = preferences.getString(
    AppConstants.OPTIONS_SHAREDPREF_KEY,
  );
  if (optionsString != null) {
    try {
      dynamic prefs = json.decode(optionsString);

      options = options.copyWith(
        themeName: prefs[SharedPrefKeys.THEME_NAME]?.toString() ?? options.themeName,
        bold: prefs[SharedPrefKeys.BOLD] ?? options.bold,
        showStatus: prefs[SharedPrefKeys.SHOW_STATUS] ?? options.showStatus,
        textScaleValue: (prefs[SharedPrefKeys.TEXT_SCALE_VALUE] as num?)?.toDouble() ?? options.textScaleValue,
        languageName: prefs[SharedPrefKeys.LANGUAGE_NAME]?.toString() ?? options.languageName,
        screenAwake: prefs[SharedPrefKeys.SCREEN_AWAKE] ?? options.screenAwake,
        saveScrollPosition: prefs[SharedPrefKeys.SAVE_SCROLL_POSITION] ?? options.saveScrollPosition,
        scrollOffset: constructScrollPosMap(
          prefs[SharedPrefKeys.SCROLL_OFFSET],
        ),
        baaniOrderedIds: _parseBaaniOrderedIds(prefs[SharedPrefKeys.BAANI_ORDERED_IDS]) ?? options.baaniOrderedIds,
        readingSessions: _parseReadingSessions(prefs[SharedPrefKeys.READING_SESSIONS]),
        dailyGoalMinutes: prefs[SharedPrefKeys.DAILY_GOAL_MINUTES] ?? 20,
        totalReadingDuration: prefs[SharedPrefKeys.TOTAL_READING_DURATION] ?? 0,
        totalSessionsCount: prefs[SharedPrefKeys.TOTAL_SESSIONS_COUNT] ?? 0,
        currentStreak: prefs[SharedPrefKeys.CURRENT_STREAK] ?? 0,
        lastReadDate: prefs[SharedPrefKeys.LAST_READ_DATE] != null
            ? DateTime.tryParse(prefs[SharedPrefKeys.LAST_READ_DATE].toString())
            : null,
      );
    } on Exception catch (ex) {
      printErrorMessage(ex.toString());
      //If deserialisation of app options fail then perform the following.
      // 1. clear the shared prefs key
      // 2. reinit app options to default
      await preferences.clear();
      options = AppOptions.initial();
    }
  }

  printInfoMessage('[OPTIONS LOADED]');
  return options;
}

void saveOptionsToPrefs(AppOptions options) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var optionsString = json.encode(options.toJson());
  await preferences.setString(
    AppConstants.OPTIONS_SHAREDPREF_KEY,
    optionsString,
  );
  printInfoMessage('[OPTIONS SAVED]');
}

List<dynamic>? _parseBaaniOrderedIds(dynamic data) {
  if (data is List) return data;
  if (data is String && data.isNotEmpty) {
    try {
      return json.decode(data) as List;
    } catch (_) {}
  }
  return null;
}

List<ReadingSession> _parseReadingSessions(dynamic data) {
  List? list;
  if (data is List) {
    list = data;
  } else if (data is String && data.isNotEmpty) {
    try {
      list = json.decode(data) as List;
    } catch (_) {}
  }

  if (list == null) return [];

  return list
      .map((s) => ReadingSession.fromJson(s as Map<String, dynamic>))
      .toList();
}

Map<String, ScrollInfo> constructScrollPosMap(dynamic scrollPosData) {
  if (scrollPosData == null || (scrollPosData is String && scrollPosData.isEmpty)) {
    return Map.fromIterable(
      PathTileData.items,
      key: (v) => v.id.toString(),
      value: (v) => ScrollInfo(
        id: v.id,
        scrollOffset: 0.0,
        maxOffset: 0.0,
      ),
    );
  }

  Map<String, dynamic> rawInfo;
  if (scrollPosData is String) {
    rawInfo = json.decode(scrollPosData);
  } else if (scrollPosData is Map) {
    rawInfo = Map<String, dynamic>.from(scrollPosData);
  } else {
    return constructScrollPosMap(null);
  }

  Map<String, ScrollInfo> scrollInfo = {};
  rawInfo.forEach(
    (k, v) {
      if (v is Map) {
        scrollInfo[k] = ScrollInfo.fromJson(Map<String, dynamic>.from(v));
      }
    },
  );

  return scrollInfo;
}
