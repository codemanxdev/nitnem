import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Stats Logic (Riverpod)', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('accumulates total duration and session count', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);

      final session1 = ReadingSession(
        pathId: 1,
        pathTitle: 'Japji Sahib',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(minutes: 10)),
        durationSeconds: 600,
      );

      final options1 = container.read(settingsProvider).value!.copyWith(
        readingSessions: [session1],
        totalReadingDuration: 600,
        totalSessionsCount: 1,
      );
      
      await notifier.saveReadingSession(options1);
      
      var state = container.read(settingsProvider).value!;
      expect(state.totalReadingDuration, 600);
      expect(state.totalSessionsCount, 1);

      final session2 = ReadingSession(
        pathId: 2,
        pathTitle: 'Jaap Sahib',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(minutes: 15)),
        durationSeconds: 900,
      );

      final options2 = state.copyWith(
        readingSessions: [...state.readingSessions, session2],
        totalReadingDuration: state.totalReadingDuration + 900,
        totalSessionsCount: state.totalSessionsCount + 1,
      );
      
      await notifier.saveReadingSession(options2);
      
      state = container.read(settingsProvider).value!;
      expect(state.totalReadingDuration, 1500);
      expect(state.totalSessionsCount, 2);
    });

    test('changeDailyGoal updates goal minutes', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      await notifier.changeDailyGoal(45);
      
      final state = container.read(settingsProvider).value!;
      expect(state.dailyGoalMinutes, 45);
    });
  });
}
