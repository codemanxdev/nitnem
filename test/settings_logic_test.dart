import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Settings Logic (Riverpod)', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('updateTextScale updates scale', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      await notifier.updateTextScale(1.5);
      
      final state = container.read(settingsProvider).value!;
      expect(state.textScaleValue, 1.5);
    });

    test('toggleBold updates bold state', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      await notifier.toggleBold(true);
      
      final state = container.read(settingsProvider).value!;
      expect(state.bold, true);
    });

    test('toggleScreenAwake updates awake state', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      await notifier.toggleScreenAwake(true);
      
      final state = container.read(settingsProvider).value!;
      expect(state.screenAwake, true);
    });

    test('changeTheme updates theme', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      await notifier.changeTheme('Wood');
      
      final state = container.read(settingsProvider).value!;
      expect(state.themeName, 'Wood');
    });
  });
}
