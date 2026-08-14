// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentTime)
final currentTimeProvider = CurrentTimeProvider._();

final class CurrentTimeProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  CurrentTimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentTimeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentTimeHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return currentTime(ref);
  }
}

String _$currentTimeHash() => r'9b2f82af9f33e92c024726357fcd32046df0f404';

@ProviderFor(batteryLevel)
final batteryLevelProvider = BatteryLevelProvider._();

final class BatteryLevelProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  BatteryLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'batteryLevelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$batteryLevelHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return batteryLevel(ref);
  }
}

String _$batteryLevelHash() => r'98f6088fdd6f8e32ee7139e2100912a9c34ed61d';
