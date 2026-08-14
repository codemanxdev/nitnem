import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/pages/readerscreen.dart';
import 'package:nitnem/persistence/persistence.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:nitnem/models/appoptions.dart';
import 'package:backdrop/backdrop.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockSettings extends Settings {
  final AppOptions initialOptions;
  MockSettings(this.initialOptions);

  @override
  Future<AppOptions> build() async => initialOptions;
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Capture screenshots for Play Store', (WidgetTester tester) async {
    print('🚀 Initializing app with device frame...');
    
    // Initialize state manually to wrap the app in a DeviceFrame
    final options = await loadOptionsFromPrefs();
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsProvider.overrideWith(() => MockSettings(options)),
        ],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            color: Colors.transparent, // Transparent background for the frame
            child: DeviceFrame(
              device: Devices.android.googlePixel9,
              isFrameVisible: true,
              orientation: Orientation.portrait,
              screen: NitnemApp(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    // Use container to access providers
    final container = ProviderScope.containerOf(tester.element(find.byType(NitnemApp)));
    
    // Set required options before starting
    await container.read(settingsProvider.notifier).toggleBold(true);
    await container.read(settingsProvider.notifier).toggleStatus(true);
    await container.read(settingsProvider.notifier).toggleScreenAwake(true);
    await container.read(settingsProvider.notifier).toggleReadingPositionSave(true);
    await container.read(settingsProvider.notifier).updateTextScale(1.33);

    print('⏳ Waiting for home screen...');
    // Wait for the Japji Sahib text to appear, which confirms we are on the home screen
    bool homeScreenVisible = false;
    for (int i = 0; i < 50; i++) {
      await tester.pump(const Duration(milliseconds: 200));
      // Need to find text even if it is inside the device frame's screen
      if (find.text('Japji Sahib').evaluate().isNotEmpty) {
        homeScreenVisible = true;
        break;
      }
    }
    
    if (!homeScreenVisible) {
      print('❌ Error: Home screen not visible after timeout');
      return;
    }
    
    print('✅ Home screen reached');
    await tester.pump(const Duration(seconds: 1));

    // Required for Android screenshots
    print('📸 Converting surface to image...');
    await binding.convertFlutterSurfaceToImage();
    await tester.pump(const Duration(milliseconds: 500));

    // Helper to capture screenshot without pointer/crosshair and at top
    Future<void> capture(String name) async {
      print('📸 Capturing $name...');
      
      // Ensure we are at the top of the scroll view for reader screens
      try {
        final scrollableFinder = find.byType(Scrollable);
        if (scrollableFinder.evaluate().isNotEmpty) {
          final ScrollableState state = tester.state(scrollableFinder.last);
          state.position.jumpTo(0.0);
          await tester.pump();
        }
      } catch (e) {
        print('⚠️ Could not reset scroll position for $name');
      }

      // Wait for any animations and pointer indicators to clear
      // Also wait for FutureProviders to resolve
      // Specifically for reader screens, wait for the actual path text to appear
      if (name.contains('path') || name.contains('theme')) {
        bool loaded = false;
        for (int i = 0; i < 40; i++) {
          await tester.pump(const Duration(milliseconds: 500));
          // Use a more robust check for the Baani text
          final textFinder = find.byType(Text, skipOffstage: false);
          final textWidgets = tester.widgetList<Text>(textFinder);
          
          for (final widget in textWidgets) {
            final text = widget.data ?? '';
            if (text.length > 200) { // Baanis are long
              loaded = true;
              break;
            }
          }
          if (loaded) break;
        }
      }

      await tester.pumpAndSettle();
      
      await binding.takeScreenshot(name);
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
      
      // Visually update the UI if possible, but don't fail if it's tricky
      try {
        final chipFinder = find.widgetWithText(ChoiceChip, label, skipOffstage: false);
        if (chipFinder.evaluate().isNotEmpty) {
          // We just pump enough to show the selection visually if needed, 
          // but we won't tap if it might disturb the scroll position.
          await tester.pumpAndSettle();
        }
      } catch (e) {}
      
      // Guarantee any async loading (assets/fonts/images) has time to settle
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    }

    // 1. Options (Home Screen Backdrop)
    print('🎨 Selecting Default Theme via UI...');
    final backdropToggle = find.byType(BackdropToggleButton).first;
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();

    final defaultTheme = find.widgetWithText(ChoiceChip, 'Default', skipOffstage: false).last;
    await tester.ensureVisible(defaultTheme);
    await tester.pumpAndSettle();
    await tester.tap(defaultTheme, warnIfMissed: false);
    await tester.pumpAndSettle();

    await capture('options');

    // 2. Main Screen
    print('🔘 Closing options menu...');
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();

    await capture('mainscreen');

    // 3. Reader Screen (Gurmukhi) - Tap 'Japji Sahib'
    print('📖 Opening Japji Sahib...');
    await tester.tap(find.text('Japji Sahib'));
    await tester.pumpAndSettle();

    await capture('path-gurmukhi');

    // 4. Path Hindi
    print('🔘 Switching to Hindi via UI...');
    await tester.pump(const Duration(seconds: 1));
    final optionsButton = find.byKey(const Key('reader_options_button'), skipOffstage: false).last;
    
    print('🔘 Opening options menu...');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await tapChip('Hindi');

    // Close options to see the text
    print('🔘 Closing options menu...');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    await capture('path-hindi');

    // 5. Path English
    print('🔘 Switching to English via UI...');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await tapChip('English');
    
    // Close options
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    await capture('path-english');

    // --- Themes ---
    
    // 6. Forest Theme
    print('🎨 Switching to Forest Theme via UI...');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await tapChip('Forest', isTheme: true, expectedValue: 'ThemeName.Forest');
    
    // Close options
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await capture('foresttheme');

    // 7. Wood Theme
    print('🎨 Switching to Wood Theme via UI...');
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await tapChip('Wood', isTheme: true, expectedValue: 'ThemeName.Wood');
    
    // Close options
    await tester.tap(optionsButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    await capture('woodtheme');

    // 8. Stars Theme (Dark) on Main Screen
    print('🏠 Going back to Home Screen for Dark Theme...');
    final BuildContext readerContext = tester.element(find.byType(ReaderScreen));
    Navigator.of(readerContext).pop();
    await tester.pumpAndSettle();

    print('🎨 Switching to Stars Theme (Dark) via UI...');
    // Open home screen backdrop options
    final homeBackdropToggle = find.byType(BackdropToggleButton).first;
    await tester.tap(homeBackdropToggle);
    await tester.pumpAndSettle();

    print('🔘 Selecting Stars theme...');
    final starsTheme = find.widgetWithText(ChoiceChip, 'Stars', skipOffstage: false).last;
    await tester.ensureVisible(starsTheme);
    await tester.pumpAndSettle();
    await tester.tap(starsTheme, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Close backdrop
    await tester.tap(homeBackdropToggle);
    await tester.pumpAndSettle();

    await capture('darktheme');

    print('✅ Screenshot generation complete!');
  });
}

extension on WidgetTester {
}
