import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nitnem/pages/readerscreen.dart';
import 'package:nitnem/redux/store/store.dart';
import 'package:nitnem/state/appoptions.dart';
import 'package:nitnem/state/appstate.dart';

import 'maketestablewidget.dart';

void main() {
  testWidgets('TEST - [ReaderScreen] renders main components', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      var store = createStore(AppOptions.initial());
      ReaderScreen screen = ReaderScreen(key: UniqueKey());
      await tester.pumpWidget(
        makeTestableWidget(
          child: StoreProvider<AppState>(store: store, child: screen),
        ),
      );

      await tester.idle();
      await tester.pump();

      // Only check for title if not empty
      if (store.state.pathTitle.isNotEmpty) {
        expect(find.text(store.state.pathTitle), findsOneWidget);
      }

      expect(find.byType(Scrollbar), findsWidgets);
      // Check for scrollable content
      expect(find.byType(CustomScrollView), findsOneWidget);
    });
  });
}
