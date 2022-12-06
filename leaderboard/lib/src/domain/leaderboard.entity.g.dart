// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Leaderboard _$$_LeaderboardFromJson(Map<String, dynamic> json) =>
    _$_Leaderboard(
      ownerId: json['owner_id'] as int,
      members: _membersFromJson(json['members'] as Map<String, dynamic>),
      event: json['event'] as String,
    );

Map<String, dynamic> _$$_LeaderboardToJson(_$_Leaderboard instance) =>
    <String, dynamic>{
      'owner_id': instance.ownerId,
      'members': instance.members,
      'event': instance.event,
    };
