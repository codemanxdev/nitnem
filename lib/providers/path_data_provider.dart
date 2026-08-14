import 'package:flutter/services.dart' show rootBundle;
import 'package:nitnem/models/language.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'path_data_provider.g.dart';

@riverpod
Future<String> pathData(Ref ref) async {
  // Only watch the language name. 
  // Watching the whole settings object causes re-loads on every scroll!
  final languageName = await ref.watch(
    settingsProvider.selectAsync((s) => s.languageName),
  );
  final readerState = ref.watch(readerProvider);

  if (readerState.pathFilePrefix.isEmpty) return '';

  final langCode = getLanguageMenuItemValueByName(languageName).langCode;
  final assetPath = 'assets/path/${readerState.pathFilePrefix}_$langCode.txt';

  return await rootBundle.loadString(assetPath);
}
