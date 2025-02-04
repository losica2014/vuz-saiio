import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/rendering/viewport_offset.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import 'state.dart';

class HabitatPage extends StatefulWidget {
  const HabitatPage({super.key});

  @override
  State<HabitatPage> createState() => _HabitatPageState();
}

class _HabitatPageState extends State<HabitatPage> {
  late final Habitat habitat;
  double side = 20;
  int numberOfRabbits = 50;
  int numberOfWolvesM = 15;
  int numberOfWolvesF = 15;
  int wolfLifetime = 15;
  int habitatWidth = 30;
  int habitatHeight = 15;

  final TextEditingController numberOfRabbitsController = TextEditingController();
  final TextEditingController numberOfWolvesMController = TextEditingController();
  final TextEditingController numberOfWolvesFController = TextEditingController();
  final TextEditingController wolfLifetimeController = TextEditingController();
  final TextEditingController habitatWidthController = TextEditingController();
  final TextEditingController habitatHeightController = TextEditingController();

  @override
  void initState() {
    habitat = Habitat();

    numberOfRabbitsController.text = numberOfRabbits.toString();
    numberOfWolvesMController.text = numberOfWolvesM.toString();
    numberOfWolvesFController.text = numberOfWolvesF.toString();
    wolfLifetimeController.text = wolfLifetime.toString();
    habitatWidthController.text = habitatWidth.toString();
    habitatHeightController.text = habitatHeight.toString();
    super.initState();
  }

  @override
  void dispose() {
    habitat.close();
    numberOfRabbitsController.dispose();
    numberOfWolvesMController.dispose();
    numberOfWolvesFController.dispose();
    wolfLifetimeController.dispose();
    habitatWidthController.dispose();
    habitatHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: habitat,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Лабораторная работа 1"),
        ),
        body: Row(
          children: [
            Expanded(
              child: BlocBuilder<Habitat, HabitatState>(
                builder: (context, state) {
                  return Center(
                    child: TableView(
                      delegate: TableCellBuilderDelegate(
                        rowCount: state.height,
                        columnCount: state.width,
                        cellBuilder: (context, vicinity) => _buildCell(context, state.cells[vicinity.xIndex][vicinity.yIndex]),
                        columnBuilder: (index) => TableSpan(
                          extent: FixedSpanExtent(side),
                        ),
                        rowBuilder: (index) => TableSpan(
                          extent: FixedSpanExtent(side),
                        )
                      ),
                    ),
                  );
                }
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text("Масштаб поля"),
                          Spacer(),
                          Text("${side.toInt()}"),
                          IconButton.filledTonal(
                            onPressed: () => setState(() => side = min(side + 5, 50)),
                            icon: Icon(Symbols.zoom_in),
                          ),
                          IconButton.filledTonal(
                            onPressed: () => setState(() => side = max(side - 5, 5)),
                            icon: Icon(Symbols.zoom_out),
                          ),
                        ],
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Количество кроликов"
                        ),
                        controller: numberOfRabbitsController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => setState(() => numberOfRabbits = int.parse(value)),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Количество волков"
                        ),
                        controller: numberOfWolvesMController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => setState(() => numberOfWolvesM = int.parse(value)),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Количество волчиц"
                        ),
                        controller: numberOfWolvesFController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => setState(() => numberOfWolvesF = int.parse(value)),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Время жизни волка"
                        ),
                        controller: wolfLifetimeController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => setState(() => wolfLifetime = int.parse(value)),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Ширина поля"
                        ),
                        controller: habitatWidthController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => setState(() => habitatWidth = int.parse(value)),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Высота поля"
                        ),
                        controller: habitatHeightController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) => setState(() => habitatHeight = int.parse(value)),
                      ),
                      FilledButton(
                        onPressed: () => habitat.generateState(
                          numberOfRabbits: numberOfRabbits,
                          numberOfWolvesM: numberOfWolvesM,
                          numberOfWolvesF: numberOfWolvesF,
                          wolfLifetime: wolfLifetime,
                          habitatWidth: habitatWidth,
                          habitatHeight: habitatHeight
                        ),
                        child: Text("Сгенерировать состояние"),
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () => habitat.stepState(),
                              child: Text("Шаг"),
                            ),
                          ),
                          IconButton.filled(
                            onPressed: () => habitat.startSimulation(),
                            icon: Icon(Symbols.play_arrow),
                          ),
                          IconButton.filled(
                            onPressed: () => habitat.stopSimulation(),
                            icon: Icon(Symbols.pause),
                          ),
                        ]
                      ),
                      BlocBuilder<Habitat, HabitatState>(
                        buildWhen: (previous, current) => previous.logs != current.logs,
                        builder: (context, state) {
                          return SfCartesianChart(
                            series: [
                              LineSeries<LogEntry, dynamic>(
                                dataSource: state.logs,
                                color: Colors.green,
                                name: "Кролики",
                                xValueMapper: (e, _) => e.step,
                                yValueMapper: (e, _) => e.rabbits
                              ),
                              LineSeries<LogEntry, dynamic>(
                                dataSource: state.logs,
                                color: Colors.red,
                                name: "Волки",
                                xValueMapper: (e, _) => e.step,
                                yValueMapper: (e, _) => e.wolves
                              )
                            ],
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, Cell cell) {
    return TableViewCell(
      child: Container(
        color: switch(cell) {
          EmptyCell _ => Colors.grey.shade300,
          Rabbit _ => Colors.green,
          Wolf w => w.gender == Gender.male ? Colors.red : Colors.pink,
          _ => Colors.black
        },
        alignment: Alignment.center,
        child: (cell is Wolf) ? Text(cell.hunger.toString(), style: TextStyle(color: Colors.white)) : null,
      ),
    );
  }
}