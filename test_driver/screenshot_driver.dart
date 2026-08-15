import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes,
        [Map<String, dynamic>? args]) async {
      // If screenshotName contains a slash, it's treated as a sub-path
      final String fullPath = screenshotName.contains('/') 
          ? 'listing/$screenshotName.png'
          : 'listing/android-phone/$screenshotName.png';
          
      final File image = File(fullPath);
      await image.create(recursive: true);
      await image.writeAsBytes(screenshotBytes);
      print('Screenshot saved: $fullPath');
      return true;
    },
  );
}
