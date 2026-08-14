// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Reader)
final readerProvider = ReaderProvider._();

final class ReaderProvider extends $NotifierProvider<Reader, ReaderState> {
  ReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readerHash();

  @$internal
  @override
  Reader create() => Reader();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReaderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReaderState>(value),
    );
  }
}

String _$readerHash() => r'eb50560ae6766230050a1e7835cc6250fae78e88';

abstract class _$Reader extends $Notifier<ReaderState> {
  ReaderState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReaderState, ReaderState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReaderState, ReaderState>,
              ReaderState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
