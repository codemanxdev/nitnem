import 'package:nitnem/models/pathtile.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/state/appoptions.dart';

class ChangeThemeAction {
  final String themeName;

  ChangeThemeAction(this.themeName);
}

class ChangeLanguageAction {
  final String language;

  ChangeLanguageAction(this.language);
}

class ChangeLanguageAndFetchNitnemPathAction {
  final String language;
  final String pathFilePrefix;

  ChangeLanguageAndFetchNitnemPathAction(this.language, this.pathFilePrefix);
}

class TextScaleAction {
  final double scale;

  TextScaleAction(this.scale);
}

class ToggleBoldAction {
  final bool isBold;

  ToggleBoldAction(this.isBold);
}

class ToggleStatusAction {
  final bool showStatus;

  ToggleStatusAction(this.showStatus);
}

class OptionsNotLoadedAction {}

class OptionsLoadedAction {
  final AppOptions options;

  OptionsLoadedAction(this.options);
}

class FetchOptionsAction {}

class ToggleReaderOptionsAction {}

class ClearReaderOptionsToggleAction {}

class NitnemPathLoadedAction {
  final String pathData;

  NitnemPathLoadedAction(this.pathData);
}

class FetchNitnemPathAction {
  final PathTile path;
  final String languageName;

  FetchNitnemPathAction(this.path, this.languageName);
}

class SendFeedbackAction {}

class BaaniOrderChangeAction {}

class BaaniOrderResetAction {}

class BaaniOrderSaveAction {
  final List<dynamic> baaniOrder;

  BaaniOrderSaveAction(this.baaniOrder);
}

class UpdateStatusScrollPercentageAction {
  final ScrollInfo scrollInfo;

  UpdateStatusScrollPercentageAction(this.scrollInfo);
}

class ToggleScreenAwakeAction {
  final bool isAwake;

  ToggleScreenAwakeAction(this.isAwake);
}

class ToggleReadingPositionSaveAction {
  final bool savePos;

  ToggleReadingPositionSaveAction(this.savePos);
}

class ChangeDailyGoalAction {
  final int minutes;

  ChangeDailyGoalAction(this.minutes);
}

class SaveReadingSessionAction {
  final ReadingSession session;
  final DateTime timestamp;

  SaveReadingSessionAction(this.session, this.timestamp);
}
