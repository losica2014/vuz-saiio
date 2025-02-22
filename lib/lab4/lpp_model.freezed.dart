// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lpp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LPPModel {
  List<double> get targetEquation => throw _privateConstructorUsedError;
  double get targetValue => throw _privateConstructorUsedError;
  bool get targetMax => throw _privateConstructorUsedError;
  List<List<double>> get constraints => throw _privateConstructorUsedError;
  List<Sign> get constraintSigns => throw _privateConstructorUsedError;
  List<double> get constraintValues => throw _privateConstructorUsedError;

  /// Create a copy of LPPModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LPPModelCopyWith<LPPModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LPPModelCopyWith<$Res> {
  factory $LPPModelCopyWith(LPPModel value, $Res Function(LPPModel) then) =
      _$LPPModelCopyWithImpl<$Res, LPPModel>;
  @useResult
  $Res call(
      {List<double> targetEquation,
      double targetValue,
      bool targetMax,
      List<List<double>> constraints,
      List<Sign> constraintSigns,
      List<double> constraintValues});
}

/// @nodoc
class _$LPPModelCopyWithImpl<$Res, $Val extends LPPModel>
    implements $LPPModelCopyWith<$Res> {
  _$LPPModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LPPModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetEquation = null,
    Object? targetValue = null,
    Object? targetMax = null,
    Object? constraints = null,
    Object? constraintSigns = null,
    Object? constraintValues = null,
  }) {
    return _then(_value.copyWith(
      targetEquation: null == targetEquation
          ? _value.targetEquation
          : targetEquation // ignore: cast_nullable_to_non_nullable
              as List<double>,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      targetMax: null == targetMax
          ? _value.targetMax
          : targetMax // ignore: cast_nullable_to_non_nullable
              as bool,
      constraints: null == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      constraintSigns: null == constraintSigns
          ? _value.constraintSigns
          : constraintSigns // ignore: cast_nullable_to_non_nullable
              as List<Sign>,
      constraintValues: null == constraintValues
          ? _value.constraintValues
          : constraintValues // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LPPModelImplCopyWith<$Res>
    implements $LPPModelCopyWith<$Res> {
  factory _$$LPPModelImplCopyWith(
          _$LPPModelImpl value, $Res Function(_$LPPModelImpl) then) =
      __$$LPPModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<double> targetEquation,
      double targetValue,
      bool targetMax,
      List<List<double>> constraints,
      List<Sign> constraintSigns,
      List<double> constraintValues});
}

/// @nodoc
class __$$LPPModelImplCopyWithImpl<$Res>
    extends _$LPPModelCopyWithImpl<$Res, _$LPPModelImpl>
    implements _$$LPPModelImplCopyWith<$Res> {
  __$$LPPModelImplCopyWithImpl(
      _$LPPModelImpl _value, $Res Function(_$LPPModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LPPModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetEquation = null,
    Object? targetValue = null,
    Object? targetMax = null,
    Object? constraints = null,
    Object? constraintSigns = null,
    Object? constraintValues = null,
  }) {
    return _then(_$LPPModelImpl(
      targetEquation: null == targetEquation
          ? _value._targetEquation
          : targetEquation // ignore: cast_nullable_to_non_nullable
              as List<double>,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double,
      targetMax: null == targetMax
          ? _value.targetMax
          : targetMax // ignore: cast_nullable_to_non_nullable
              as bool,
      constraints: null == constraints
          ? _value._constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      constraintSigns: null == constraintSigns
          ? _value._constraintSigns
          : constraintSigns // ignore: cast_nullable_to_non_nullable
              as List<Sign>,
      constraintValues: null == constraintValues
          ? _value._constraintValues
          : constraintValues // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$LPPModelImpl implements _LPPModel {
  const _$LPPModelImpl(
      {required final List<double> targetEquation,
      required this.targetValue,
      this.targetMax = true,
      required final List<List<double>> constraints,
      required final List<Sign> constraintSigns,
      required final List<double> constraintValues})
      : _targetEquation = targetEquation,
        _constraints = constraints,
        _constraintSigns = constraintSigns,
        _constraintValues = constraintValues;

  final List<double> _targetEquation;
  @override
  List<double> get targetEquation {
    if (_targetEquation is EqualUnmodifiableListView) return _targetEquation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetEquation);
  }

  @override
  final double targetValue;
  @override
  @JsonKey()
  final bool targetMax;
  final List<List<double>> _constraints;
  @override
  List<List<double>> get constraints {
    if (_constraints is EqualUnmodifiableListView) return _constraints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constraints);
  }

  final List<Sign> _constraintSigns;
  @override
  List<Sign> get constraintSigns {
    if (_constraintSigns is EqualUnmodifiableListView) return _constraintSigns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constraintSigns);
  }

  final List<double> _constraintValues;
  @override
  List<double> get constraintValues {
    if (_constraintValues is EqualUnmodifiableListView)
      return _constraintValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constraintValues);
  }

  @override
  String toString() {
    return 'LPPModel(targetEquation: $targetEquation, targetValue: $targetValue, targetMax: $targetMax, constraints: $constraints, constraintSigns: $constraintSigns, constraintValues: $constraintValues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LPPModelImpl &&
            const DeepCollectionEquality()
                .equals(other._targetEquation, _targetEquation) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.targetMax, targetMax) ||
                other.targetMax == targetMax) &&
            const DeepCollectionEquality()
                .equals(other._constraints, _constraints) &&
            const DeepCollectionEquality()
                .equals(other._constraintSigns, _constraintSigns) &&
            const DeepCollectionEquality()
                .equals(other._constraintValues, _constraintValues));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_targetEquation),
      targetValue,
      targetMax,
      const DeepCollectionEquality().hash(_constraints),
      const DeepCollectionEquality().hash(_constraintSigns),
      const DeepCollectionEquality().hash(_constraintValues));

  /// Create a copy of LPPModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LPPModelImplCopyWith<_$LPPModelImpl> get copyWith =>
      __$$LPPModelImplCopyWithImpl<_$LPPModelImpl>(this, _$identity);
}

abstract class _LPPModel implements LPPModel {
  const factory _LPPModel(
      {required final List<double> targetEquation,
      required final double targetValue,
      final bool targetMax,
      required final List<List<double>> constraints,
      required final List<Sign> constraintSigns,
      required final List<double> constraintValues}) = _$LPPModelImpl;

  @override
  List<double> get targetEquation;
  @override
  double get targetValue;
  @override
  bool get targetMax;
  @override
  List<List<double>> get constraints;
  @override
  List<Sign> get constraintSigns;
  @override
  List<double> get constraintValues;

  /// Create a copy of LPPModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LPPModelImplCopyWith<_$LPPModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
