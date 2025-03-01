import 'package:flutter/material.dart';

import 'solver.dart';

class SimplexTable extends StatelessWidget {
  const SimplexTable({super.key, required this.solution});

  final LPPSimplexSolution solution;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Text("Базис"),
            Text("B_i"),
            for(int j = 0; j < solution.targetEquation.length - solution.yCount; j++)
              Text("x${j+1}"),
            for(int j = 0; j < solution.yCount; j++)
              Text("y${j+1}")
          ]
        ),
        for(int i = 0; i < solution.constraints.length; i++)
          TableRow(
            children: [
              Text(solution.bases[i] < solution.targetEquation.length - solution.yCount ? "x${solution.bases[i]+1}" : "y${solution.bases[i] - (solution.targetEquation.length - solution.yCount)}"),
              Text(solution.constraintValues[i].toStringAsFixed(2)),
              for(int j = 0; j < solution.constraints[i].length; j++)
                Text(solution.constraints[i][j].toStringAsFixed(2))
            ]
          ),
        TableRow(
          children: [
            Text("f(x)"),
            Text(""),
            for(int j = 0; j < solution.targetEquation.length; j++)
              Text(solution.targetEquation[j].toStringAsFixed(2))
          ]
        ),
        TableRow(
          children: [
            Text("delta"),
            Text((solution.result ?? double.nan).toStringAsFixed(2)),
            for(int j = 0; j < solution.coefs!.length; j++)
              Text(solution.coefs![j].toStringAsFixed(2))
          ]
        )
      ],
    );
  }
}