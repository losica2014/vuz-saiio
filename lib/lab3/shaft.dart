import 'package:flutter/material.dart';

import 'cabin.dart';

class ElevatorShaft extends StatelessWidget {
  const ElevatorShaft({super.key, required this.position, required this.floors});

  final double position;
  final int floors;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: (position - 1) * 120,
      right: 0,
      duration: const Duration(milliseconds: 40),
      child: ElevatorCabin()
    );
  }
}