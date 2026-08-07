import 'package:flutter/material.dart';
import 'package:nitnem/constants/appconstants.dart';

TextTheme buildTextTheme(TextTheme base) {
  return base.copyWith(
    headlineMedium: base.headlineMedium!.copyWith(
      fontFamily: AppConstants.ROBOTO_SLAB_FONT,
    ),
  );
}

TextTheme buildPrimaryTextTheme(TextTheme base, Color textColor) {
  return base.copyWith(
    titleMedium: base.titleMedium!.copyWith(color: textColor),
  );
}
