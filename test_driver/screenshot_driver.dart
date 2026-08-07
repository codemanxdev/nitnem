import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes,
        [Map<String, dynamic>? args]) async {
      final File image = File('listing/android-phone/$screenshotName.png');
      await image.create(recursive: true);
      await image.writeAsBytes(screenshotBytes);
      print('Screenshot saved: listing/android-phone/$screenshotName.png');
      return true;
    },
  );
}
