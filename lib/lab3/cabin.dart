import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class ElevatorCabin extends StatelessWidget {
  const ElevatorCabin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Elevator, ElevatorState>(
      builder: (context, state) => Container(
        height: 80,
        width: 60,
        color: Colors.grey,
        alignment: Alignment.center,
        child: Container(
          color: Colors.white,
          height: 70,
          width: 50 * state.doorsPos.abs()
        )
      )
    );
  }
}
