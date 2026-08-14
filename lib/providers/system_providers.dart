import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_providers.g.dart';

@riverpod
Stream<String> currentTime(Ref ref) async* {
  final controller = StreamController<String>();
  
  void updateTime() {
    final now = DateTime.now();
    controller.add(DateFormat('HH:mm a').format(now));
  }

  updateTime();
  final timer = Timer.periodic(const Duration(minutes: 1), (_) => updateTime());
  
  ref.onDispose(() {
    timer.cancel();
    controller.close();
  });

  yield* controller.stream;
}

@riverpod
Stream<int> batteryLevel(Ref ref) async* {
  final battery = Battery();
  final controller = StreamController<int>();

  Future<void> updateBattery() async {
    try {
      final level = await battery.batteryLevel;
      controller.add(level);
    } catch (_) {
      controller.add(0);
    }
  }

  await updateBattery();
  final timer = Timer.periodic(const Duration(minutes: 5), (_) => updateBattery());

  ref.onDispose(() {
    timer.cancel();
    controller.close();
  });

  yield* controller.stream;
}
