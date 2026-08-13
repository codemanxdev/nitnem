import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nitnem/data/pathtiledata.dart';
import 'package:nitnem/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Baani Order Logic (Riverpod)', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('updateBaaniOrder updates ordered IDs', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      final newOrder = [3, 1, 2];
      await notifier.updateBaaniOrder(newOrder);
      
      final state = container.read(settingsProvider).value!;
      expect(state.baaniOrderedIds, newOrder);
    });

    test('resetBaaniOrder resets to default', () async {
      final notifier = container.read(settingsProvider.notifier);
      await container.read(settingsProvider.future);
      
      await notifier.updateBaaniOrder([3, 2, 1]);
      await notifier.resetBaaniOrder();
      
      final state = container.read(settingsProvider).value!;
      expect(state.baaniOrderedIds, PathTileData.defaultOrderIds);
    });
  });
}
