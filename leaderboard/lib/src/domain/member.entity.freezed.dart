// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Member _$MemberFromJson(Map<String, dynamic> json) {
  return _Member.fromJson(json);
}

/// @nodoc
mixin _$Member {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_star_ts')
  int get lastStarTs => throw _privateConstructorUsedError;
  @JsonKey(name: 'global_score')
  int get globalScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_score')
  int get localScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_day_level')
  Map<int, Map<int, DayResult>> get completionDayLevel =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MemberCopyWith<Member> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberCopyWith<$Res> {
  factory $MemberCopyWith(Member value, $Res Function(Member) then) =
      _$MemberCopyWithImpl<$Res, Member>;
  @useResult
  $Res call(
      {int id,
      String name,
      int stars,
      @JsonKey(name: 'last_star_ts')
          int lastStarTs,
      @JsonKey(name: 'global_score')
          int globalScore,
      @JsonKey(name: 'local_score')
          int localScore,
      @JsonKey(name: 'completion_day_level')
          Map<int, Map<int, DayResult>> completionDayLevel});
}

/// @nodoc
class _$MemberCopyWithImpl<$Res, $Val extends Member>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? stars = null,
    Object? lastStarTs = null,
    Object? globalScore = null,
    Object? localScore = null,
    Object? completionDayLevel = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      lastStarTs: null == lastStarTs
          ? _value.lastStarTs
          : lastStarTs // ignore: cast_nullable_to_non_nullable
              as int,
      globalScore: null == globalScore
          ? _value.globalScore
          : globalScore // ignore: cast_nullable_to_non_nullable
              as int,
      localScore: null == localScore
          ? _value.localScore
          : localScore // ignore: cast_nullable_to_non_nullable
              as int,
      completionDayLevel: null == completionDayLevel
          ? _value.completionDayLevel
          : completionDayLevel // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<int, DayResult>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MemberCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$$_MemberCopyWith(_$_Member value, $Res Function(_$_Member) then) =
      __$$_MemberCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      int stars,
      @JsonKey(name: 'last_star_ts')
          int lastStarTs,
      @JsonKey(name: 'global_score')
          int globalScore,
      @JsonKey(name: 'local_score')
          int localScore,
      @JsonKey(name: 'completion_day_level')
          Map<int, Map<int, DayResult>> completionDayLevel});
}

/// @nodoc
class __$$_MemberCopyWithImpl<$Res>
    extends _$MemberCopyWithImpl<$Res, _$_Member>
    implements _$$_MemberCopyWith<$Res> {
  __$$_MemberCopyWithImpl(_$_Member _value, $Res Function(_$_Member) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? stars = null,
    Object? lastStarTs = null,
    Object? globalScore = null,
    Object? localScore = null,
    Object? completionDayLevel = null,
  }) {
    return _then(_$_Member(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stars: null == stars
          ? _value.stars
          : stars // ignore: cast_nullable_to_non_nullable
              as int,
      lastStarTs: null == lastStarTs
          ? _value.lastStarTs
          : lastStarTs // ignore: cast_nullable_to_non_nullable
              as int,
      globalScore: null == globalScore
          ? _value.globalScore
          : globalScore // ignore: cast_nullable_to_non_nullable
              as int,
      localScore: null == localScore
          ? _value.localScore
          : localScore // ignore: cast_nullable_to_non_nullable
              as int,
      completionDayLevel: null == completionDayLevel
          ? _value._completionDayLevel
          : completionDayLevel // ignore: cast_nullable_to_non_nullable
              as Map<int, Map<int, DayResult>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Member implements _Member {
  const _$_Member(
      {required this.id,
      required this.name,
      required this.stars,
      @JsonKey(name: 'last_star_ts')
          required this.lastStarTs,
      @JsonKey(name: 'global_score')
          required this.globalScore,
      @JsonKey(name: 'local_score')
          required this.localScore,
      @JsonKey(name: 'completion_day_level')
          required final Map<int, Map<int, DayResult>> completionDayLevel})
      : _completionDayLevel = completionDayLevel;

  factory _$_Member.fromJson(Map<String, dynamic> json) =>
      _$$_MemberFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int stars;
  @override
  @JsonKey(name: 'last_star_ts')
  final int lastStarTs;
  @override
  @JsonKey(name: 'global_score')
  final int globalScore;
  @override
  @JsonKey(name: 'local_score')
  final int localScore;
  final Map<int, Map<int, DayResult>> _completionDayLevel;
  @override
  @JsonKey(name: 'completion_day_level')
  Map<int, Map<int, DayResult>> get completionDayLevel {
    if (_completionDayLevel is EqualUnmodifiableMapView)
      return _completionDayLevel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_completionDayLevel);
  }

  @override
  String toString() {
    return 'Member(id: $id, name: $name, stars: $stars, lastStarTs: $lastStarTs, globalScore: $globalScore, localScore: $localScore, completionDayLevel: $completionDayLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Member &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.lastStarTs, lastStarTs) ||
                other.lastStarTs == lastStarTs) &&
            (identical(other.globalScore, globalScore) ||
                other.globalScore == globalScore) &&
            (identical(other.localScore, localScore) ||
                other.localScore == localScore) &&
            const DeepCollectionEquality()
                .equals(other._completionDayLevel, _completionDayLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      stars,
      lastStarTs,
      globalScore,
      localScore,
      const DeepCollectionEquality().hash(_completionDayLevel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemberCopyWith<_$_Member> get copyWith =>
      __$$_MemberCopyWithImpl<_$_Member>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MemberToJson(
      this,
    );
  }
}

abstract class _Member implements Member {
  const factory _Member(
      {required final int id,
      required final String name,
      required final int stars,
      @JsonKey(name: 'last_star_ts')
          required final int lastStarTs,
      @JsonKey(name: 'global_score')
          required final int globalScore,
      @JsonKey(name: 'local_score')
          required final int localScore,
      @JsonKey(name: 'completion_day_level')
          required final Map<int, Map<int, DayResult>>
              completionDayLevel}) = _$_Member;

  factory _Member.fromJson(Map<String, dynamic> json) = _$_Member.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get stars;
  @override
  @JsonKey(name: 'last_star_ts')
  int get lastStarTs;
  @override
  @JsonKey(name: 'global_score')
  int get globalScore;
  @override
  @JsonKey(name: 'local_score')
  int get localScore;
  @override
  @JsonKey(name: 'completion_day_level')
  Map<int, Map<int, DayResult>> get completionDayLevel;
  @override
  @JsonKey(ignore: true)
  _$$_MemberCopyWith<_$_Member> get copyWith =>
      throw _privateConstructorUsedError;
}
