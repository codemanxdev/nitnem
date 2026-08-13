import 'package:flutter/services.dart' show rootBundle;
import 'package:nitnem/models/language.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'path_data_provider.g.dart';

@riverpod
Future<String> pathData(Ref ref) async {
  final settings = await ref.watch(settingsProvider.future);
  final readerState = ref.watch(readerProvider);

  if (readerState.pathFilePrefix.isEmpty) return '';

  final langCode = getLanguageMenuItemValueByName(settings.languageName).langCode;
  final assetPath = 'assets/path/${readerState.pathFilePrefix}_$langCode.txt';

  return await rootBundle.loadString(assetPath);
}
