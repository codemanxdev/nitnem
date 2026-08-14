// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrollinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScrollInfo _$ScrollInfoFromJson(Map<String, dynamic> json) => _ScrollInfo(
  id: (json['id'] as num).toInt(),
  scrollOffset: (json['scrollOffset'] as num).toDouble(),
  maxOffset: (json['maxOffset'] as num).toDouble(),
);

Map<String, dynamic> _$ScrollInfoToJson(_ScrollInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scrollOffset': instance.scrollOffset,
      'maxOffset': instance.maxOffset,
    };
