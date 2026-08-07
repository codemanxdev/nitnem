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
    await tester.pumpAndSettle();

    print('⏳ Waiting for splash screen (4s)...');
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // Required for Android screenshots
    await binding.convertFlutterSurfaceToImage();

    // 1. Main Screen
    print('📸 Capturing Main Screen...');
    await binding.takeScreenshot('mainscreen');

    // 2. Options (Home Screen Backdrop)
    print('🔘 Tapping Options toggle...');
    final backdropToggle = find.byType(BackdropToggleButton);
    await tester.tap(backdropToggle);
    // Use a fixed pump duration in case of infinite animations
    await tester.pump(const Duration(milliseconds: 1000)); 
    await tester.pumpAndSettle();
    
    print('📸 Capturing Options Screen...');
    await binding.takeScreenshot('options');

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

    // Open Reader Options
    print('🔘 Opening Reader Options...');
    final readerOptions = find.byIcon(Icons.tune);
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    // 4. Path Hindi
    print('🔘 Switching to Hindi...');
    await tester.tap(find.text('Hindi'));
    await tester.pumpAndSettle();
    
    // Close options to see the text clearly
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();
    
    print('📸 Capturing Path Hindi...');
    await binding.takeScreenshot('path-hindi');

    // 5. Path English
    print('🔘 Switching to English...');
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();
    
    print('📸 Capturing Path English...');
    await binding.takeScreenshot('path-english');

    // --- Themes ---
    await tester.tap(readerOptions);
    await tester.pumpAndSettle();

    // 6. Forest Theme
    print('🎨 Switching to Forest Theme...');
    await tester.tap(find.text('Forest'));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('foresttheme');

    // 7. Stars Theme (Dark)
    print('🎨 Switching to Stars Theme...');
    await tester.tap(find.text('Stars'));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('darktheme');

    // 8. Wood Theme
    print('🎨 Switching to Wood Theme...');
    await tester.tap(find.text('Wood'));
    await tester.pumpAndSettle();
    await binding.takeScreenshot('woodtheme');
    
    print('✅ Screenshot generation complete!');
  });
}
