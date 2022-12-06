import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';
import 'member.entity.dart';

part 'leaderboard.entity.freezed.dart';
part 'leaderboard.entity.g.dart';

@freezed
class Leaderboard with _$Leaderboard {
  const factory Leaderboard({
    @JsonKey(name: 'owner_id') required int ownerId,
    @JsonKey(fromJson: _membersFromJson) required List<Member> members,
    required String event,
  }) = _Leaderboard;

  factory Leaderboard.fromJson(JsonObject json) => _$LeaderboardFromJson(json);
}

List<Member> _membersFromJson(JsonObject json) {
  return json.values.map((e) => Member.fromJson(e as JsonObject)).toList();
}
