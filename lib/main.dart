import 'package:flutter/material.dart';
import 'package:nitnem/app.dart';
import 'package:nitnem/persistence/persistence.dart';
import 'package:nitnem/redux/actions/actions.dart';
import 'package:nitnem/redux/store/store.dart';

import 'common/printmessage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final options = await loadOptionsFromPrefs();
  var store = createStore(options);
  store.dispatch(OptionsLoadedAction(options));
  printInfoMessage('Initial state: ${store.state}');
  runApp(NitnemApp(store));
}
