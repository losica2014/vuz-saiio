import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'state.dart';

class Pump extends StatelessWidget {
  const Pump({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PumpStation, PumpStationState>(
      buildWhen: (previous, current) => previous.pumps[id] != current.pumps[id],
      builder: (context, state) {
        if(!state.pumps.containsKey(id)) {
          return const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.error),
          );
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 140,
          height: 200,
          decoration: BoxDecoration(
            color: switch(state.pumps[id]!.mode) {
              PumpMode.faulty => Colors.red.shade300,
              PumpMode.idle => Colors.grey.shade300,
              PumpMode.running => Colors.green,
            },
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(Symbols.water_pump),
                  Text("Насос $id", style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              Text("Наработка: ${state.pumps[id]!.operatingTime}", textAlign: TextAlign.center,),
              Switch(
                value: state.pumps[id]!.mode != PumpMode.faulty,
                // in: Colors.white,
                thumbIcon: WidgetStateProperty.fromMap({
                  ~WidgetState.selected: const Icon(Icons.power_off),
                  WidgetState.selected: const Icon(Icons.power)
                }),
                onChanged: (value) {
                  if(value) {
                    context.read<PumpStation>().makePumpHealthy(id);
                  } else {
                    context.read<PumpStation>().makePumpFaulty(id);
                  }
                },
              ),
            ],
          ),
        );
      }
    );
  }
}