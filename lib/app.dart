import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/navigation/approute.dart';
import 'package:nitnem/pages/about.dart';
import 'package:nitnem/pages/baaniorderscreen.dart';
import 'package:nitnem/pages/homescreen.dart';
import 'package:nitnem/pages/options.dart';
import 'package:nitnem/pages/readerscreen.dart';
import 'package:nitnem/pages/splashscreen.dart';
import 'package:nitnem/pages/statsscreen.dart';
import 'package:nitnem/providers/settings_provider.dart';

import 'models/themes.dart';

class NitnemApp extends ConsumerWidget {
  final _optionsPageKey = GlobalKey();
  final _homeScreenKey = GlobalKey();
  final _readerScreenKey = GlobalKey();
  final _orderScreenKey = GlobalKey();
  final _statsScreenKey = GlobalKey();

  NitnemApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);

    return settingsAsync.when(
      data: (settings) {
        final themeData = getThemeByName(settings.themeName).data;
        return MaterialApp(
          title: 'Nitnem App',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          color: Colors.grey,
          home: SplashScreen(),
          routes: _buildRoutes(),
          builder: (BuildContext context, Widget? child) {
            return Directionality(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: themeData.brightness,
                ),
                child: child!,
              ),
              textDirection: TextDirection.ltr,
            );
          },
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (err, stack) => const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Icon(Icons.error_outline, color: Colors.grey, size: 48),
          ),
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
      AppRoute(
        routeName: '/about',
        buildRoute: (BuildContext context) => const AboutScreen(),
      ),
    ];
    return routes;
  }
}
