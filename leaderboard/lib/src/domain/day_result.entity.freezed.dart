// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_result.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DayResult _$DayResultFromJson(Map<String, dynamic> json) {
  return _DayResult.fromJson(json);
}

/// @nodoc
mixin _$DayResult {
  @JsonKey(name: 'get_star_ts')
  int get getStarTs => throw _privateConstructorUsedError;
  @JsonKey(name: 'star_index')
  int get starIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayResultCopyWith<DayResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayResultCopyWith<$Res> {
  factory $DayResultCopyWith(DayResult value, $Res Function(DayResult) then) =
      _$DayResultCopyWithImpl<$Res, DayResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'get_star_ts') int getStarTs,
      @JsonKey(name: 'star_index') int starIndex});
}

/// @nodoc
class _$DayResultCopyWithImpl<$Res, $Val extends DayResult>
    implements $DayResultCopyWith<$Res> {
  _$DayResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getStarTs = null,
    Object? starIndex = null,
  }) {
    return _then(_value.copyWith(
      getStarTs: null == getStarTs
          ? _value.getStarTs
          : getStarTs // ignore: cast_nullable_to_non_nullable
              as int,
      starIndex: null == starIndex
          ? _value.starIndex
          : starIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DayResultCopyWith<$Res> implements $DayResultCopyWith<$Res> {
  factory _$$_DayResultCopyWith(
          _$_DayResult value, $Res Function(_$_DayResult) then) =
      __$$_DayResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'get_star_ts') int getStarTs,
      @JsonKey(name: 'star_index') int starIndex});
}

/// @nodoc
class __$$_DayResultCopyWithImpl<$Res>
    extends _$DayResultCopyWithImpl<$Res, _$_DayResult>
    implements _$$_DayResultCopyWith<$Res> {
  __$$_DayResultCopyWithImpl(
      _$_DayResult _value, $Res Function(_$_DayResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getStarTs = null,
    Object? starIndex = null,
  }) {
    return _then(_$_DayResult(
      getStarTs: null == getStarTs
          ? _value.getStarTs
          : getStarTs // ignore: cast_nullable_to_non_nullable
              as int,
      starIndex: null == starIndex
          ? _value.starIndex
          : starIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DayResult implements _DayResult {
  const _$_DayResult(
      {@JsonKey(name: 'get_star_ts') required this.getStarTs,
      @JsonKey(name: 'star_index') required this.starIndex});

  factory _$_DayResult.fromJson(Map<String, dynamic> json) =>
      _$$_DayResultFromJson(json);

  @override
  @JsonKey(name: 'get_star_ts')
  final int getStarTs;
  @override
  @JsonKey(name: 'star_index')
  final int starIndex;

  @override
  String toString() {
    return 'DayResult(getStarTs: $getStarTs, starIndex: $starIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DayResult &&
            (identical(other.getStarTs, getStarTs) ||
                other.getStarTs == getStarTs) &&
            (identical(other.starIndex, starIndex) ||
                other.starIndex == starIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, getStarTs, starIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DayResultCopyWith<_$_DayResult> get copyWith =>
      __$$_DayResultCopyWithImpl<_$_DayResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DayResultToJson(
      this,
    );
  }
}

abstract class _DayResult implements DayResult {
  const factory _DayResult(
          {@JsonKey(name: 'get_star_ts') required final int getStarTs,
          @JsonKey(name: 'star_index') required final int starIndex}) =
      _$_DayResult;

  factory _DayResult.fromJson(Map<String, dynamic> json) =
      _$_DayResult.fromJson;

  @override
  @JsonKey(name: 'get_star_ts')
  int get getStarTs;
  @override
  @JsonKey(name: 'star_index')
  int get starIndex;
  @override
  @JsonKey(ignore: true)
  _$$_DayResultCopyWith<_$_DayResult> get copyWith =>
      throw _privateConstructorUsedError;
}
