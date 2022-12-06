// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) {
  return _Leaderboard.fromJson(json);
}

/// @nodoc
mixin _$Leaderboard {
  @JsonKey(name: 'owner_id')
  int get ownerId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _membersFromJson)
  List<Member> get members => throw _privateConstructorUsedError;
  String get event => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderboardCopyWith<Leaderboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardCopyWith<$Res> {
  factory $LeaderboardCopyWith(
          Leaderboard value, $Res Function(Leaderboard) then) =
      _$LeaderboardCopyWithImpl<$Res, Leaderboard>;
  @useResult
  $Res call(
      {@JsonKey(name: 'owner_id') int ownerId,
      @JsonKey(fromJson: _membersFromJson) List<Member> members,
      String event});
}

/// @nodoc
class _$LeaderboardCopyWithImpl<$Res, $Val extends Leaderboard>
    implements $LeaderboardCopyWith<$Res> {
  _$LeaderboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerId = null,
    Object? members = null,
    Object? event = null,
  }) {
    return _then(_value.copyWith(
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LeaderboardCopyWith<$Res>
    implements $LeaderboardCopyWith<$Res> {
  factory _$$_LeaderboardCopyWith(
          _$_Leaderboard value, $Res Function(_$_Leaderboard) then) =
      __$$_LeaderboardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'owner_id') int ownerId,
      @JsonKey(fromJson: _membersFromJson) List<Member> members,
      String event});
}

/// @nodoc
class __$$_LeaderboardCopyWithImpl<$Res>
    extends _$LeaderboardCopyWithImpl<$Res, _$_Leaderboard>
    implements _$$_LeaderboardCopyWith<$Res> {
  __$$_LeaderboardCopyWithImpl(
      _$_Leaderboard _value, $Res Function(_$_Leaderboard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerId = null,
    Object? members = null,
    Object? event = null,
  }) {
    return _then(_$_Leaderboard(
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Member>,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Leaderboard implements _Leaderboard {
  const _$_Leaderboard(
      {@JsonKey(name: 'owner_id') required this.ownerId,
      @JsonKey(fromJson: _membersFromJson) required final List<Member> members,
      required this.event})
      : _members = members;

  factory _$_Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$$_LeaderboardFromJson(json);

  @override
  @JsonKey(name: 'owner_id')
  final int ownerId;
  final List<Member> _members;
  @override
  @JsonKey(fromJson: _membersFromJson)
  List<Member> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final String event;

  @override
  String toString() {
    return 'Leaderboard(ownerId: $ownerId, members: $members, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Leaderboard &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ownerId,
      const DeepCollectionEquality().hash(_members), event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LeaderboardCopyWith<_$_Leaderboard> get copyWith =>
      __$$_LeaderboardCopyWithImpl<_$_Leaderboard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LeaderboardToJson(
      this,
    );
  }
}

abstract class _Leaderboard implements Leaderboard {
  const factory _Leaderboard(
      {@JsonKey(name: 'owner_id') required final int ownerId,
      @JsonKey(fromJson: _membersFromJson) required final List<Member> members,
      required final String event}) = _$_Leaderboard;

  factory _Leaderboard.fromJson(Map<String, dynamic> json) =
      _$_Leaderboard.fromJson;

  @override
  @JsonKey(name: 'owner_id')
  int get ownerId;
  @override
  @JsonKey(fromJson: _membersFromJson)
  List<Member> get members;
  @override
  String get event;
  @override
  @JsonKey(ignore: true)
  _$$_LeaderboardCopyWith<_$_Leaderboard> get copyWith =>
      throw _privateConstructorUsedError;
}
