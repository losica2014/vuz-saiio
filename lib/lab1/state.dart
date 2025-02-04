import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

class Habitat extends Cubit<HabitatState> {
  Timer? _timer;
  final _rand = Random(DateTime.now().millisecondsSinceEpoch);

  Habitat() : super(HabitatState.empty()) {
    // generateState(
    //   numberOfRabbits: 10,
    //   numberOfWolvesM: 10,
    //   numberOfWolvesF: 10,
    //   wolfLifetime: 10,
    //   habitatWidth: 10,
    //   habitatHeight: 10
    // );
  }

  void generateState({required int numberOfRabbits, required int numberOfWolvesM, required int numberOfWolvesF, required int wolfLifetime, required int habitatWidth, required int habitatHeight}) {
    List<List<Cell>> state = List.generate(habitatWidth, (_) => List.generate(habitatHeight, (_) => EmptyCell()));

    int chosenWidth, chosenHeight;
    try {
    for(int i = 0; i < numberOfRabbits; i++) {
      final cell = _getRandomFreeCell(state, habitatWidth, habitatHeight);
      if(cell == null) throw Exception("Нет места");
      (chosenWidth, chosenHeight) = cell;
      
      print("Добавлен кролик: $chosenWidth, $chosenHeight");
      state[chosenWidth][chosenHeight] = Rabbit();
    }

    for(int i = 0; i < numberOfWolvesM; i++) {
      final cell = _getRandomFreeCell(state, habitatWidth, habitatHeight);
      if(cell == null) throw Exception("Нет места");
      (chosenWidth, chosenHeight) = cell;
      
      print("Добавлен волк (М): $chosenWidth, $chosenHeight");
      state[chosenWidth][chosenHeight] = Wolf(gender: Gender.male);
    }

    for(int i = 0; i < numberOfWolvesF; i++) {
      final cell = _getRandomFreeCell(state, habitatWidth, habitatHeight);
      if(cell == null) throw Exception("Нет места");
      (chosenWidth, chosenHeight) = cell;

      print("Добавлен волк (Ж): $chosenWidth, $chosenHeight");
      state[chosenWidth][chosenHeight] = Wolf(gender: Gender.female);
    }
    } catch(e) {
      print(e);
    }

    emit(HabitatState(cells: state, width: habitatWidth, height: habitatHeight, numberOfRabbits: numberOfRabbits, numberOfWolvesM: numberOfWolvesM, numberOfWolvesF: numberOfWolvesF, wolfLifetime: wolfLifetime));
  }

  (int, int)? _getRandomFreeCell(List<List<Cell>> state, int habitatWidth, int habitatHeight) {
    final size = habitatHeight * habitatWidth;
    int chosenIndex = _rand.nextInt(size - 1);
    // final orig = chosenIndex;

    for(int i = 0; i < size; i++) {
      if(state[chosenIndex % habitatWidth][chosenIndex ~/ habitatWidth] is EmptyCell) {
        // print("${chosenIndex % habitatWidth}, ${chosenIndex ~/ habitatWidth}: $orig -> $chosenIndex");
        return (chosenIndex % habitatWidth, chosenIndex ~/ habitatWidth);
      }
      chosenIndex = (chosenIndex + 1) % size;
      // print("$i: $orig -> $chosenIndex");
    }

    // print("NF $orig -> $chosenIndex");
    return null;
  }
}

@freezed
class HabitatState with _$HabitatState {
  const factory HabitatState({
    required List<List<Cell>> cells,
    required int width,
    required int height,
    required int numberOfRabbits,
    required int numberOfWolvesM,
    required int numberOfWolvesF,
    required int wolfLifetime,
    @Default([]) List<LogEntry> logs
  }) = _HabitatState;

  factory HabitatState.empty() => HabitatState(cells: [[EmptyCell()]], width: 1, height: 1, numberOfRabbits: 0, numberOfWolvesM: 0, numberOfWolvesF: 0, wolfLifetime: 0);

  const HabitatState._();

  int get rabbits => cells.expand((e) => e).whereType<Rabbit>().length;
  int get wolvesM => cells.expand((e) => e).whereType<Wolf>().where((e) => e.gender == Gender.male).length;
  int get wolvesF => cells.expand((e) => e).whereType<Wolf>().where((e) => e.gender == Gender.female).length;
}

class LogEntry {
  LogEntry({required this.step, required this.rabbits, required this.wolves});
  final int step;
  final int rabbits;
  final int wolves;
}

abstract class Cell {}

class EmptyCell extends Cell {}

abstract class Animal extends Cell {}

@freezed
class Wolf extends Animal with _$Wolf {
  const factory Wolf({
    required Gender gender,
    @Default(0) int age,
    @Default(0) double hunger,
  }) = _Wolf;
}

class Rabbit extends Animal {}

enum Gender { male, female }