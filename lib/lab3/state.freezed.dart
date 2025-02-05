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
mixin _$ElevatorState {
  ElevatorMode get mode => throw _privateConstructorUsedError;
  Direction? get direction => throw _privateConstructorUsedError;
  double get pos => throw _privateConstructorUsedError;
  int get floors => throw _privateConstructorUsedError;
  Set<int> get callsUp => throw _privateConstructorUsedError;
  Set<int> get callsDown => throw _privateConstructorUsedError;
  Set<int> get requestedStops => throw _privateConstructorUsedError;
  double get doorsPos => throw _privateConstructorUsedError;
  double? get doorsTimer => throw _privateConstructorUsedError;

  /// Create a copy of ElevatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElevatorStateCopyWith<ElevatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElevatorStateCopyWith<$Res> {
  factory $ElevatorStateCopyWith(
          ElevatorState value, $Res Function(ElevatorState) then) =
      _$ElevatorStateCopyWithImpl<$Res, ElevatorState>;
  @useResult
  $Res call(
      {ElevatorMode mode,
      Direction? direction,
      double pos,
      int floors,
      Set<int> callsUp,
      Set<int> callsDown,
      Set<int> requestedStops,
      double doorsPos,
      double? doorsTimer});
}

/// @nodoc
class _$ElevatorStateCopyWithImpl<$Res, $Val extends ElevatorState>
    implements $ElevatorStateCopyWith<$Res> {
  _$ElevatorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElevatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? direction = freezed,
    Object? pos = null,
    Object? floors = null,
    Object? callsUp = null,
    Object? callsDown = null,
    Object? requestedStops = null,
    Object? doorsPos = null,
    Object? doorsTimer = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ElevatorMode,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as double,
      floors: null == floors
          ? _value.floors
          : floors // ignore: cast_nullable_to_non_nullable
              as int,
      callsUp: null == callsUp
          ? _value.callsUp
          : callsUp // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      callsDown: null == callsDown
          ? _value.callsDown
          : callsDown // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      requestedStops: null == requestedStops
          ? _value.requestedStops
          : requestedStops // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      doorsPos: null == doorsPos
          ? _value.doorsPos
          : doorsPos // ignore: cast_nullable_to_non_nullable
              as double,
      doorsTimer: freezed == doorsTimer
          ? _value.doorsTimer
          : doorsTimer // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ElevatorStateImplCopyWith<$Res>
    implements $ElevatorStateCopyWith<$Res> {
  factory _$$ElevatorStateImplCopyWith(
          _$ElevatorStateImpl value, $Res Function(_$ElevatorStateImpl) then) =
      __$$ElevatorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ElevatorMode mode,
      Direction? direction,
      double pos,
      int floors,
      Set<int> callsUp,
      Set<int> callsDown,
      Set<int> requestedStops,
      double doorsPos,
      double? doorsTimer});
}

/// @nodoc
class __$$ElevatorStateImplCopyWithImpl<$Res>
    extends _$ElevatorStateCopyWithImpl<$Res, _$ElevatorStateImpl>
    implements _$$ElevatorStateImplCopyWith<$Res> {
  __$$ElevatorStateImplCopyWithImpl(
      _$ElevatorStateImpl _value, $Res Function(_$ElevatorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ElevatorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? direction = freezed,
    Object? pos = null,
    Object? floors = null,
    Object? callsUp = null,
    Object? callsDown = null,
    Object? requestedStops = null,
    Object? doorsPos = null,
    Object? doorsTimer = freezed,
  }) {
    return _then(_$ElevatorStateImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ElevatorMode,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction?,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as double,
      floors: null == floors
          ? _value.floors
          : floors // ignore: cast_nullable_to_non_nullable
              as int,
      callsUp: null == callsUp
          ? _value._callsUp
          : callsUp // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      callsDown: null == callsDown
          ? _value._callsDown
          : callsDown // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      requestedStops: null == requestedStops
          ? _value._requestedStops
          : requestedStops // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      doorsPos: null == doorsPos
          ? _value.doorsPos
          : doorsPos // ignore: cast_nullable_to_non_nullable
              as double,
      doorsTimer: freezed == doorsTimer
          ? _value.doorsTimer
          : doorsTimer // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ElevatorStateImpl extends _ElevatorState {
  const _$ElevatorStateImpl(
      {required this.mode,
      this.direction,
      required this.pos,
      required this.floors,
      required final Set<int> callsUp,
      required final Set<int> callsDown,
      required final Set<int> requestedStops,
      required this.doorsPos,
      this.doorsTimer})
      : _callsUp = callsUp,
        _callsDown = callsDown,
        _requestedStops = requestedStops,
        super._();

  @override
  final ElevatorMode mode;
  @override
  final Direction? direction;
  @override
  final double pos;
  @override
  final int floors;
  final Set<int> _callsUp;
  @override
  Set<int> get callsUp {
    if (_callsUp is EqualUnmodifiableSetView) return _callsUp;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_callsUp);
  }

  final Set<int> _callsDown;
  @override
  Set<int> get callsDown {
    if (_callsDown is EqualUnmodifiableSetView) return _callsDown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_callsDown);
  }

  final Set<int> _requestedStops;
  @override
  Set<int> get requestedStops {
    if (_requestedStops is EqualUnmodifiableSetView) return _requestedStops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_requestedStops);
  }

  @override
  final double doorsPos;
  @override
  final double? doorsTimer;

  @override
  String toString() {
    return 'ElevatorState(mode: $mode, direction: $direction, pos: $pos, floors: $floors, callsUp: $callsUp, callsDown: $callsDown, requestedStops: $requestedStops, doorsPos: $doorsPos, doorsTimer: $doorsTimer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElevatorStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.pos, pos) || other.pos == pos) &&
            (identical(other.floors, floors) || other.floors == floors) &&
            const DeepCollectionEquality().equals(other._callsUp, _callsUp) &&
            const DeepCollectionEquality()
                .equals(other._callsDown, _callsDown) &&
            const DeepCollectionEquality()
                .equals(other._requestedStops, _requestedStops) &&
            (identical(other.doorsPos, doorsPos) ||
                other.doorsPos == doorsPos) &&
            (identical(other.doorsTimer, doorsTimer) ||
                other.doorsTimer == doorsTimer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mode,
      direction,
      pos,
      floors,
      const DeepCollectionEquality().hash(_callsUp),
      const DeepCollectionEquality().hash(_callsDown),
      const DeepCollectionEquality().hash(_requestedStops),
      doorsPos,
      doorsTimer);

  /// Create a copy of ElevatorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElevatorStateImplCopyWith<_$ElevatorStateImpl> get copyWith =>
      __$$ElevatorStateImplCopyWithImpl<_$ElevatorStateImpl>(this, _$identity);
}

abstract class _ElevatorState extends ElevatorState {
  const factory _ElevatorState(
      {required final ElevatorMode mode,
      final Direction? direction,
      required final double pos,
      required final int floors,
      required final Set<int> callsUp,
      required final Set<int> callsDown,
      required final Set<int> requestedStops,
      required final double doorsPos,
      final double? doorsTimer}) = _$ElevatorStateImpl;
  const _ElevatorState._() : super._();

  @override
  ElevatorMode get mode;
  @override
  Direction? get direction;
  @override
  double get pos;
  @override
  int get floors;
  @override
  Set<int> get callsUp;
  @override
  Set<int> get callsDown;
  @override
  Set<int> get requestedStops;
  @override
  double get doorsPos;
  @override
  double? get doorsTimer;

  /// Create a copy of ElevatorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElevatorStateImplCopyWith<_$ElevatorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
