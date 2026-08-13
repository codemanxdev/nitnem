import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrollinfo.freezed.dart';
part 'scrollinfo.g.dart';

@freezed
abstract class ScrollInfo with _$ScrollInfo {
  const factory ScrollInfo({
    required int id,
    required double scrollOffset,
    required double maxOffset,
  }) = _ScrollInfo;

  factory ScrollInfo.fromJson(Map<String, dynamic> json) =>
      _$ScrollInfoFromJson(json);
}
