import 'package:flutter/material.dart';
import 'package:saiio_lab/lab6/model.dart';
import 'package:saiio_lab/lab6/solution.dart';
import 'package:saiio_lab/lab6/solver.dart';

class TPPage extends StatefulWidget {
  const TPPage({super.key});

  @override
  State<TPPage> createState() => _TPPageState();
}

class _TPPageState extends State<TPPage> {
  TransportProblemSolution? solution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Лабораторная работа 6"),
      ),
      body: Column(
        spacing: 20,
        children: [
          DropdownMenu(
            onSelected: (value) => setState(() => solution = value != null ? solve(value) : null),
            initialSelection: TransportProblems.demo,
            dropdownMenuEntries: [
              DropdownMenuEntry(label: "Пример 1", value: TransportProblems.demo),
              DropdownMenuEntry(label: "Вариант", value: TransportProblems.problem),
              DropdownMenuEntry(label: "Пример 3", value: TransportProblems.demo3),
            ]
          ),
          solution != null ? TPSolutionView(solution!) : Text("Выберите проблему")
        ],
      )
    );
  }
}