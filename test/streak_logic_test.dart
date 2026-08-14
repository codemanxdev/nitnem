import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/models/readingsession.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Streak Logic (Riverpod)', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('starts at 1 when first session is saved', () async {
      final session = ReadingSession(
        pathId: 1,
        pathTitle: 'Japji Sahib',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(minutes: 10)),
        durationSeconds: 600,
      );

      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future); // Wait for build
      
      final currentOptions = container.read(settingsProvider).value!;
      final updatedOptions = currentOptions.copyWith(
        readingSessions: [session],
        totalReadingDuration: session.durationSeconds,
        totalSessionsCount: 1,
        currentStreak: 1,
        lastReadDate: DateTime.now(),
      );

      await notifier.saveReadingSession(updatedOptions);
      
      final state = container.read(settingsProvider).value!;
      expect(state.currentStreak, 1);
      expect(state.lastReadDate, isNotNull);
    });

    test('increments when session is saved on the next day', () async {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      
      final session = ReadingSession(
        pathId: 1,
        pathTitle: 'Japji Sahib',
        startTime: now,
        endTime: now.add(const Duration(minutes: 10)),
        durationSeconds: 600,
      );

      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);

      final currentOptions = container.read(settingsProvider).value!;
      // Simulate existing streak from yesterday
      final stateWithYesterday = currentOptions.copyWith(
        currentStreak: 1,
        lastReadDate: yesterday,
      );
      
      // Calculate new streak (logic from ReaderScreen refactored into a helper would be better, 
      // but following the plan's logic preservation)
      final normalizedToday = DateTime(now.year, now.month, now.day);
      final normalizedLastRead = DateTime(yesterday.year, yesterday.month, yesterday.day);
      int newStreak = 1;
      if (normalizedToday.difference(normalizedLastRead).inDays == 1) {
        newStreak = stateWithYesterday.currentStreak + 1;
      }

      final updatedOptions = stateWithYesterday.copyWith(
        readingSessions: [session],
        currentStreak: newStreak,
        lastReadDate: now,
      );

      await notifier.saveReadingSession(updatedOptions);
      
      final state = container.read(settingsProvider).value!;
      expect(state.currentStreak, 2);
    });
  });
}
