import 'package:flutter/material.dart';

import 'model.dart';

class TPSolutionView extends StatelessWidget {
  const TPSolutionView(this.solution, {super.key});

  final TransportProblemSolution solution;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                Text(""),
                for(int i = 0; i < solution.problem.demand.length; i++)
                  Text("B${i+1}"),
                Text("Поставка")
              ].map((e) => TableCell(child: Padding(padding: EdgeInsets.all(8), child: e))).toList()
            ),
            for(int i = 0; i < solution.problem.supply.length; i++)
              TableRow(
                children: [
                  Text("A${i+1}"),
                  for(int j = 0; j < solution.problem.demand.length; j++)
                    Text(solution.coefs[i][j]?.toStringAsFixed(0) ?? "0"),
                  Text(solution.problem.supply[i].toStringAsFixed(0))
                ].map((e) => TableCell(child: Padding(padding: EdgeInsets.all(8), child: e))).toList()
              ),
            TableRow(
              children: [
                Text("Потребление"),
                for(int i = 0; i < solution.problem.demand.length; i++)
                  Text(solution.problem.demand[i].toStringAsFixed(0)),
                Text("")
              ].map((e) => TableCell(child: Padding(padding: EdgeInsets.all(8), child: e))).toList()
            )
          ],
        ),
        Text("Стоимость: ${solution.totalCost.toStringAsFixed(2)}"),
      ],
    );
  }
}