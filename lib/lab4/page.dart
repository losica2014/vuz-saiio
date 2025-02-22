import 'package:flutter/material.dart';

import 'lpp_model.dart';
import 'painter.dart';

class LPPPage extends StatefulWidget {
  const LPPPage({Key? key}) : super(key: key);

  @override
  _LPPPageState createState() => _LPPPageState();
}

class _LPPPageState extends State<LPPPage> {
  double target = 0;
  double scale = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Лабораторная работа 4"),
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
                    model: LPPModel(
                      targetEquation: [7, 3],
                      targetValue: target,
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
                    scale: scale
                  ),
                )
            ),
          ),
          Flexible(child: Column(
            children: [
              Text("Значение функции: ${target.toStringAsFixed(1)}"),
              Slider(value: target, min: 0, max: 100, onChanged: (value) => setState(() => target = value)),
              Text("Масштаб: ${scale.toStringAsFixed(1)}"),
              Slider(value: scale, min: 1, max: 10, onChanged: (value) => setState(() => scale = value)),
            ],
          ))
        ],
      ),
    );
  }
}