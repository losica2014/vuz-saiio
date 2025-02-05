import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:saiio_lab/lab3/shaft.dart';

import 'floor.dart';
import 'state.dart';

class BuildingPage extends StatefulWidget {
  const BuildingPage({super.key});

  @override
  State<BuildingPage> createState() => _BuildingPageState();
}

class _BuildingPageState extends State<BuildingPage> {
  late final Elevator elevator;

  @override
  void initState() {
    elevator = Elevator();
    super.initState();
  }

  @override
  void dispose() {
    elevator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: elevator,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Лабораторная работа 3"),
        ),
        body: BlocBuilder<Elevator, ElevatorState>(
          builder: (context, state) {
            return Row(
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          spacing: 20,
                          children: [
                            for(int i = elevator.state.floors; i >= 1; i--) Floor(floorNumber: i)
                          ],
                        ),
                        ElevatorShaft(
                          position: state.pos,
                          floors: state.floors
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: [
                      Text("В процессе разработки..."),
                      Text("Текущее положение: ${state.pos}"),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () => elevator.stepState(),
                              child: Text("Шаг"),
                            ),
                          ),
                          IconButton.filled(
                            onPressed: () => elevator.startSimulation(),
                            icon: Icon(Symbols.play_arrow),
                          ),
                          IconButton.filled(
                            onPressed: () => elevator.stopSimulation(),
                            icon: Icon(Symbols.pause),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
