import 'package:freezed_annotation/freezed_annotation.dart';

part 'readingsession.freezed.dart';
part 'readingsession.g.dart';

@freezed
abstract class ReadingSession with _$ReadingSession {
  const factory ReadingSession({
    required int pathId,
    required String pathTitle,
    required DateTime startTime,
    required DateTime endTime,
    required int durationSeconds,
  }) = _ReadingSession;

  factory ReadingSession.fromJson(Map<String, dynamic> json) =>
      _$ReadingSessionFromJson(json);
}
