import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nitnem/constants/appconstants.dart';

part 'reader_state.freezed.dart';

@freezed
abstract class ReaderState with _$ReaderState {
  const factory ReaderState({
    required bool showReaderOptions,
    required String pathData,
    required String pathFilePrefix,
    required String pathTitle,
    required int pathId,
    @Default(0.0) double scrollOffset,
    @Default(0.0) double maxOffset,
  }) = _ReaderState;

  factory ReaderState.initial() => const ReaderState(
        showReaderOptions: false,
        pathData: AppConstants.EMPTY_STRING,
        pathFilePrefix: AppConstants.EMPTY_STRING,
        pathTitle: AppConstants.EMPTY_STRING,
        pathId: 1,
      );
}
