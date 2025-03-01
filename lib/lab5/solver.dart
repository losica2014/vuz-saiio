import 'package:saiio_lab/lab4/lpp_model.dart';

extension LPPModelSolver on LPPModel {
  /// M-method
  double solve() {
    double M = double.infinity;
    // Индексы базисных переменных
    List<int> bases = [];
    
    // List<List<double>> constraints = List.generate(this.constraintValues.length, (i) {
    //   final row = List<double>.generate(this.targetEquation.length + this.constraintValues.length + 1, (j) {
    //     if(j < targetEquation.length) return this.constraints[i][j];
    //     else if(j < targetEquation.length + this.constraintValues.length) return j - targetEquation.length == i ? 1 : 0;
    //     else return this.constraintValues[i];
    //   });
    //   if(row.last < 0) for(int j = 0; j < row.length; j++) row[j] *= -1;
    //   return row;
    // });

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

      // Добавление коэффициентов при основных неизвестных
      for(int j = 0; j < this.constraints[i].length; j++) {
        row.add(this.constraints[i][j]);
      }

      // Добавление коэффициентов при введённом базисе
      for(int j = 0; j < this.constraints.length; j++) {
        if(j == i) base = row.length - 1;
        row.add(j == i ? 1 : 0);
      }

      // Добавление b_i
      constraintValues.add(this.constraintValues[i]);

      // Инвертирование знаков, если b_i < 0
      if(constraintValues.last < 0) {
        for(int j = 0; j < row.length; j++) {
          row[j] *= -1;
        }

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
      for(int j = 0; j < this.constraints[i].length + this.constraints.length + yCount - constraints[i].length; j++) {
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
      targetEquation.add(-M);
    }

    // Расчёт delta_i
    List<double> deltas = [];
    for(int i = 0; i < constraints[0].length; i++) {
      double delta = 0;
      for(int j = 0; j < constraints.length; j++) {
        delta += constraints[j][i] * targetEquation[bases[j]];
      }
      deltas.add(delta);
    }
    double delta0 = 0;
    for(int i = 0; i < constraints.length; i++) {
      delta0 += constraintValues[i] * targetEquation[bases[i]];
    }

    bool shouldContinue;

    do {
      // Разрешающий столбец
      int minDeltaIndex = 0;
      for(int i = 1; i < deltas.length; i++) {
        if(deltas[i] < deltas[minDeltaIndex]) minDeltaIndex = i;
      }

      List<double> options = [];
      for(int i = 0; i < constraints.length; i++) {
        options.add(constraintValues[i] / constraints[i][minDeltaIndex]);
      }
      // Разрешающая строка
      int minOptionIndex = 0;
      for(int i = 1; i < options.length; i++) {
        if(options[i] < options[minOptionIndex] && options[i] > 0) minOptionIndex = i;
      }
      bases[minOptionIndex] = minDeltaIndex;

      List<List<double>> newConstraints = List.generate(constraints.length, (i) => List.from(constraints[i]));
      List<double> newConstraintValues = List.from(constraintValues);
      for(int i = 0; i < constraints.length; i++) {
        for(int j = 0; j < constraints[i].length; j++) {
          if(i == minOptionIndex) {
            newConstraints[i][j] /= options[minOptionIndex];
          } else if(j == minDeltaIndex) {
            newConstraints[i][j] = 0;
          } else {
            newConstraints[i][j] = constraintValues[i] - constraintValues[minOptionIndex] * constraints[i][minDeltaIndex] / constraints[minOptionIndex][minDeltaIndex];
          }
        }
      }
      for(int i = 0; i < constraintValues.length; i++) {
        if(i == minOptionIndex) {
          newConstraintValues[i] /= options[minOptionIndex];
        } else {
          newConstraintValues[i] = constraintValues[i] - constraintValues[minOptionIndex] * constraints[i][minDeltaIndex] / constraints[minOptionIndex][minDeltaIndex];
        }
      }
      
      // Расчёт delta_i
      deltas = [];
      for(int i = 0; i < constraints[0].length; i++) {
        double delta = 0;
        for(int j = 0; j < constraints.length; j++) {
          delta += constraints[j][i] * targetEquation[bases[j]];
        }
        deltas.add(delta);
      }
      delta0 = 0;
      for(int i = 0; i < constraints.length; i++) {
        delta0 += constraintValues[i] * targetEquation[bases[i]];
      }

      print("Базис: ${bases.join(', ')}");
      print("Разрешающий столбец: $minDeltaIndex, разрешающая строка: $minOptionIndex");
      
      shouldContinue = deltas.any((d) => d < 0) || delta0 < 0;
    } while(shouldContinue);

    // _printSimplexTable(constraints);
    double f = delta0;
    List<double> f_coefs = List.from(targetEquation);

    print(f);
    print(f_coefs);

    return f;
  }
}

// void _printSimplexTable(List<List<double>> constraints, List<double> values) {
//   print("="*80);
//   print([for(int i = 1; i <= t.first.length - 1; i++) "x$i", "b"].join('\t'));
//   for(int i = 0; i < t.length; i++) {
//     print(t[i].join('\t'));
//   }
//   print("="*80);
// }