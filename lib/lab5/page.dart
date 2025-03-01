import 'package:flutter/material.dart';
import 'package:saiio_lab/lab4/lpp_model.dart';
import 'package:saiio_lab/lab5/solver.dart';

class LPPPageMMethod extends StatefulWidget {
  const LPPPageMMethod({super.key});

  @override
  State<LPPPageMMethod> createState() => _LPPPageMMethodState();
}

class _LPPPageMMethodState extends State<LPPPageMMethod> {
  double value = 0;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Лабораторная работа 5"),
      ),
      body: Center(
        child: Text(value.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _calculate,
      ),
    );
  }

  void _calculate() {
    setState(() {
      value = LPPModels.models[0].solve();
    });
  }
}