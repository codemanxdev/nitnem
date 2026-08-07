import 'package:flutter/material.dart';

import './themetextbuilder.dart';

ThemeData buildDarkTheme() {
  const Color primaryColor = Color(0xFF60385A);
  const Color secondaryColor = Color(0xFF9A6BD2);
  const Color tertiaryColor = Color(0xff804d7a);
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    surface: Color(0xffBB86FC),
    error: const Color(0xFFB00020),
  );
  final ThemeData base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    primaryColorDark: const Color(0xFF2D2656),
    primaryColorLight: secondaryColor,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    highlightColor: Colors.white,
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
      activeTrackColor: Color(0xff7A57A8),
      inactiveTrackColor: Color(0xff3A2F56),
      disabledActiveTrackColor: Color(0x522D2656),
      disabledInactiveTrackColor: Color(0x1f1A1B2C),
      activeTickMarkColor: Color(0x8a804D7A),
      inactiveTickMarkColor: Color(0x8a5A4380),
      disabledActiveTickMarkColor: Color(0x1f60385A),
      disabledInactiveTickMarkColor: Color(0x1f3A2F56),
      thumbColor: Color(0xff9A6BD2),
      disabledThumbColor: Color(0x523A2F56),
      thumbShape: RoundSliderThumbShape(),
      overlayColor: Color(0x294C3F80),
      valueIndicatorColor: Color(0xff804D7A),
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      showValueIndicator: ShowValueIndicator.onlyForDiscrete,
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xffEDE7F6),
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
