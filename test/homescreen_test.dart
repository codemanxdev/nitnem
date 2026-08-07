// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nitnem/redux/store/store.dart';
import 'package:nitnem/state/appoptions.dart';
import 'package:nitnem/state/appstate.dart';

import '../lib/models/pathtile.dart';
import '../lib/pages/homescreen.dart';
import '../lib/pages/options.dart';
import 'maketestablewidget.dart';

void main() {
  testWidgets('TEST - [HomeScreen]', (WidgetTester tester) async {
    await tester.runAsync(() async {
      HomeScreen screen = HomeScreen(
        optionsPage: OptionsPage(key: UniqueKey(), readerMode: false),
        key: UniqueKey(),
      );
      var store = createStore(AppOptions.initial());
      await tester.pumpWidget(
        makeTestableWidget(
          child: StoreProvider<AppState>(store: store, child: screen),
        ),
      );

      await tester.idle();
      await tester.pump();

      List<PathTile> items = <PathTile>[
        new PathTile(1, 'Japji Sahib', 'jpujI swihb', 'japji_sahib'),
        new PathTile(2, 'Jaap Sahib', 'jwpu swihb', 'jaap_sahib'),
        new PathTile(3, 'Chaupai Sahib', 'cOpeI swihb', 'chaupai_sahib'),
        new PathTile(4, 'Anand Sahib', 'Anµdu swihb', 'anand_sahib'),
        new PathTile(5, 'Rehras Sahib', 'rhrwis swihb', 'rehraas_sahib'),
        new PathTile(
          6,
          'Tav-Prasad Savaiye',
          'qÍ pRswid sv`X',
          'tavprasad_savaiye',
        ),
        new PathTile(7, 'Ardas', 'Ardws', 'ardas'),
        new PathTile(8, 'Sukhmani Sahib', 'suKmnI swihb', 'sukhmani_sahib'),
        new PathTile(
          9,
          'Dukh Bhanjani Sahib',
          'duK BMjnI swihb',
          'dukh_bhanjani_sahib',
        ),
        new PathTile(10, 'Sohila Sahib', 'soihlw swihb', 'sohila_sahib'),
      ];
      // Verify that our home screen has the expected components.
      items.forEach(
        (item) =>
            expect(find.text(item.title, skipOffstage: false), findsOneWidget),
      );
    });
  });
}
