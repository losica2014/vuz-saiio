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

class LPPModels {
  static const models = [
    LPPModel(
      targetEquation: [7, 3],
      targetValue: 0,
      targetMax: true,
      constraints: [
        [3, 2],
        [1, 2],
        [2, 3],
        [1, 0],
        [0, 1]
      ],
      constraintSigns: [Sign.lessOrEqual, Sign.lessOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual],
      constraintValues: [8, 6, 3, 0, 0],
    ),
    LPPModel(
      targetEquation: [2, 1],
      targetValue: 0,
      targetMax: false,
      constraints: [
        [1, 2],
        [2, 1],
        [2, 1],
        [1, 0],
        [0, 1]
      ],
      constraintSigns: [Sign.lessOrEqual, Sign.lessOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual],
      constraintValues: [4, 6, 2, 0, 0],
    ),
    LPPModel(
      targetEquation: [2, 8],
      targetValue: 0,
      targetMax: true,
      constraints: [
        [1, 2],
        [1, 1],
        [3, 1],
        [1, 0],
        [0, 1]
      ],
      constraintSigns: [Sign.greaterOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual],
      constraintValues: [8, 16, 3, 0, 0],
    ),
    LPPModel(
      targetEquation: [6, 2],
      targetValue: 0,
      targetMax: false,
      constraints: [
        [6, 2],
        [1, 3],
        [1, 1],
        [1, 0],
        [0, 1]
      ],
      constraintSigns: [Sign.lessOrEqual, Sign.lessOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual, Sign.greaterOrEqual],
      constraintValues: [8, 6, 16, 0, 0],
    )
  ];
}

enum Sign {equal, less, greater, lessOrEqual, greaterOrEqual}