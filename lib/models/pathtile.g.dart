// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pathtile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PathTile _$PathTileFromJson(Map<String, dynamic> json) => _PathTile(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  gurmukhi: json['gurmukhi'] as String,
  filePrefix: json['filePrefix'] as String,
);

Map<String, dynamic> _$PathTileToJson(_PathTile instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'gurmukhi': instance.gurmukhi,
  'filePrefix': instance.filePrefix,
};
