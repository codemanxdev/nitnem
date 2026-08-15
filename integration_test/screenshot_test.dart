import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/pages/readerscreen.dart';
import 'package:nitnem/persistence/persistence.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:nitnem/providers/system_providers.dart';
import 'package:nitnem/models/appoptions.dart';
import 'package:backdrop/backdrop.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockSettings extends Settings {
  final AppOptions initialOptions;
  MockSettings(this.initialOptions);

  @override
  FutureOr<AppOptions> build() async => initialOptions;
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const String deviceType = String.fromEnvironment('DEVICE_TYPE', defaultValue: 'phone');
  final bool isTablet = deviceType == 'tablet';
  
  // Explicitly select the correct frame
  final device = isTablet 
      ? Devices.android.mediumTablet 
      : Devices.android.googlePixel9;
  
  final category = isTablet ? 'android-tablet' : 'android-phone';
  final orientation = Orientation.portrait; // Force portrait for both

  testWidgets('Capture screenshots for Play Store ($category)', (WidgetTester tester) async {
    print('🚀 Initializing app with device frame for $category...');
    
    final options = await loadOptionsFromPrefs();
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsProvider.overrideWith(() => MockSettings(options)),
          currentTimeProvider.overrideWith((ref) => Stream.value('12:00 PM')),
          batteryLevelProvider.overrideWith((ref) => Stream.value(100)),
        ],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            color: Colors.transparent,
            child: DeviceFrame(
              device: device,
              isFrameVisible: true, // Restore the device border/frame
              orientation: orientation,
              screen: NitnemApp(),
            ),
          ),
        ),
      ),
    );

    // Wait for the splash screen to finish (3.5s + some buffer)
    print('⏳ Waiting for splash screen...');
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(tester.element(find.byType(NitnemApp)));
    
    // Set required options
    await container.read(settingsProvider.notifier).toggleBold(true);
    await container.read(settingsProvider.notifier).toggleStatus(true);
    await container.read(settingsProvider.notifier).toggleReadingPositionSave(true);
    await container.read(settingsProvider.notifier).updateTextScale(isTablet ? 1.5 : 1.33);
    await tester.pumpAndSettle();

    print('📸 Converting surface to image...');
    await binding.convertFlutterSurfaceToImage();
    await tester.pump(const Duration(milliseconds: 500));

    // Helper to capture screenshot
    Future<void> capture(String name) async {
      print('📸 Capturing $name...');
      
      try {
        final scrollableFinder = find.byType(Scrollable);
        if (scrollableFinder.evaluate().isNotEmpty) {
          final ScrollableState state = tester.state(scrollableFinder.last);
          state.position.jumpTo(0.0);
          await tester.pump();
        }
      } catch (e) {}

      // Specifically for reader screens, wait for the actual path text to appear
      if (name.contains('path') || name.contains('theme')) {
        for (int i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 500));
          final textFinder = find.byType(Text, skipOffstage: false);
          final textWidgets = tester.widgetList<Text>(textFinder);
          if (textWidgets.any((t) => (t.data?.length ?? 0) > 200)) {
            break;
          }
        }
      }

      await tester.pumpAndSettle();
      await binding.takeScreenshot('$category/$name');
      await tester.pump(const Duration(milliseconds: 500));
    }

    // Helper to tap and wait for state change
    Future<void> tapChip(String label, {bool isTheme = false, String? expectedValue}) async {
      print('🔘 Selecting ${isTheme ? "theme" : "language"}: $label...');
      final String targetValue = isTheme ? expectedValue! : label;
      
      final container = ProviderScope.containerOf(tester.element(find.byType(NitnemApp)));

      if (isTheme) {
        await container.read(settingsProvider.notifier).changeTheme(targetValue);
      } else {
        await container.read(settingsProvider.notifier).changeLanguage(targetValue);
      }
      
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    }

    // 1. Options (Backdrop)

    final backdropToggle = find.byType(BackdropToggleButton).first;
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();
    await tapChip('Default', isTheme: true, expectedValue: 'ThemeName.Default');
    await capture('options');

    // 2. Home Screen
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();
    await capture('mainscreen');

    // 3. Reader Screen (Gurmukhi)
    await tester.tap(find.text('Japji Sahib'));
    await tester.pumpAndSettle();
    await capture('path-gurmukhi');

    // 4. Path Hindi
    final optionsButton = find.byKey(const Key('reader_options_button')).last;
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tapChip('Hindi');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await capture('path-hindi');

    // 5. Path English
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tapChip('English');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await capture('path-english');

    // 6. Forest Theme
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tapChip('Forest', isTheme: true, expectedValue: 'ThemeName.Forest');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await capture('foresttheme');

    // 7. Wood Theme
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await tapChip('Wood', isTheme: true, expectedValue: 'ThemeName.Wood');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    await capture('woodtheme');

    // 8. Stars Theme
    Navigator.of(tester.element(find.byType(ReaderScreen))).pop();
    await tester.pumpAndSettle();
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();
    await tapChip('Stars', isTheme: true, expectedValue: 'ThemeName.Stars');
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();
    await capture('darktheme');

    print('✅ Screenshot generation complete!');
  });
}
