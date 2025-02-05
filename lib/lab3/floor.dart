import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'state.dart';

class Floor extends StatelessWidget {
  const Floor({super.key, required this.floorNumber});

  final int floorNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2)
        ),
      ),
      child: Row(
        children: [
          Text("$floorNumber", style: TextStyle(fontSize: 48),),
          Column(
            children: [
              IconButton(
                icon: Icon(Symbols.arrow_upward),
                onPressed: () => context.read<Elevator>().callUp(floorNumber),
              ),
              IconButton(
                icon: Icon(Symbols.arrow_downward),
                onPressed: () => context.read<Elevator>().callDown(floorNumber),
              ),
            ],
          )
        ],
      ),
    );
  }
}