import 'package:flutter/material.dart';
import 'package:saiio_lab/lab5/simplex_table.dart';
import 'package:saiio_lab/lab5/solver.dart';

import 'lpp_model.dart';
import 'painter.dart';

class LPPPage extends StatefulWidget {
  const LPPPage({super.key});

  @override
  _LPPPageState createState() => _LPPPageState();
}

class _LPPPageState extends State<LPPPage> {
  double result = 0;
  double target = 0;
  List<double> coefs = [];
  double scale = 5;
  int selectedModel = 0;
  late LPPSimplexSolution solution;

  @override
  void initState() {
    changeModel(selectedModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LPPModel model = LPPModels.models[selectedModel];
    return Scaffold(
      appBar: AppBar(
        title: Text("Лабораторная работа 4 / 5"),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) => CustomPaint(
                  size: constraints.biggest,
                  isComplex: true,
                  painter: LPPPainter(
                    model: model.copyWith(targetValue: target),
                    scale: scale
                  ),
                )
            ),
          ),
          Flexible(child: Column(
            children: [
              Text("Цель: найти ${model.targetMax ? "максимум" : "минимум"} функции"),
              Text("Функция: f(x1, x2) = ${model.targetEquation[0].toStringAsFixed(1)} * x1 + ${model.targetEquation[1].toStringAsFixed(1)} * x2"),
              Text("Решение: f = ${result.toStringAsFixed(2)} (${coefs.isEmpty || solution.result == null ? "нет решения" : "x1 = ${coefs[0].toStringAsFixed(2)}, x2 = ${coefs[1].toStringAsFixed(2)}"})"),
              Text("Значение функции: ${target.toStringAsFixed(2)}"),
              Slider(value: target, min: 0, max: 100, onChanged: (value) => setState(() => target = value)),
              Text("Масштаб: ${scale.toStringAsFixed(1)}"),
              Slider(value: scale, min: 1, max: 10, onChanged: (value) => setState(() => scale = value)),
              DropdownMenu(
                dropdownMenuEntries: List.generate(LPPModels.models.length, (index) => DropdownMenuEntry(value: index, label: "Модель ${index + 1}")),
                initialSelection: selectedModel,
                onSelected: (value) => (value != null) ? changeModel(value) : null
              ),
              SimplexTable(solution: solution)
            ],
          ))
        ],
      ),
    );
  }

  void changeModel(int value) => setState(() {
    selectedModel = value;
    LPPModel model = LPPModels.models[selectedModel];
    solution = model.solve();
    result = solution.result ?? 0;
    coefs = solution.coefs ?? [];
    if(!solution.success) coefs = [];
    target = result;
  });
}