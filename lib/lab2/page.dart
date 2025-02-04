import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pump.dart';
import 'reservoir.dart';
import 'state.dart';
import 'valve.dart';

class PumpStationPage extends StatefulWidget {
  const PumpStationPage({super.key});

  @override
  State<PumpStationPage> createState() => _PumpStationPageState();
}

class _PumpStationPageState extends State<PumpStationPage> {
  late final PumpStation pumpStation;

  @override
  void initState() {
    pumpStation = PumpStation();
    super.initState();
  }

  @override
  void dispose() {
    pumpStation.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: pumpStation,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Лабораторная работа 2"),
        ),
        body: BlocBuilder<PumpStation, PumpStationState>(
          builder: (context, state) {
            return Center(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  for(final pumpId in state.pumps.keys) Pump(id: pumpId),
                  Reservoir(),
                  Valve(),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
