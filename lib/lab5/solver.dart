import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saiio_lab/lab4/lpp_model.dart';

part 'solver.freezed.dart';

extension LPPModelSolver on LPPModel {
  /// M-method
  LPPSimplexSolution solve() {
    double M = 1000;
    // Индексы базисных переменных
    List<int> bases = [];

    // Коэффициенты при x_i, y_*
    List<List<double>> constraints = [];
    // Значения b_i
    List<double> constraintValues = [];

    // Коэффициенты при x_i в рассматриваемой функции
    List<double> targetEquation = [];

    int yCount = 0;

    for(int i = 0; i < this.constraints.length; i++) {
      List<double> row = [];
      int base = 0;

      bool shouldInvert = [Sign.greater, Sign.greaterOrEqual].contains(this.constraintSigns[i]);
      int invertCoef = shouldInvert ? -1 : 1;

      // Добавление коэффициентов при основных неизвестных
      for(int j = 0; j < this.targetEquation.length; j++) {
        row.add(this.constraints[i][j] * invertCoef);
      }

      // Добавление коэффициентов при введённом базисе
      for(int j = 0; j < this.constraints.length; j++) {
        row.add(j == i ? 1 : 0);
        if(j == i) base = row.length - 1;
      }

      // Добавление b_i
      constraintValues.add(this.constraintValues[i] * invertCoef);

      // Инвертирование знаков, если b_i < 0
      if(constraintValues.last < 0) {
        for(int j = 0; j < row.length; j++) {
          row[j] *= -1;
        }

        constraintValues.last *= -1;

        // Добавление нового неизвестного y_* = 1 (все остальные y_* = 0)
        for(int j = 0; j < yCount; j++) {
          row.add(0);
        }

        yCount++;
        row.add(1);
        base = row.length - 1;
      }

      constraints.add(row);
      bases.add(base);
    }

    // Добавление оставшихся нулевых коэффициентов при y_*
    for(int i = 0; i < constraints.length; i++) {
      for(int j = constraints[i].length; j < this.targetEquation.length + this.constraints.length + yCount; j++) {
        constraints[i].add(0);
      }
    }

    // Добавление коэффициентов в рассматриваемую функцию (c_i)
    for(int i = 0; i < this.targetEquation.length; i++) {
      targetEquation.add(this.targetEquation[i]);
    }

    for(int i = 0; i < this.constraints.length; i++) {
      targetEquation.add(0);
    }

    for(int i = 0; i < yCount; i++) {
      targetEquation.add((targetMax ? -1 : 1) * M);
    }

    // Расчёт delta_i
    List<double> deltas = [];
    for(int i = 0; i < constraints[0].length; i++) {
      double delta = 0;
      for(int j = 0; j < constraints.length; j++) {
        delta += constraints[j][i] * targetEquation[bases[j]];
      }
      delta -= targetEquation[i];
      deltas.add(delta);
    }
    double delta0 = 0;
    for(int i = 0; i < constraints.length; i++) {
      delta0 += constraintValues[i] * targetEquation[bases[i]];
    }
    
    _printSimplexTable(constraints, constraintValues, targetEquation, bases, yCount, deltas, delta0);

    bool shouldContinue;
    int iter = 0;
    do {
      // Разрешающий столбец
      int? minDeltaIndex;
      for(int i = 0; i < deltas.length; i++) {
        if(minDeltaIndex == null || (targetMax ? 1 : -1) * deltas[i] < (targetMax ? 1 : -1) * deltas[minDeltaIndex]) minDeltaIndex = i;
      }
      if (minDeltaIndex == null) {
        print("Нет допустимых решений для выбора разрешающего столбца.");
        return LPPSimplexSolution(
          success: false,
          result: null,
          coefs: deltas,
          constraints: constraints,
          constraintValues: constraintValues,
          bases: bases,
          yCount: yCount,
          targetEquation: targetEquation
        );
      }

      List<double> options = [];
      for(int i = 0; i < constraints.length; i++) {
        options.add(constraintValues[i] / constraints[i][minDeltaIndex]);
      }
      // Разрешающая строка
      int? minOptionIndex;
      for(int i = 0; i < options.length; i++) {
        if((minOptionIndex == null || options[i] < options[minOptionIndex]) && options[i] > 0) minOptionIndex = i;
      }
      if (minOptionIndex == null || options[minOptionIndex] <= 0) {
        print("Нет допустимых решений для выбора разрешающей строки.");
        return LPPSimplexSolution(
          success: false,
          result: null,
          coefs: deltas,
          constraints: constraints,
          constraintValues: constraintValues,
          bases: bases,
          yCount: yCount,
          targetEquation: targetEquation
        );
      }
      bases[minOptionIndex] = minDeltaIndex;

      List<List<double>> newConstraints = List.generate(constraints.length, (i) => List.from(constraints[i]));
      List<double> newConstraintValues = List.from(constraintValues);
      for(int i = 0; i < constraints.length; i++) {
        for(int j = 0; j < constraints[i].length; j++) {
          if(i == minOptionIndex) {
            newConstraints[i][j] /= constraints[minOptionIndex][minDeltaIndex];
          } else if(j == minDeltaIndex) {
            newConstraints[i][j] = 0;
          } else {
            newConstraints[i][j] = constraints[i][j] - constraints[minOptionIndex][j] * constraints[i][minDeltaIndex] / constraints[minOptionIndex][minDeltaIndex];
          }
          if(newConstraints[i][j].isNaN) newConstraints[i][j] = 0;
        }
      }
      for(int i = 0; i < constraintValues.length; i++) {
        if(i == minOptionIndex) {
          newConstraintValues[i] /= constraints[minOptionIndex][minDeltaIndex];
        } else {
          newConstraintValues[i] = constraintValues[i] - constraintValues[minOptionIndex] * constraints[i][minDeltaIndex] / constraints[minOptionIndex][minDeltaIndex];
        }
        if(newConstraintValues[i].isNaN) newConstraintValues[i] = 0;
      }

      constraintValues = newConstraintValues;
      constraints = newConstraints;
      
      // Расчёт delta_i
      deltas = [];
      for(int i = 0; i < constraints[0].length; i++) {
        double delta = 0;
        for(int j = 0; j < constraints.length; j++) {
          delta += constraints[j][i] * targetEquation[bases[j]];
        }
        delta -= targetEquation[i];
        deltas.add(delta);
      }
      delta0 = 0;
      for(int i = 0; i < constraints.length; i++) {
        delta0 += constraintValues[i] * targetEquation[bases[i]];
      }

      // print("Базис: ${bases.map((e) => e + 1,).join(', ')}");
      print("======== Новый шаг ========");
      print("Разрешающий столбец: ${minDeltaIndex+1}, разрешающая строка: ${minOptionIndex+1}");
      print("Коэффициенты, обосновывающие выбор: " + options.map((e) => e.toStringAsFixed(2)).join(', '));
      _printSimplexTable(constraints, constraintValues, targetEquation, bases, yCount, deltas, delta0);
      
      // shouldContinue = deltas.any((d) => d < 0) || delta0 < 0;
      shouldContinue = deltas.asMap().entries.any((entry) => (targetMax ? 1 : -1) * entry.value < 0 && !bases.contains(entry.key));

      iter++;
    } while(shouldContinue && iter < 100);
    if(iter == 100) print("Превышено максимальное количество итераций.");

    // _printSimplexTable(constraints);
    double f = delta0;
    List<double> fCoefs = deltas;

    print(f);
    print(fCoefs);

    if(f > M) {
      return LPPSimplexSolution(
        result: null,
        coefs: fCoefs,
        constraints: constraints,
        constraintValues: constraintValues,
        bases: bases,
        yCount: yCount,
        targetEquation: targetEquation
      );
    } else {
      return LPPSimplexSolution(
        result: f,
        coefs: fCoefs,
        constraints: constraints,
        constraintValues: constraintValues,
        bases: bases,
        yCount: yCount,
        targetEquation: targetEquation
      );
    }
  }
}

void _printSimplexTable(List<List<double>> constraints, List<double> constraintValues, List<double> targetEquation, List<int> bases, int yCount, List<double> deltas, double delta0) {
  print("="*80);
  print(["базис", "b", for(int i = 1; i <= targetEquation.length - yCount; i++) "x$i", for(int i = 0; i < yCount; i++) "y$i"].join('\t'));
  for(int i = 0; i < constraints.length; i++) {
    List<double> row = constraints[i];
    String base = "x${bases[i]+1}";
    if(bases[i] >= targetEquation.length - yCount) base = "y${bases[i] - (targetEquation.length - yCount)}";
    print([base, constraintValues[i], ...row].map((e) => e is double ? e.toStringAsFixed(2) : e.toString()).join('\t'));
  }
  print(["f(x)", "", ...targetEquation].map((e) => e is double ? e.toStringAsFixed(2) : e.toString()).join('\t'));
  print(["delta", delta0, ...deltas].map((e) => e is double ? e.toStringAsFixed(2) : e.toString()).join('\t'));
  print("="*80);
}

@freezed
class LPPSimplexSolution with _$LPPSimplexSolution {
  const factory LPPSimplexSolution({
    @Default(true) bool success,
    double? result,
    List<double>? coefs,
    @Default([]) List<List<double>> constraints,
    @Default([]) List<double> constraintValues,
    @Default([]) List<int> bases,
    @Default(0) int yCount,
    @Default([]) List<double> targetEquation
  }) = _LPPSimplexSolution;
}