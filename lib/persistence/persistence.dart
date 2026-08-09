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
        themeName: prefs[SharedPrefKeys.THEME_NAME],
        bold: prefs[SharedPrefKeys.BOLD],
        showStatus: prefs[SharedPrefKeys.SHOW_STATUS],
        textScaleValue: prefs[SharedPrefKeys.TEXT_SCALE_VALUE],
        languageName: prefs[SharedPrefKeys.LANGUAGE_NAME],
        screenAwake: prefs[SharedPrefKeys.SCREEN_AWAKE],
        saveScrollPosition: prefs[SharedPrefKeys.SAVE_SCROLL_POSITION],
        scrollOffset: constructScrollPosMap(
          prefs[SharedPrefKeys.SCROLL_OFFSET],
        ),
        baaniOrderedIds: prefs[SharedPrefKeys.BAANI_ORDERED_IDS],
        readingSessions: (prefs[SharedPrefKeys.READING_SESSIONS] as List?)
            ?.map((s) => ReadingSession.fromJson(s))
            .toList() ?? [],
        dailyGoalMinutes: prefs[SharedPrefKeys.DAILY_GOAL_MINUTES] ?? 20,
        totalReadingDuration: prefs[SharedPrefKeys.TOTAL_READING_DURATION] ?? 0,
        totalSessionsCount: prefs[SharedPrefKeys.TOTAL_SESSIONS_COUNT] ?? 0,
        currentStreak: prefs[SharedPrefKeys.CURRENT_STREAK] ?? 0,
        lastReadDate: prefs[SharedPrefKeys.LAST_READ_DATE] != null
            ? DateTime.parse(prefs[SharedPrefKeys.LAST_READ_DATE])
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

Map<String, ScrollInfo> constructScrollPosMap(String scrollPosString) {
  Map<String, dynamic> rawInfo;
  Map<String, ScrollInfo> scrollInfo = new Map<String, ScrollInfo>();

  if (scrollPosString != '') {
    //Raw data contains maps, convert map info into ScrollInfo
    rawInfo = json.decode(scrollPosString);
    rawInfo.forEach(
      (k, v) => scrollInfo.putIfAbsent(
        k,
        () => new ScrollInfo(v["id"], v["scrollOffset"], v["maxOffset"]),
      ),
    );
  } else {
    scrollInfo = new Map.fromIterable(
      PathTileData.items,
      key: (v) => v.id.toString(),
      value: (v) => new ScrollInfo(v.id, 0.0, 0.0),
    );
  }

  return scrollInfo;
}
