import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nitnem/app.dart';
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
    store.dispatch(OptionsLoadedAction(options));
    
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: const Color(0xFFF5F5F7), // Neutral background
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

    // 1. Main Screen
    print('📸 Capturing Main Screen...');
    await binding.takeScreenshot('mainscreen');
    await tester.pump(const Duration(milliseconds: 500));

    // 2. Options (Home Screen Backdrop)
    print('🔘 Tapping Options toggle...');
    final backdropToggle = find.byType(BackdropToggleButton).first;
    await tester.tap(backdropToggle);
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    print('📸 Capturing Options Screen...');
    await binding.takeScreenshot('options');
    await tester.pump(const Duration(milliseconds: 500));

    // Close backdrop to return to main list
    print('🔘 Closing Options toggle...');
    await tester.tap(backdropToggle);
    await tester.pumpAndSettle();

    // 3. Reader Screen (Gurmukhi) - Tap 'Japji Sahib'
    print('📖 Opening Japji Sahib...');
    await tester.tap(find.text('Japji Sahib'));
    await tester.pumpAndSettle();

    print('📸 Capturing Path Gurmukhi...');
    await binding.takeScreenshot('path-gurmukhi');
    await tester.pump(const Duration(milliseconds: 500));

    // Open Reader Options
    print('🔘 Opening Reader Options...');
    final readerOptions = find.byKey(const Key('reader_options_button'));
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    // 4. Path Hindi
    print('🔘 Switching to Hindi...');
    // We use a broader finder and ensure it's the one in the reader options
    final hindiOption = find.text('Hindi', skipOffstage: false).last;
    await tester.dragUntilVisible(
      hindiOption,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(hindiOption, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Close options to see the text clearly
    print('🔘 Closing Reader Options...');
    final closeButton = find.byKey(const Key('reader_options_button'), skipOffstage: false).last;
    await tester.tap(closeButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    print('📸 Capturing Path Hindi...');
    await binding.takeScreenshot('path-hindi');
    await tester.pump(const Duration(milliseconds: 500));

    // 5. Path English
    print('🔘 Switching to English...');
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();
    final englishOption = find.text('English', skipOffstage: false).last;
    await tester.dragUntilVisible(
      englishOption,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(englishOption, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();

    print('📸 Capturing Path English...');
    await binding.takeScreenshot('path-english');
    await tester.pump(const Duration(milliseconds: 500));

    // --- Themes ---
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();

    // 6. Forest Theme
    print('🎨 Switching to Forest Theme...');
    final forestTheme = find.text('Forest', skipOffstage: false).last;
    await tester.dragUntilVisible(
      forestTheme,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(forestTheme, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    // Close options
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();
    
    await binding.takeScreenshot('foresttheme');
    await tester.pump(const Duration(milliseconds: 500));

    // 7. Stars Theme (Dark)
    print('🎨 Switching to Stars Theme...');
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();
    final starsTheme = find.text('Stars', skipOffstage: false).last;
    await tester.dragUntilVisible(
      starsTheme,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(starsTheme, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Close options
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();

    await binding.takeScreenshot('darktheme');
    await tester.pump(const Duration(milliseconds: 500));

    // 8. Wood Theme
    print('🎨 Switching to Wood Theme...');
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();
    final woodTheme = find.text('Wood', skipOffstage: false).last;
    await tester.dragUntilVisible(
      woodTheme,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(woodTheme, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Close options
    await tester.tap(find.byKey(const Key('reader_options_button'), skipOffstage: false).last, warnIfMissed: false);
    await tester.pumpAndSettle();

    await binding.takeScreenshot('woodtheme');
    await tester.pump(const Duration(milliseconds: 500));

    print('✅ Screenshot generation complete!');
  });
}

extension on WidgetTester {
}
