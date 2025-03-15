// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransportProblem {
  List<List<double>> get prices => throw _privateConstructorUsedError;
  List<double> get supply => throw _privateConstructorUsedError;
  List<double> get demand => throw _privateConstructorUsedError;

  /// Create a copy of TransportProblem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransportProblemCopyWith<TransportProblem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransportProblemCopyWith<$Res> {
  factory $TransportProblemCopyWith(
          TransportProblem value, $Res Function(TransportProblem) then) =
      _$TransportProblemCopyWithImpl<$Res, TransportProblem>;
  @useResult
  $Res call(
      {List<List<double>> prices, List<double> supply, List<double> demand});
}

/// @nodoc
class _$TransportProblemCopyWithImpl<$Res, $Val extends TransportProblem>
    implements $TransportProblemCopyWith<$Res> {
  _$TransportProblemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransportProblem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prices = null,
    Object? supply = null,
    Object? demand = null,
  }) {
    return _then(_value.copyWith(
      prices: null == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as List<double>,
      demand: null == demand
          ? _value.demand
          : demand // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransportProblemImplCopyWith<$Res>
    implements $TransportProblemCopyWith<$Res> {
  factory _$$TransportProblemImplCopyWith(_$TransportProblemImpl value,
          $Res Function(_$TransportProblemImpl) then) =
      __$$TransportProblemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<double>> prices, List<double> supply, List<double> demand});
}

/// @nodoc
class __$$TransportProblemImplCopyWithImpl<$Res>
    extends _$TransportProblemCopyWithImpl<$Res, _$TransportProblemImpl>
    implements _$$TransportProblemImplCopyWith<$Res> {
  __$$TransportProblemImplCopyWithImpl(_$TransportProblemImpl _value,
      $Res Function(_$TransportProblemImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransportProblem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prices = null,
    Object? supply = null,
    Object? demand = null,
  }) {
    return _then(_$TransportProblemImpl(
      prices: null == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      supply: null == supply
          ? _value._supply
          : supply // ignore: cast_nullable_to_non_nullable
              as List<double>,
      demand: null == demand
          ? _value._demand
          : demand // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$TransportProblemImpl extends _TransportProblem {
  const _$TransportProblemImpl(
      {required final List<List<double>> prices,
      required final List<double> supply,
      required final List<double> demand})
      : _prices = prices,
        _supply = supply,
        _demand = demand,
        super._();

  final List<List<double>> _prices;
  @override
  List<List<double>> get prices {
    if (_prices is EqualUnmodifiableListView) return _prices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prices);
  }

  final List<double> _supply;
  @override
  List<double> get supply {
    if (_supply is EqualUnmodifiableListView) return _supply;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supply);
  }

  final List<double> _demand;
  @override
  List<double> get demand {
    if (_demand is EqualUnmodifiableListView) return _demand;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_demand);
  }

  @override
  String toString() {
    return 'TransportProblem(prices: $prices, supply: $supply, demand: $demand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransportProblemImpl &&
            const DeepCollectionEquality().equals(other._prices, _prices) &&
            const DeepCollectionEquality().equals(other._supply, _supply) &&
            const DeepCollectionEquality().equals(other._demand, _demand));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_prices),
      const DeepCollectionEquality().hash(_supply),
      const DeepCollectionEquality().hash(_demand));

  /// Create a copy of TransportProblem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransportProblemImplCopyWith<_$TransportProblemImpl> get copyWith =>
      __$$TransportProblemImplCopyWithImpl<_$TransportProblemImpl>(
          this, _$identity);
}

abstract class _TransportProblem extends TransportProblem {
  const factory _TransportProblem(
      {required final List<List<double>> prices,
      required final List<double> supply,
      required final List<double> demand}) = _$TransportProblemImpl;
  const _TransportProblem._() : super._();

  @override
  List<List<double>> get prices;
  @override
  List<double> get supply;
  @override
  List<double> get demand;

  /// Create a copy of TransportProblem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransportProblemImplCopyWith<_$TransportProblemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransportProblemSolution {
  List<List<double?>> get coefs => throw _privateConstructorUsedError;
  TransportProblem get problem => throw _privateConstructorUsedError;

  /// Create a copy of TransportProblemSolution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransportProblemSolutionCopyWith<TransportProblemSolution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransportProblemSolutionCopyWith<$Res> {
  factory $TransportProblemSolutionCopyWith(TransportProblemSolution value,
          $Res Function(TransportProblemSolution) then) =
      _$TransportProblemSolutionCopyWithImpl<$Res, TransportProblemSolution>;
  @useResult
  $Res call({List<List<double?>> coefs, TransportProblem problem});

  $TransportProblemCopyWith<$Res> get problem;
}

/// @nodoc
class _$TransportProblemSolutionCopyWithImpl<$Res,
        $Val extends TransportProblemSolution>
    implements $TransportProblemSolutionCopyWith<$Res> {
  _$TransportProblemSolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransportProblemSolution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coefs = null,
    Object? problem = null,
  }) {
    return _then(_value.copyWith(
      coefs: null == coefs
          ? _value.coefs
          : coefs // ignore: cast_nullable_to_non_nullable
              as List<List<double?>>,
      problem: null == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as TransportProblem,
    ) as $Val);
  }

  /// Create a copy of TransportProblemSolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransportProblemCopyWith<$Res> get problem {
    return $TransportProblemCopyWith<$Res>(_value.problem, (value) {
      return _then(_value.copyWith(problem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransportProblemSolutionImplCopyWith<$Res>
    implements $TransportProblemSolutionCopyWith<$Res> {
  factory _$$TransportProblemSolutionImplCopyWith(
          _$TransportProblemSolutionImpl value,
          $Res Function(_$TransportProblemSolutionImpl) then) =
      __$$TransportProblemSolutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<double?>> coefs, TransportProblem problem});

  @override
  $TransportProblemCopyWith<$Res> get problem;
}

/// @nodoc
class __$$TransportProblemSolutionImplCopyWithImpl<$Res>
    extends _$TransportProblemSolutionCopyWithImpl<$Res,
        _$TransportProblemSolutionImpl>
    implements _$$TransportProblemSolutionImplCopyWith<$Res> {
  __$$TransportProblemSolutionImplCopyWithImpl(
      _$TransportProblemSolutionImpl _value,
      $Res Function(_$TransportProblemSolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransportProblemSolution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coefs = null,
    Object? problem = null,
  }) {
    return _then(_$TransportProblemSolutionImpl(
      coefs: null == coefs
          ? _value._coefs
          : coefs // ignore: cast_nullable_to_non_nullable
              as List<List<double?>>,
      problem: null == problem
          ? _value.problem
          : problem // ignore: cast_nullable_to_non_nullable
              as TransportProblem,
    ));
  }
}

/// @nodoc

class _$TransportProblemSolutionImpl extends _TransportProblemSolution {
  const _$TransportProblemSolutionImpl(
      {required final List<List<double?>> coefs, required this.problem})
      : _coefs = coefs,
        super._();

  final List<List<double?>> _coefs;
  @override
  List<List<double?>> get coefs {
    if (_coefs is EqualUnmodifiableListView) return _coefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coefs);
  }

  @override
  final TransportProblem problem;

  @override
  String toString() {
    return 'TransportProblemSolution(coefs: $coefs, problem: $problem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransportProblemSolutionImpl &&
            const DeepCollectionEquality().equals(other._coefs, _coefs) &&
            (identical(other.problem, problem) || other.problem == problem));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_coefs), problem);

  /// Create a copy of TransportProblemSolution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransportProblemSolutionImplCopyWith<_$TransportProblemSolutionImpl>
      get copyWith => __$$TransportProblemSolutionImplCopyWithImpl<
          _$TransportProblemSolutionImpl>(this, _$identity);
}

abstract class _TransportProblemSolution extends TransportProblemSolution {
  const factory _TransportProblemSolution(
          {required final List<List<double?>> coefs,
          required final TransportProblem problem}) =
      _$TransportProblemSolutionImpl;
  const _TransportProblemSolution._() : super._();

  @override
  List<List<double?>> get coefs;
  @override
  TransportProblem get problem;

  /// Create a copy of TransportProblemSolution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransportProblemSolutionImplCopyWith<_$TransportProblemSolutionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
