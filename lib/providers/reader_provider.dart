import 'package:nitnem/state/reader_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reader_provider.g.dart';

@Riverpod(keepAlive: true)
class Reader extends _$Reader {
  @override
  ReaderState build() {
    return ReaderState.initial();
  }

  void toggleReaderOptions() {
    state = state.copyWith(showReaderOptions: !state.showReaderOptions);
  }

  void setReaderOptionsVisible(bool visible) {
    state = state.copyWith(showReaderOptions: visible);
  }

  void setPath({
    required int id,
    required String title,
    required String filePrefix,
  }) {
    state = state.copyWith(
      pathId: id,
      pathTitle: title,
      pathFilePrefix: filePrefix,
    );
  }

  void updateOffsets(double scrollOffset, double maxOffset) {
    state = state.copyWith(
      scrollOffset: scrollOffset,
      maxOffset: maxOffset,
    );
  }
}
