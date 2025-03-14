import 'package:flutter/material.dart';
import 'package:saiio_lab/lab6/model.dart';
import 'package:saiio_lab/lab6/solver.dart';

class TPPage extends StatefulWidget {
  const TPPage({super.key});

  @override
  State<TPPage> createState() => _TPPageState();
}

class _TPPageState extends State<TPPage> {
  String solution = "";

  @override
  void initState() {
    solution = solve(TransportProblems.demo3).join('\n');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Лабораторная работа 6"),
      ),
      body: Column(
        children: [
          Text(solution)
        ],
      )
    );
  }
}