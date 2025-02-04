// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PumpStationState {
// required PumpStationMode mode,
  int get reservoir => throw _privateConstructorUsedError;
  int get reservoirSize => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  Map<int, PumpState> get pumps => throw _privateConstructorUsedError;
  int get valveSpeed => throw _privateConstructorUsedError;

  /// Create a copy of PumpStationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PumpStationStateCopyWith<PumpStationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PumpStationStateCopyWith<$Res> {
  factory $PumpStationStateCopyWith(
          PumpStationState value, $Res Function(PumpStationState) then) =
      _$PumpStationStateCopyWithImpl<$Res, PumpStationState>;
  @useResult
  $Res call(
      {int reservoir,
      int reservoirSize,
      int time,
      Map<int, PumpState> pumps,
      int valveSpeed});
}

/// @nodoc
class _$PumpStationStateCopyWithImpl<$Res, $Val extends PumpStationState>
    implements $PumpStationStateCopyWith<$Res> {
  _$PumpStationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PumpStationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservoir = null,
    Object? reservoirSize = null,
    Object? time = null,
    Object? pumps = null,
    Object? valveSpeed = null,
  }) {
    return _then(_value.copyWith(
      reservoir: null == reservoir
          ? _value.reservoir
          : reservoir // ignore: cast_nullable_to_non_nullable
              as int,
      reservoirSize: null == reservoirSize
          ? _value.reservoirSize
          : reservoirSize // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      pumps: null == pumps
          ? _value.pumps
          : pumps // ignore: cast_nullable_to_non_nullable
              as Map<int, PumpState>,
      valveSpeed: null == valveSpeed
          ? _value.valveSpeed
          : valveSpeed // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PumpStationStateImplCopyWith<$Res>
    implements $PumpStationStateCopyWith<$Res> {
  factory _$$PumpStationStateImplCopyWith(_$PumpStationStateImpl value,
          $Res Function(_$PumpStationStateImpl) then) =
      __$$PumpStationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int reservoir,
      int reservoirSize,
      int time,
      Map<int, PumpState> pumps,
      int valveSpeed});
}

/// @nodoc
class __$$PumpStationStateImplCopyWithImpl<$Res>
    extends _$PumpStationStateCopyWithImpl<$Res, _$PumpStationStateImpl>
    implements _$$PumpStationStateImplCopyWith<$Res> {
  __$$PumpStationStateImplCopyWithImpl(_$PumpStationStateImpl _value,
      $Res Function(_$PumpStationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PumpStationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reservoir = null,
    Object? reservoirSize = null,
    Object? time = null,
    Object? pumps = null,
    Object? valveSpeed = null,
  }) {
    return _then(_$PumpStationStateImpl(
      reservoir: null == reservoir
          ? _value.reservoir
          : reservoir // ignore: cast_nullable_to_non_nullable
              as int,
      reservoirSize: null == reservoirSize
          ? _value.reservoirSize
          : reservoirSize // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      pumps: null == pumps
          ? _value._pumps
          : pumps // ignore: cast_nullable_to_non_nullable
              as Map<int, PumpState>,
      valveSpeed: null == valveSpeed
          ? _value.valveSpeed
          : valveSpeed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PumpStationStateImpl extends _PumpStationState {
  const _$PumpStationStateImpl(
      {required this.reservoir,
      required this.reservoirSize,
      required this.time,
      required final Map<int, PumpState> pumps,
      required this.valveSpeed})
      : _pumps = pumps,
        super._();

// required PumpStationMode mode,
  @override
  final int reservoir;
  @override
  final int reservoirSize;
  @override
  final int time;
  final Map<int, PumpState> _pumps;
  @override
  Map<int, PumpState> get pumps {
    if (_pumps is EqualUnmodifiableMapView) return _pumps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pumps);
  }

  @override
  final int valveSpeed;

  @override
  String toString() {
    return 'PumpStationState(reservoir: $reservoir, reservoirSize: $reservoirSize, time: $time, pumps: $pumps, valveSpeed: $valveSpeed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PumpStationStateImpl &&
            (identical(other.reservoir, reservoir) ||
                other.reservoir == reservoir) &&
            (identical(other.reservoirSize, reservoirSize) ||
                other.reservoirSize == reservoirSize) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._pumps, _pumps) &&
            (identical(other.valveSpeed, valveSpeed) ||
                other.valveSpeed == valveSpeed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reservoir, reservoirSize, time,
      const DeepCollectionEquality().hash(_pumps), valveSpeed);

  /// Create a copy of PumpStationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PumpStationStateImplCopyWith<_$PumpStationStateImpl> get copyWith =>
      __$$PumpStationStateImplCopyWithImpl<_$PumpStationStateImpl>(
          this, _$identity);
}

abstract class _PumpStationState extends PumpStationState {
  const factory _PumpStationState(
      {required final int reservoir,
      required final int reservoirSize,
      required final int time,
      required final Map<int, PumpState> pumps,
      required final int valveSpeed}) = _$PumpStationStateImpl;
  const _PumpStationState._() : super._();

// required PumpStationMode mode,
  @override
  int get reservoir;
  @override
  int get reservoirSize;
  @override
  int get time;
  @override
  Map<int, PumpState> get pumps;
  @override
  int get valveSpeed;

  /// Create a copy of PumpStationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PumpStationStateImplCopyWith<_$PumpStationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PumpState {
  PumpMode get mode => throw _privateConstructorUsedError;
  int get operatingTime => throw _privateConstructorUsedError;

  /// Create a copy of PumpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PumpStateCopyWith<PumpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PumpStateCopyWith<$Res> {
  factory $PumpStateCopyWith(PumpState value, $Res Function(PumpState) then) =
      _$PumpStateCopyWithImpl<$Res, PumpState>;
  @useResult
  $Res call({PumpMode mode, int operatingTime});
}

/// @nodoc
class _$PumpStateCopyWithImpl<$Res, $Val extends PumpState>
    implements $PumpStateCopyWith<$Res> {
  _$PumpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PumpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? operatingTime = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PumpMode,
      operatingTime: null == operatingTime
          ? _value.operatingTime
          : operatingTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PumpStateImplCopyWith<$Res>
    implements $PumpStateCopyWith<$Res> {
  factory _$$PumpStateImplCopyWith(
          _$PumpStateImpl value, $Res Function(_$PumpStateImpl) then) =
      __$$PumpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PumpMode mode, int operatingTime});
}

/// @nodoc
class __$$PumpStateImplCopyWithImpl<$Res>
    extends _$PumpStateCopyWithImpl<$Res, _$PumpStateImpl>
    implements _$$PumpStateImplCopyWith<$Res> {
  __$$PumpStateImplCopyWithImpl(
      _$PumpStateImpl _value, $Res Function(_$PumpStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PumpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? operatingTime = null,
  }) {
    return _then(_$PumpStateImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PumpMode,
      operatingTime: null == operatingTime
          ? _value.operatingTime
          : operatingTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PumpStateImpl implements _PumpState {
  const _$PumpStateImpl({this.mode = PumpMode.idle, this.operatingTime = 0});

  @override
  @JsonKey()
  final PumpMode mode;
  @override
  @JsonKey()
  final int operatingTime;

  @override
  String toString() {
    return 'PumpState(mode: $mode, operatingTime: $operatingTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PumpStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.operatingTime, operatingTime) ||
                other.operatingTime == operatingTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode, operatingTime);

  /// Create a copy of PumpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PumpStateImplCopyWith<_$PumpStateImpl> get copyWith =>
      __$$PumpStateImplCopyWithImpl<_$PumpStateImpl>(this, _$identity);
}

abstract class _PumpState implements PumpState {
  const factory _PumpState({final PumpMode mode, final int operatingTime}) =
      _$PumpStateImpl;

  @override
  PumpMode get mode;
  @override
  int get operatingTime;

  /// Create a copy of PumpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PumpStateImplCopyWith<_$PumpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
