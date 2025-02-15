import 'package:flutter/material.dart';

import 'painter.dart';

class LPPPage extends StatefulWidget {
  const LPPPage({Key? key}) : super(key: key);

  @override
  _LPPPageState createState() => _LPPPageState();
}

class _LPPPageState extends State<LPPPage> {
  double target = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Лабораторная работа 4"),
      ),
      body: Row(
        children: [
          CustomPaint(
            size: Size(1000, 1000),
            painter: LPPPainter(
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
              constraintValues: [8, 6, 3, 0, 0]
            ),
          ),
          Flexible(child: Column(
            children: [
              Text("В процессе разработки"),
              Text(target.toStringAsFixed(0)),
              Slider(value: target, min: 0, max: 100, onChanged: (value) => setState(() => target = value)),
            ],
          ))
        ],
      ),
    );
  }
}