import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leaderboard/src/domain/day_result.entity.dart';

import '../core/types.dart';

part 'member.entity.freezed.dart';
part 'member.entity.g.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required int id,
    @JsonKey(defaultValue: '') required String name,
    required int stars,
    @JsonKey(name: 'last_star_ts') required int lastStarTs,
    @JsonKey(name: 'global_score') required int globalScore,
    @JsonKey(name: 'local_score') required int localScore,
    @JsonKey(name: 'completion_day_level') required Map<int, Map<int, DayResult>> completionDayLevel,
  }) = _Member;

  factory Member.fromJson(JsonObject json) => _$MemberFromJson(json);
}
