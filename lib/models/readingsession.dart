import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ReadingSession {
  final int pathId;
  final String pathTitle;
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;

  ReadingSession({
    required this.pathId,
    required this.pathTitle,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
  });

  factory ReadingSession.fromJson(Map<String, dynamic> json) => ReadingSession(
    pathId: json['pathId'] as int,
    pathTitle: json['pathTitle'] as String,
    startTime: DateTime.parse(json['startTime'] as String),
    endTime: DateTime.parse(json['endTime'] as String),
    durationSeconds: json['durationSeconds'] as int,
  );

  Map<String, dynamic> toJson() => {
    'pathId': pathId,
    'pathTitle': pathTitle,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'durationSeconds': durationSeconds,
  };

  @override
  String toString() {
    return 'ReadingSession{pathId: $pathId, title: $pathTitle, duration: $durationSeconds}';
  }
}
