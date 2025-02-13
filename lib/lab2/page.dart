import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
          builder: (context, state) => Center(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Symbols.timer),
                          Text("Циклов симуляции", style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      Text(state.clock.toString()),
                    ],
                  )
                ),
                for(final pumpId in state.pumps.keys) Pump(id: pumpId),
                Reservoir(),
                Valve(),
              ],
            ),
          )
        ),
      ),
    );
  }
}
