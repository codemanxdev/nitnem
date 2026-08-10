import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/models/themes.dart';
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
    final japjiSahibTile = PathTileData.items.first;
    await tester.tap(find.text('Japji Sahib'));
    await tester.pumpAndSettle();

    print('📸 Capturing Path Gurmukhi...');
    await binding.takeScreenshot('path-gurmukhi');
    await tester.pump(const Duration(milliseconds: 500));

    // 4. Path Hindi
    print('🔘 Switching to Hindi...');
    store.dispatch(FetchNitnemPathAction(japjiSahibTile, 'Hindi'));
    await tester.pumpAndSettle();

    print('📸 Capturing Path Hindi...');
    await binding.takeScreenshot('path-hindi');
    await tester.pump(const Duration(milliseconds: 500));

    // 5. Path English
    print('🔘 Switching to English...');
    store.dispatch(FetchNitnemPathAction(japjiSahibTile, 'English'));
    await tester.pumpAndSettle();

    print('📸 Capturing Path English...');
    await binding.takeScreenshot('path-english');
    await tester.pump(const Duration(milliseconds: 500));

    // --- Themes ---
    
    // 6. Forest Theme
    print('🎨 Switching to Forest Theme...');
    store.dispatch(ChangeThemeAction(ThemeName.Forest.toString()));
    await tester.pumpAndSettle();
    
    print('📸 Capturing Forest Theme...');
    await binding.takeScreenshot('foresttheme');
    await tester.pump(const Duration(milliseconds: 500));

    // 7. Stars Theme (Dark)
    print('🎨 Switching to Stars Theme...');
    store.dispatch(ChangeThemeAction(ThemeName.Stars.toString()));
    await tester.pumpAndSettle();

    print('📸 Capturing Dark Theme...');
    await binding.takeScreenshot('darktheme');
    await tester.pump(const Duration(milliseconds: 500));

    // 8. Wood Theme
    print('🎨 Switching to Wood Theme...');
    store.dispatch(ChangeThemeAction(ThemeName.Wood.toString()));
    await tester.pumpAndSettle();

    print('📸 Capturing Wood Theme...');
    await binding.takeScreenshot('woodtheme');
    await tester.pump(const Duration(milliseconds: 500));

    print('✅ Screenshot generation complete!');
  });
}

extension on WidgetTester {
}
