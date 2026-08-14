// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readingsession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingSession _$ReadingSessionFromJson(Map<String, dynamic> json) =>
    _ReadingSession(
      pathId: (json['pathId'] as num).toInt(),
      pathTitle: json['pathTitle'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$ReadingSessionToJson(_ReadingSession instance) =>
    <String, dynamic>{
      'pathId': instance.pathId,
      'pathTitle': instance.pathTitle,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
    };
