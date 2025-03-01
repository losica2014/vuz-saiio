// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LPPSimplexSolution {
  bool get success => throw _privateConstructorUsedError;
  double? get result => throw _privateConstructorUsedError;
  List<double>? get coefs => throw _privateConstructorUsedError;
  List<List<double>> get constraints => throw _privateConstructorUsedError;
  List<double> get constraintValues => throw _privateConstructorUsedError;
  List<int> get bases => throw _privateConstructorUsedError;
  int get yCount => throw _privateConstructorUsedError;
  List<double> get targetEquation => throw _privateConstructorUsedError;

  /// Create a copy of LPPSimplexSolution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LPPSimplexSolutionCopyWith<LPPSimplexSolution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LPPSimplexSolutionCopyWith<$Res> {
  factory $LPPSimplexSolutionCopyWith(
          LPPSimplexSolution value, $Res Function(LPPSimplexSolution) then) =
      _$LPPSimplexSolutionCopyWithImpl<$Res, LPPSimplexSolution>;
  @useResult
  $Res call(
      {bool success,
      double? result,
      List<double>? coefs,
      List<List<double>> constraints,
      List<double> constraintValues,
      List<int> bases,
      int yCount,
      List<double> targetEquation});
}

/// @nodoc
class _$LPPSimplexSolutionCopyWithImpl<$Res, $Val extends LPPSimplexSolution>
    implements $LPPSimplexSolutionCopyWith<$Res> {
  _$LPPSimplexSolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LPPSimplexSolution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? result = freezed,
    Object? coefs = freezed,
    Object? constraints = null,
    Object? constraintValues = null,
    Object? bases = null,
    Object? yCount = null,
    Object? targetEquation = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as double?,
      coefs: freezed == coefs
          ? _value.coefs
          : coefs // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      constraints: null == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      constraintValues: null == constraintValues
          ? _value.constraintValues
          : constraintValues // ignore: cast_nullable_to_non_nullable
              as List<double>,
      bases: null == bases
          ? _value.bases
          : bases // ignore: cast_nullable_to_non_nullable
              as List<int>,
      yCount: null == yCount
          ? _value.yCount
          : yCount // ignore: cast_nullable_to_non_nullable
              as int,
      targetEquation: null == targetEquation
          ? _value.targetEquation
          : targetEquation // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LPPSimplexSolutionImplCopyWith<$Res>
    implements $LPPSimplexSolutionCopyWith<$Res> {
  factory _$$LPPSimplexSolutionImplCopyWith(_$LPPSimplexSolutionImpl value,
          $Res Function(_$LPPSimplexSolutionImpl) then) =
      __$$LPPSimplexSolutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      double? result,
      List<double>? coefs,
      List<List<double>> constraints,
      List<double> constraintValues,
      List<int> bases,
      int yCount,
      List<double> targetEquation});
}

/// @nodoc
class __$$LPPSimplexSolutionImplCopyWithImpl<$Res>
    extends _$LPPSimplexSolutionCopyWithImpl<$Res, _$LPPSimplexSolutionImpl>
    implements _$$LPPSimplexSolutionImplCopyWith<$Res> {
  __$$LPPSimplexSolutionImplCopyWithImpl(_$LPPSimplexSolutionImpl _value,
      $Res Function(_$LPPSimplexSolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of LPPSimplexSolution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? result = freezed,
    Object? coefs = freezed,
    Object? constraints = null,
    Object? constraintValues = null,
    Object? bases = null,
    Object? yCount = null,
    Object? targetEquation = null,
  }) {
    return _then(_$LPPSimplexSolutionImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as double?,
      coefs: freezed == coefs
          ? _value._coefs
          : coefs // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      constraints: null == constraints
          ? _value._constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      constraintValues: null == constraintValues
          ? _value._constraintValues
          : constraintValues // ignore: cast_nullable_to_non_nullable
              as List<double>,
      bases: null == bases
          ? _value._bases
          : bases // ignore: cast_nullable_to_non_nullable
              as List<int>,
      yCount: null == yCount
          ? _value.yCount
          : yCount // ignore: cast_nullable_to_non_nullable
              as int,
      targetEquation: null == targetEquation
          ? _value._targetEquation
          : targetEquation // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$LPPSimplexSolutionImpl implements _LPPSimplexSolution {
  const _$LPPSimplexSolutionImpl(
      {this.success = true,
      this.result,
      final List<double>? coefs,
      final List<List<double>> constraints = const [],
      final List<double> constraintValues = const [],
      final List<int> bases = const [],
      this.yCount = 0,
      final List<double> targetEquation = const []})
      : _coefs = coefs,
        _constraints = constraints,
        _constraintValues = constraintValues,
        _bases = bases,
        _targetEquation = targetEquation;

  @override
  @JsonKey()
  final bool success;
  @override
  final double? result;
  final List<double>? _coefs;
  @override
  List<double>? get coefs {
    final value = _coefs;
    if (value == null) return null;
    if (_coefs is EqualUnmodifiableListView) return _coefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<List<double>> _constraints;
  @override
  @JsonKey()
  List<List<double>> get constraints {
    if (_constraints is EqualUnmodifiableListView) return _constraints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constraints);
  }

  final List<double> _constraintValues;
  @override
  @JsonKey()
  List<double> get constraintValues {
    if (_constraintValues is EqualUnmodifiableListView)
      return _constraintValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constraintValues);
  }

  final List<int> _bases;
  @override
  @JsonKey()
  List<int> get bases {
    if (_bases is EqualUnmodifiableListView) return _bases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bases);
  }

  @override
  @JsonKey()
  final int yCount;
  final List<double> _targetEquation;
  @override
  @JsonKey()
  List<double> get targetEquation {
    if (_targetEquation is EqualUnmodifiableListView) return _targetEquation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetEquation);
  }

  @override
  String toString() {
    return 'LPPSimplexSolution(success: $success, result: $result, coefs: $coefs, constraints: $constraints, constraintValues: $constraintValues, bases: $bases, yCount: $yCount, targetEquation: $targetEquation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LPPSimplexSolutionImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.result, result) || other.result == result) &&
            const DeepCollectionEquality().equals(other._coefs, _coefs) &&
            const DeepCollectionEquality()
                .equals(other._constraints, _constraints) &&
            const DeepCollectionEquality()
                .equals(other._constraintValues, _constraintValues) &&
            const DeepCollectionEquality().equals(other._bases, _bases) &&
            (identical(other.yCount, yCount) || other.yCount == yCount) &&
            const DeepCollectionEquality()
                .equals(other._targetEquation, _targetEquation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      result,
      const DeepCollectionEquality().hash(_coefs),
      const DeepCollectionEquality().hash(_constraints),
      const DeepCollectionEquality().hash(_constraintValues),
      const DeepCollectionEquality().hash(_bases),
      yCount,
      const DeepCollectionEquality().hash(_targetEquation));

  /// Create a copy of LPPSimplexSolution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LPPSimplexSolutionImplCopyWith<_$LPPSimplexSolutionImpl> get copyWith =>
      __$$LPPSimplexSolutionImplCopyWithImpl<_$LPPSimplexSolutionImpl>(
          this, _$identity);
}

abstract class _LPPSimplexSolution implements LPPSimplexSolution {
  const factory _LPPSimplexSolution(
      {final bool success,
      final double? result,
      final List<double>? coefs,
      final List<List<double>> constraints,
      final List<double> constraintValues,
      final List<int> bases,
      final int yCount,
      final List<double> targetEquation}) = _$LPPSimplexSolutionImpl;

  @override
  bool get success;
  @override
  double? get result;
  @override
  List<double>? get coefs;
  @override
  List<List<double>> get constraints;
  @override
  List<double> get constraintValues;
  @override
  List<int> get bases;
  @override
  int get yCount;
  @override
  List<double> get targetEquation;

  /// Create a copy of LPPSimplexSolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LPPSimplexSolutionImplCopyWith<_$LPPSimplexSolutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
