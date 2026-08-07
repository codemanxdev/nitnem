import 'package:flutter/material.dart';

import 'themetextbuilder.dart';

ThemeData buildEthnicTheme() {
  const Color primaryColor = Color(0xffffa726);
  const Color secondaryColor = Color(0xfffff3e0);
  const Color tertiaryColor = Color(0xffFECB86);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    surface: Color(0xffd67600),
    error: Color(0xffd32f2f),
    onPrimary: Colors.white,
    onSecondary: Color(0xff000000),
    onSurface: Color(0xff000000),
    onError: Color(0xffffffff),
    brightness: Brightness.light,
  );

  final ThemeData base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    highlightColor: Colors.blueGrey,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xffffecb3),
      inactiveTrackColor: Color(0x3dff6f00),
      disabledActiveTrackColor: Color(0x52303f9f),
      disabledInactiveTrackColor: Color(0x1f303f9f),
      activeTickMarkColor: Color(0x8ac5cae9),
      inactiveTickMarkColor: Color(0x8a3f51b5),
      disabledActiveTickMarkColor: Color(0x1fc5cae9),
      disabledInactiveTickMarkColor: Color(0x1f303f9f),
      thumbColor: Color(0xffffca28),
      disabledThumbColor: Color(0x52303f9f),
      thumbShape: RoundSliderThumbShape(),
      overlayColor: Color(0x293f51b5),
      valueIndicatorColor: Color(0xff8d5300),
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.onlyForDiscrete,
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xffba7100),
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    tabBarTheme: TabBarThemeData(indicatorColor: Colors.white),
  );

  return base.copyWith(
    textTheme: buildTextTheme(base.textTheme),
    primaryTextTheme: buildPrimaryTextTheme(
      base.primaryTextTheme,
      Colors.white,
    ),
  );
}
