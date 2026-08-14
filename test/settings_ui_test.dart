import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:nitnem/state/appoptions.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/providers/path_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSettings extends Settings {
  AppOptions _options;
  MockSettings(this._options);

  @override
  FutureOr<AppOptions> build() => _options;

  @override
  Future<void> toggleBold(bool isBold) async {
    state = AsyncData(state.value!.copyWith(bold: isBold));
  }

  @override
  Future<void> toggleStatus(bool showStatus) async {
    state = AsyncData(state.value!.copyWith(showStatus: showStatus));
  }

  @override
  Future<void> changeTheme(String themeName) async {
    state = AsyncData(state.value!.copyWith(themeName: themeName));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Settings UI Tests', () {
    late AppOptions initialOptions;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      initialOptions = AppOptions.initial();
    });

    testWidgets('Theme changes correctly in MaterialApp', (tester) async {
      final container = ProviderContainer(
        overrides: [
          settingsProvider.overrideWith(() => MockSettings(initialOptions.copyWith(themeName: 'ThemeName.Default'))),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: NitnemApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Check initial theme (Default is light)
      MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.theme?.brightness, Brightness.light);

      // Change theme to Stars (which is dark)
      await container.read(settingsProvider.notifier).changeTheme('ThemeName.Stars');
      await tester.pumpAndSettle();

      app = tester.widget(find.byType(MaterialApp));
      expect(app.theme?.brightness, Brightness.dark);
    });

    testWidgets('Bold unbold happens correctly in ReaderScreen', (tester) async {
      // Setup reader state so we are on a path
      final container = ProviderContainer(
        overrides: [
          settingsProvider.overrideWith(() => MockSettings(initialOptions.copyWith(bold: false))),
          pathDataProvider.overrideWith((ref) => 'Dummy Baani Content'),
        ],
      );
      
      // Manually set a path in reader state
      container.read(readerProvider.notifier).setPath(id: 1, title: 'Japji Sahib', filePrefix: 'japji');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: NitnemApp(),
        ),
      );

      await tester.pumpAndSettle();
      
      // Navigate to reader
      await tester.tap(find.text('Japji Sahib'));
      await tester.pumpAndSettle();

      // Find the Baani text
      Text textWidget = tester.widget(find.text('Dummy Baani Content'));
      expect(textWidget.style?.fontWeight, FontWeight.normal);

      // Toggle bold
      await container.read(settingsProvider.notifier).toggleBold(true);
      await tester.pumpAndSettle();

      textWidget = tester.widget(find.text('Dummy Baani Content'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('Status bar visibility toggles correctly in ReaderScreen', (tester) async {
      final container = ProviderContainer(
        overrides: [
          settingsProvider.overrideWith(() => MockSettings(initialOptions.copyWith(showStatus: false))),
          pathDataProvider.overrideWith((ref) => 'Dummy Baani Content'),
        ],
      );
      
      container.read(readerProvider.notifier).setPath(id: 1, title: 'Japji Sahib', filePrefix: 'japji');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: NitnemApp(),
        ),
      );

      await tester.pumpAndSettle();
      
      // Navigate to reader
      await tester.tap(find.text('Japji Sahib'));
      await tester.pumpAndSettle();

      // Status bar should not be present initially
      expect(find.text('0.00%'), findsNothing);

      // Toggle status bar on
      await container.read(settingsProvider.notifier).toggleStatus(true);
      await tester.pumpAndSettle();

      // Status bar should be present now (contains the scroll percentage)
      expect(find.text('0.00%'), findsOneWidget);
    });
  });
}
