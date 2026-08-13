import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/models/scrollinfo.dart';
import 'package:nitnem/persistence/persistence.dart';
import 'package:nitnem/state/appoptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  FutureOr<AppOptions> build() async {
    return await loadOptionsFromPrefs();
  }

  Future<void> toggleBold(bool isBold) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(bold: isBold);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> toggleStatus(bool showStatus) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(showStatus: showStatus);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> changeTheme(String themeName) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(themeName: themeName);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> changeLanguage(String languageName) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(languageName: languageName);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> updateTextScale(double scale) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(textScaleValue: scale);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> toggleScreenAwake(bool isAwake) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(screenAwake: isAwake);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
    // Note: WakelockPlus handling will be done in the UI or a listener
  }

  Future<void> toggleReadingPositionSave(bool savePos) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(saveScrollPosition: savePos);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> updateScrollOffset(ScrollInfo scrollInfo) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final scrollOffsets = Map<String, ScrollInfo>.from(stateValue.scrollOffset);
    scrollOffsets[scrollInfo.id.toString()] = scrollInfo;

    final newState = stateValue.copyWith(scrollOffset: scrollOffsets);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> updateBaaniOrder(List<dynamic> baaniOrder) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(baaniOrderedIds: baaniOrder);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> resetBaaniOrder() async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(
      baaniOrderedIds: PathTileData.defaultOrderIds,
    );
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> changeDailyGoal(int minutes) async {
    final stateValue = state.value;
    if (stateValue == null) return;

    final newState = stateValue.copyWith(dailyGoalMinutes: minutes);
    state = AsyncData(newState);
    saveOptionsToPrefs(newState);
  }

  Future<void> saveReadingSession(
    AppOptions updatedOptions,
  ) async {
    state = AsyncData(updatedOptions);
    saveOptionsToPrefs(updatedOptions);
  }
}
