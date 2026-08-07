import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nitnem/navigation/approute.dart';
import 'package:nitnem/pages/baaniorderscreen.dart';
import 'package:nitnem/pages/homescreen.dart';
import 'package:nitnem/pages/options.dart';
import 'package:nitnem/pages/readerscreen.dart';
import 'package:nitnem/pages/splashscreen.dart';
import 'package:nitnem/pages/statsscreen.dart';
import 'package:nitnem/redux/selectors/selectors.dart';
import 'package:nitnem/state/appstate.dart';
import 'package:redux/redux.dart';

import 'models/themes.dart';

class NitnemApp extends StatelessWidget {
  final Store<AppState> store;
  final _optionsPageKey = GlobalKey();
  final _homeScreenKey = GlobalKey();
  final _readerScreenKey = GlobalKey();
  final _orderScreenKey = GlobalKey();
  final _statsScreenKey = GlobalKey();

  NitnemApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder:
            (context, vm) => MaterialApp(
              title: 'Nitnem App',
              debugShowCheckedModeBanner: false,
              theme: getThemeByName(vm.themeName).data,
              color: Colors.grey,
              home: SplashScreen(),
              routes: _buildRoutes(),
              builder: (BuildContext context, Widget? child) {
                return Directionality(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      brightness: getThemeByName(vm.themeName).data.brightness,
                    ),
                    child: child!,
                  ),
                  textDirection: TextDirection.ltr,
                );
              },
            ),
      ),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      _getRoutes(),
      key: (dynamic route) => '${route.routeName}',
      value: (dynamic route) => route.buildRoute,
    );
  }

  List<AppRoute> _getRoutes() {
    final List<AppRoute> routes = <AppRoute>[
      AppRoute(
        routeName: '/home',
        buildRoute:
            (BuildContext context) => HomeScreen(
              optionsPage: OptionsPage(readerMode: false, key: _optionsPageKey),
              key: _homeScreenKey,
            ),
      ),
      AppRoute(
        routeName: '/intro',
        buildRoute: (BuildContext context) => SplashScreen(),
      ),
      AppRoute(
        routeName: '/reader',
        buildRoute:
            (BuildContext context) => ReaderScreen(key: _readerScreenKey),
      ),
      AppRoute(
        routeName: '/order',
        buildRoute:
            (BuildContext context) => BaaniOrderScreen(key: _orderScreenKey),
      ),
      AppRoute(
        routeName: '/stats',
        buildRoute: (BuildContext context) => StatsScreen(key: _statsScreenKey),
      ),
    ];
    return routes;
  }
}

class _ViewModel {
  final String themeName;

  _ViewModel({required this.themeName});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(themeName: themeSelector(store.state));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          themeName == other.themeName;

  @override
  int get hashCode => themeName.hashCode;

  @override
  String toString() {
    return '_ViewModel{themeName: $themeName}';
  }
}
