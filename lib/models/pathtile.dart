import 'package:freezed_annotation/freezed_annotation.dart';

part 'pathtile.freezed.dart';
part 'pathtile.g.dart';

@freezed
abstract class PathTile with _$PathTile {
  const factory PathTile({
    required int id,
    required String title,
    required String gurmukhi,
    required String filePrefix,
  }) = _PathTile;

  factory PathTile.fromJson(Map<String, dynamic> json) =>
      _$PathTileFromJson(json);
}
