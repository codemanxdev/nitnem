import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/pages/readerscreen.dart';
import 'package:nitnem/persistence/persistence.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/redux/store/store.dart';
import 'package:backdrop/backdrop.dart';
import 'package:device_frame/device_frame.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Capture screenshots for Play Store', (WidgetTester tester) async {
    print('🚀 Initializing app with device frame...');
    
    // Initialize state manually to wrap the app in a DeviceFrame
    final options = await loadOptionsFromPrefs();
    final store = createStore(options);
    
    // Set required options before starting
    store.dispatch(OptionsLoadedAction(options));
    store.dispatch(ToggleBoldAction(true));
    store.dispatch(ToggleStatusAction(true));
    store.dispatch(ToggleScreenAwakeAction(true));
    store.dispatch(ToggleReadingPositionSaveAction(true));
    store.dispatch(TextScaleAction(1.33));
    
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Colors.transparent, // Transparent background for the frame
          child: DeviceFrame(
            device: Devices.android.googlePixel9,
            isFrameVisible: true,
            orientation: Orientation.portrait,
            screen: NitnemApp(store),
          ),
        ),
      ),
    );
    await tester.pump();

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
      // pumpAndSettle with a duration ensures transient tap indicators fade out
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      
      await binding.takeScreenshot(name);
      await tester.pump(const Duration(milliseconds: 500));
    }

    // Helper to tap and wait for state change
    Future<void> tapChip(String label, {bool isTheme = false, String? expectedValue}) async {
      print('🔘 Selecting ${isTheme ? "theme" : "language"}: $label...');
      final String targetValue = isTheme ? expectedValue! : label;
      
      // We use dispatch as the primary mechanism because DeviceFrame scaling + SliverAppBar FlexibleSpace
      // makes UI hit-testing extremely fragile in integration tests.
      if (isTheme) {
        store.dispatch(ChangeThemeAction(targetValue));
      } else {
        store.dispatch(ChangeLanguageAndFetchNitnemPathAction(targetValue, store.state.pathFilePrefix));
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
