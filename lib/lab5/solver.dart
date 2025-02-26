import 'package:saiio_lab/lab4/lpp_model.dart';

extension LPPModelSolver on LPPModel {
  /// Simplex-method
  double solve() {
    List<int> bases = List.generate(this.targetEquation.length, (i) => i);
    
    List<List<double>> constraints = List.generate(this.constraintValues.length, (i) {
      final row = List<double>.generate(this.targetEquation.length + this.constraintValues.length + 1, (j) {
        if(j < targetEquation.length) return this.constraints[i][j];
        else if(j < targetEquation.length + this.constraintValues.length) return j - targetEquation.length == i ? 1 : 0;
        else return this.constraintValues[i];
      });
      if(row.last < 0) for(int j = 0; j < row.length; j++) row[j] *= -1;
      return row;
    });

    // List<double> constraintValues = List.from(this.constraintValues);

    _printSimplexTable(constraints);

    return 0;
  }
}

void _printSimplexTable(List<List<double>> t) {
  print("="*80);
  print([for(int i = 1; i <= t.first.length - 1; i++) "x$i", "b"].join('\t'));
  for(int i = 0; i < t.length; i++) {
    print(t[i].join('\t'));
  }
  print("="*80);
}