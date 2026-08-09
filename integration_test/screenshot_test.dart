import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nitnem/main.dart' as app;
import 'package:backdrop/backdrop.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Capture screenshots for Play Store', (WidgetTester tester) async {
    print('🚀 Initializing app...');
    app.main();
    await tester.pump(); // Initial pump to start the app

    print('⏳ Waiting for home screen...');
    // Wait for the Japji Sahib text to appear, which confirms we are on the home screen
    // We use a loop with pump(duration) instead of pumpAndSettle to avoid hanging on infinite animations
    bool homeScreenVisible = false;
    for (int i = 0; i < 50; i++) {
      await tester.pump(const Duration(milliseconds: 200));
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
    // Give it a bit more time to settle
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
    // Use a fixed pump duration in case of infinite animations
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
    final readerOptions = find.byIcon(Icons.tune);
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    // 4. Path Hindi
    print('🔘 Switching to Hindi...');
    final hindiOption = find.text('Hindi', skipOffstage: false).last;
    await tester.dragUntilVisible(
      hindiOption,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(hindiOption);
    await tester.pumpAndSettle();

    // Close options to see the text clearly
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    print('📸 Capturing Path Hindi...');
    await binding.takeScreenshot('path-hindi');
    await tester.pump(const Duration(milliseconds: 500));

    // 5. Path English
    print('🔘 Switching to English...');
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();
    final englishOption = find.text('English', skipOffstage: false).last;
    await tester.dragUntilVisible(
      englishOption,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(englishOption);
    await tester.pumpAndSettle();
    
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    print('📸 Capturing Path English...');
    await binding.takeScreenshot('path-english');
    await tester.pump(const Duration(milliseconds: 500));

    // --- Themes ---
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    // 6. Forest Theme
    print('🎨 Switching to Forest Theme...');
    final forestTheme = find.text('Forest', skipOffstage: false).last;
    await tester.dragUntilVisible(
      forestTheme,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(forestTheme);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('foresttheme');
    await tester.pump(const Duration(milliseconds: 500));

    // 7. Stars Theme (Dark)
    print('🎨 Switching to Stars Theme...');
    final starsTheme = find.text('Stars', skipOffstage: false).last;
    await tester.dragUntilVisible(
      starsTheme,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(starsTheme);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('darktheme');
    await tester.pump(const Duration(milliseconds: 500));

    // 8. Wood Theme
    print('🎨 Switching to Wood Theme...');
    final woodTheme = find.text('Wood', skipOffstage: false).last;
    await tester.dragUntilVisible(
      woodTheme,
      find.byType(ListView).last,
      const Offset(0, -100),
    );
    await tester.tap(woodTheme);
    await tester.pumpAndSettle();
    await binding.takeScreenshot('woodtheme');
    await tester.pump(const Duration(milliseconds: 500));

    print('✅ Screenshot generation complete!');
  });
}

extension on WidgetTester {
}
