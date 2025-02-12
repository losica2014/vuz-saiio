import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'state.dart';

class Valve extends StatelessWidget {
  const Valve({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PumpStation, PumpStationState>(
      buildWhen: (previous, current) => previous.valveSpeed != current.valveSpeed,
      builder: (context, state) => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: Color.lerp(Colors.grey.shade300, Colors.blue, state.valveSpeed / 4),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(Symbols.valve),
                Text("Клапан", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Text("Пропускная способность: ${(state.valveSpeed / 4 * 100).toInt()}%", textAlign: TextAlign.center,),
            Slider(
              min: 0,
              max: 4,
              value: state.valveSpeed.toDouble(),
              onChanged: (value) => context.read<PumpStation>().setValveSpeed(value.toInt()),
            ),
          ],
        ),
      )
    );
  }
}