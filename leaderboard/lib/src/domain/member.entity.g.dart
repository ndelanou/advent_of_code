// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Member _$$_MemberFromJson(Map<String, dynamic> json) => _$_Member(
      id: json['id'] as int,
      name: json['name'] as String,
      stars: json['stars'] as int,
      lastStarTs: json['last_star_ts'] as int,
      globalScore: json['global_score'] as int,
      localScore: json['local_score'] as int,
      completionDayLevel:
          (json['completion_day_level'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k),
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  int.parse(k), DayResult.fromJson(e as Map<String, dynamic>)),
            )),
      ),
    );

Map<String, dynamic> _$$_MemberToJson(_$_Member instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stars': instance.stars,
      'last_star_ts': instance.lastStarTs,
      'global_score': instance.globalScore,
      'local_score': instance.localScore,
      'completion_day_level': instance.completionDayLevel.map((k, e) =>
          MapEntry(k.toString(), e.map((k, e) => MapEntry(k.toString(), e)))),
    };
