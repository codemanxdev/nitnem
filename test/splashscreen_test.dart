// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/redux/store/store.dart';
import 'package:nitnem/state/appoptions.dart';

void main() {
  testWidgets('TEST - [SplashScreen]', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var store = createStore(AppOptions.initial());
    await tester.pumpWidget(NitnemApp(store));

    // Verify that our splash screen has the nitnem title.
    expect(find.text(AppConstants.SPLASH_TITLE_TEXT), findsOneWidget);
  });
}
