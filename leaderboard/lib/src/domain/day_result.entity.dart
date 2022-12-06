import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';

part 'day_result.entity.freezed.dart';
part 'day_result.entity.g.dart';

@freezed
class DayResult with _$DayResult {
  const factory DayResult({
    @JsonKey(name: 'get_star_ts') required int getStarTs,
    @JsonKey(name: 'star_index') required int starIndex,
  }) = _DayResult;

  factory DayResult.fromJson(JsonObject json) => _$DayResultFromJson(json);
}
