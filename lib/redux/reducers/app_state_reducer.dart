import 'package:nitnem/common/printmessage.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/redux/reducers/pathdatareducer.dart';
import 'package:nitnem/redux/reducers/pathfileprefixreducer.dart';
import 'package:nitnem/redux/reducers/pathidreducer.dart';
import 'package:nitnem/redux/reducers/pathtitlereducer.dart';
import 'package:nitnem/redux/reducers/readoptionsreducer.dart';
import 'package:nitnem/redux/reducers/savescrollposreducer.dart';
import 'package:nitnem/redux/reducers/screenawakereducer.dart';
import 'package:nitnem/redux/reducers/scrollpercreducer.dart';
import 'package:nitnem/state/appoptions.dart';
import 'package:nitnem/state/appstate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'baaniorderreducer.dart';
import 'boldreducer.dart';
import 'dailygoalreducer.dart';
import 'languagereducer.dart';
import 'lifetime_stats_reducer.dart';
import 'readingsessionreducer.dart';
import 'statusreducer.dart';
import 'streak_reducer.dart';
import 'textscalereducer.dart';
import 'themereducer.dart';

AppState appReducer(AppState state, dynamic action) {
  AppState newState = state.copyWith();

  printInfoMessage('[ACTION] ${action.runtimeType}');
  if (action is TextScaleAction ||
      action is ToggleBoldAction ||
      action is ToggleStatusAction ||
      action is ChangeThemeAction ||
      action is ChangeLanguageAndFetchNitnemPathAction ||
      action is ToggleReaderOptionsAction ||
      action is NitnemPathLoadedAction ||
      action is FetchOptionsAction ||
      action is FetchNitnemPathAction ||
      action is ChangeLanguageAction ||
      action is UpdateStatusScrollPercentageAction ||
      action is ToggleScreenAwakeAction ||
      action is ClearReaderOptionsToggleAction ||
      action is ToggleReadingPositionSaveAction ||
      action is BaaniOrderChangeAction ||
      action is BaaniOrderResetAction ||
      action is SaveReadingSessionAction ||
      action is ChangeDailyGoalAction) {
    newState = AppState(
      options: AppOptions(
        themeName: themeReducer(state.options.themeName, action),
        bold: boldReducer(state.options.bold, action),
        showStatus: statusReducer(state.options.showStatus, action),
        textScaleValue: textScaleReducer(state.options.textScaleValue, action),
        languageName: languageReducer(state.options.languageName, action),
        screenAwake: screenAwakeReducer(state.options.screenAwake, action),
        saveScrollPosition: saveScrollPosReducer(
          state.options.saveScrollPosition,
          action,
        ),
        scrollOffset: scrollPercReducer(state.options.scrollOffset, action),
        baaniOrderedIds: baaniOrderIdReducer(
          state.options.baaniOrderedIds,
          action,
        ),
        readingSessions: readingSessionReducer(state.options.readingSessions, action),
        dailyGoalMinutes: dailyGoalReducer(state.options.dailyGoalMinutes, action),
        totalReadingDuration: totalDurationReducer(state.options.totalReadingDuration, action),
        totalSessionsCount: totalSessionsCountReducer(state.options.totalSessionsCount, action),
        currentStreak: currentStreakReducer(state.options, action),
        lastReadDate: lastReadDateReducer(state.options.lastReadDate, action),
      ),
      showReaderOptions: readerOptionsReducer(state.showReaderOptions, action),
      pathData: pathDataReducer(state.pathData, action),
      pathFilePrefix: pathFilePrefixReducer(state.pathFilePrefix, action),
      pathTitle: pathTitleReducer(state.pathTitle, action),
      pathId: pathIdReducer(state.pathId, action),
    );
    printInfoMessage('Option Changed');
  }

  if (action is OptionsLoadedAction) {
    newState = state.copyWith(options: action.options);
    printInfoMessage('Options Loaded');
  }

  if (action is SendFeedbackAction) {
    newState = state;
    printInfoMessage('Sending feedback');
    launchUrl(Uri.parse(AppConstants.FEEDBACK_URL));
  }

  printInfoMessage('[STATE] ${newState.toString()}');
  return newState;
}
