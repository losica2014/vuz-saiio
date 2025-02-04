import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'state.dart';

class Reservoir extends StatelessWidget {
  const Reservoir({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PumpStation, PumpStationState>(
      buildWhen: (previous, current) => previous.reservoir != current.reservoir || previous.reservoirSize != current.reservoirSize,
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          // padding: EdgeInsets.all(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                top: (1 - state.reservoirPercentage) * 200,
                child: Container(
                  color: Colors.indigo.shade300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Icon(Symbols.water_full),
                        Text("Резервуар", style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    Text("Наполненность: ${(state.reservoirPercentage * 100).toInt()}%", textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}