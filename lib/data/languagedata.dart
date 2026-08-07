import 'package:flutter/material.dart';
import 'package:nitnem/constants/appconstants.dart';
import 'package:nitnem/models/language.dart';

List<LanguageMenuItem> languages = <LanguageMenuItem>[
  LanguageMenuItem(
    title: 'Gurmukhi',
    icon: Icons.language,
    langCode: 'pa',
    fontName: AppConstants.GURAKHAR_FONT,
    fontSize: 22.0,
  ),
  LanguageMenuItem(
    title: 'Hindi',
    icon: Icons.language,
    langCode: 'hi',
    fontName: AppConstants.GURBANI_HINDI_FONT,
    fontSize: 24.0,
  ),
  LanguageMenuItem(
    title: 'English',
    icon: Icons.language,
    langCode: 'en',
    fontName: AppConstants.ROBOTO_SLAB_FONT,
    fontSize: 20.0,
  ),
];
