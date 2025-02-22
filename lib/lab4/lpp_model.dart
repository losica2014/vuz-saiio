import 'package:freezed_annotation/freezed_annotation.dart';

part 'lpp_model.freezed.dart';

@freezed
class LPPModel with _$LPPModel {
  const factory LPPModel({
    required List<double> targetEquation,
    required double targetValue,
    @Default(true) bool targetMax,
    required List<List<double>> constraints,
    required List<Sign> constraintSigns,
    required List<double> constraintValues
  }) = _LPPModel;
}

enum Sign {equal, less, greater, lessOrEqual, greaterOrEqual}