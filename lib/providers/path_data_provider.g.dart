// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pathData)
final pathDataProvider = PathDataProvider._();

final class PathDataProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  PathDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pathDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pathDataHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return pathData(ref);
  }
}

String _$pathDataHash() => r'bb9919355042e792c686c925b72bf1127fe5c62f';
