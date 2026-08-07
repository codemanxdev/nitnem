import 'package:flutter/material.dart';

import 'themetextbuilder.dart';

ThemeData buildForestTheme() {
  const Color primaryColor = Color(0xff4caf50);
  const Color secondaryColor = Color(0xff405016);
  const Color tertiaryColor = Color(0xFF01C21B);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    surface: Color(0xff0eea21),
    error: Color(0xffd32f2f),
    onPrimary: Color(0xffffffff),
    onSecondary: Color(0xffffffff),
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
    highlightColor: Color(0xff094D11),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      actionsIconTheme: IconThemeData(color: colorScheme.onPrimary),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryIconTheme: IconThemeData(color: colorScheme.onPrimary),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xffa5d6a7),
      inactiveTrackColor: Color(0x3d2e7d32),
      disabledActiveTrackColor: Color(0x52303f9f),
      disabledInactiveTrackColor: Color(0x1f303f9f),
      activeTickMarkColor: Color(0x8ac5cae9),
      inactiveTickMarkColor: Color(0x8a3f51b5),
      disabledActiveTickMarkColor: Color(0x1fc5cae9),
      disabledInactiveTickMarkColor: Color(0x1f303f9f),
      thumbColor: Color(0xff124714),
      disabledThumbColor: Color(0x52303f9f),
      thumbShape: RoundSliderThumbShape(),
      overlayColor: Color(0x293f51b5),
      valueIndicatorColor: Color(0xff3f51b5),
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.onlyForDiscrete,
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xff0000ff),
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
      colorScheme.onPrimary,
    ),
  );
}
