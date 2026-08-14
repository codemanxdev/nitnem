import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/models/language.dart';
import 'package:nitnem/providers/reader_provider.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'path_data_provider.g.dart';

@riverpod
Future<String> pathData(Ref ref) async {
  // Only watch the language name and path prefix.
  final languageName = await ref.watch(
    settingsProvider.selectAsync((s) => s.languageName),
  );
  
  // Watch ONLY the file prefix to avoid re-loads on scroll
  final pathFilePrefix = ref.watch(
    readerProvider.select((s) => s.pathFilePrefix),
  );

  if (pathFilePrefix.isEmpty) return '';

  final langCode = getLanguageMenuItemValueByName(languageName).langCode;
  final assetPath = 'assets/path/${pathFilePrefix}_$langCode.txt';

  return await rootBundle.loadString(assetPath);
}
