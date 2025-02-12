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
          builder: (context, state) => Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.centerRight,
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
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text("Текущее состояние: ${state.mode}"),
                    Text("Текущее положение: ${state.pos}"),
                    Text("Направление движения: ${state.direction}"),
                    Text("Вызовы вверх: ${state.callsUp}"),
                    Text("Вызовы вниз: ${state.callsDown}"),
                    Text("Запланированные остановки: ${state.stopsInDirection}"),
                    Text("Запрошенные остановки: ${state.requestedStops}"),
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
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for(int i = 1; i <= elevator.state.floors; i++) FilledButton.tonal(
                          onPressed: () => elevator.requestStop(i),
                          child: Text("$i этаж"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
