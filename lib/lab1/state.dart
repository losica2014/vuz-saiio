import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

class Habitat extends Cubit<HabitatState> {
  Timer? _timer;
  final _rand = Random(DateTime.now().millisecondsSinceEpoch);

  Habitat() : super(HabitatState.empty());

  void startSimulation() {
    _timer = Timer.periodic(Duration(milliseconds: 20), (_) => (state.overpopulation || state.rabbits == 0 && state.wolves == 0) ? stopSimulation() : stepState());
  }

  void stopSimulation() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    stopSimulation();
    return super.close();
  }

  void generateState({required int numberOfRabbits, required int numberOfWolvesM, required int numberOfWolvesF, required int wolfLifetime, required int habitatWidth, required int habitatHeight}) {
    List<List<Cell>> state = List.generate(habitatWidth, (_) => List.generate(habitatHeight, (_) => EmptyCell()));

    int chosenWidth, chosenHeight;

    try {
      for(int i = 0; i < numberOfRabbits; i++) {
        final cell = _getRandomFreeCell(state, habitatWidth, habitatHeight);
        (chosenWidth, chosenHeight) = cell;
        
        print("Добавлен кролик: $chosenWidth, $chosenHeight");
        state[chosenWidth][chosenHeight] = Rabbit();
      }

      for(int i = 0; i < numberOfWolvesM; i++) {
        final cell = _getRandomFreeCell(state, habitatWidth, habitatHeight);
        (chosenWidth, chosenHeight) = cell;
        
        print("Добавлен волк (М): $chosenWidth, $chosenHeight");
        state[chosenWidth][chosenHeight] = Wolf(gender: Gender.male);
      }

      for(int i = 0; i < numberOfWolvesF; i++) {
        final cell = _getRandomFreeCell(state, habitatWidth, habitatHeight);
        (chosenWidth, chosenHeight) = cell;

        print("Добавлен волк (Ж): $chosenWidth, $chosenHeight");
        state[chosenWidth][chosenHeight] = Wolf(gender: Gender.female);
      }
    } catch(e) {}

    emit(HabitatState(cells: state, width: habitatWidth, height: habitatHeight, numberOfRabbits: numberOfRabbits, numberOfWolvesM: numberOfWolvesM, numberOfWolvesF: numberOfWolvesF, wolfLifetime: wolfLifetime));
  }

  void stepState() {
    List<List<Cell>> newState = List.generate(state.width, (x) => List.generate(state.height, (y) => state.cells[x][y]));

    List<Coord> processedCoords = [];

    bool overpopulation = false;

    try {
      for(int i = 0; i < state.width; i++) {
        for(int j = 0; j < state.height; j++) {
          final cell = state.cells[i][j];
          if(processedCoords.contains((i, j))) continue;
          processedCoords.add((i, j));

          if(cell is Rabbit) {
            List<Coord> surroundingCells = _getSurroundingCells<EmptyCell>(newState, state.width, state.height, i, j);

            if(surroundingCells.isEmpty) {
              continue;
            }

            if(_rand.nextDouble() < 0.1) {
              final selectedCell = surroundingCells[_rand.nextInt(surroundingCells.length)];
              final (x, y) = selectedCell;
              newState[x][y] = Rabbit();
              processedCoords.add((x, y));
              continue;
            }

            if(surroundingCells.isNotEmpty) {
              final selectedCell = surroundingCells[_rand.nextInt(surroundingCells.length)];
              final (x, y) = selectedCell;
              newState[x][y] = Rabbit();
              newState[i][j] = EmptyCell();
              processedCoords.add((x, y));
              continue;
            }
          }

          if(cell is Wolf) {
            List<Coord> food = _getSurroundingCells<Rabbit>(newState, state.width, state.height, i, j);

            if(cell.hunger == state.wolfLifetime) {
              newState[i][j] = EmptyCell();
              continue;
            }
            
            if(food.isNotEmpty && cell.hunger >= state.wolfLifetime / 2) {
              final selectedCell = food[_rand.nextInt(food.length)];
              final (x, y) = selectedCell;
              newState[x][y] = cell.copyWith(hunger: 0);
              newState[i][j] = EmptyCell();
              processedCoords.add((x, y));
              continue;
            }
            
            List<Coord> mates = _getSurroundingCells<Wolf>(newState, state.width, state.height, i, j, (w) => w.gender == Gender.female);
            List<Coord> free = _getSurroundingCells<EmptyCell>(newState, state.width, state.height, i, j);

            if(cell.gender == Gender.male && mates.isNotEmpty && cell.hunger <= state.wolfLifetime / 4 && free.isNotEmpty) {
              final selectedCell = free[_rand.nextInt(free.length)];
              final (x, y) = selectedCell;
              newState[x][y] = cell.copyWith(gender: _rand.nextBool() ? Gender.male : Gender.female);
              newState[i][j] = cell.copyWith(hunger: cell.hunger + 1);
              processedCoords.add((x, y));
              continue;
            }

            if(free.isNotEmpty) {
              final selectedCell = free[_rand.nextInt(free.length)];
              final (x, y) = selectedCell;
              newState[x][y] = cell.copyWith(hunger: cell.hunger + 1);
              newState[i][j] = EmptyCell();
              processedCoords.add((x, y));
              continue;
            } else {
              newState[i][j] = cell.copyWith(hunger: cell.hunger + 1);
              continue;
            }
          }
        }
      }
    } catch(e) {
      print(e);
      overpopulation = true;
    }

    emit(state.copyWith(
      cells: newState,
      logs: [...state.logs, LogEntry(step: state.logs.length, rabbits: state.rabbits, wolves: state.wolves)],
      overpopulation: overpopulation
    ));
  }

  Coord _getRandomFreeCell(List<List<Cell>> state, int habitatWidth, int habitatHeight) {
    final size = habitatHeight * habitatWidth;
    int chosenIndex = _rand.nextInt(size - 1);

    for(int i = 0; i < size; i++) {
      if(state[chosenIndex % habitatWidth][chosenIndex ~/ habitatWidth] is EmptyCell) {
        return (chosenIndex % habitatWidth, chosenIndex ~/ habitatWidth);
      }
      chosenIndex = (chosenIndex + 1) % size;
    }

    print("Нет места. ${state[chosenIndex % habitatWidth][chosenIndex ~/ habitatWidth]} -  ${chosenIndex % habitatWidth}, ${chosenIndex ~/ habitatWidth}");
    throw Exception("Нет места");
  }
  List<Coord> _getSurroundingCells<T extends Cell>(List<List<Cell>> state, int habitatWidth, int habitatHeight, int x, int y, [bool Function(T)? test]) {
    List<Coord> cells = [];
    for(int i = -1; i <= 1; i++) {
      for(int j = -1; j <= 1; j++) {
        if(x + i < 0 || x + i >= habitatWidth || y + j < 0 || y + j >= habitatHeight) continue;
        if(state[x + i][y + j] is T && (test == null || test(state[x + i][y + j] as T))) cells.add((x + i, y + j));
      }
    }
    return cells;
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
    @Default([]) List<LogEntry> logs,
    @Default(false) bool overpopulation
  }) = _HabitatState;

  factory HabitatState.empty() => HabitatState(cells: [[EmptyCell()]], width: 1, height: 1, numberOfRabbits: 0, numberOfWolvesM: 0, numberOfWolvesF: 0, wolfLifetime: 0);

  const HabitatState._();

  int get rabbits => cells.expand((e) => e).whereType<Rabbit>().length;
  int get wolvesM => cells.expand((e) => e).whereType<Wolf>().where((e) => e.gender == Gender.male).length;
  int get wolvesF => cells.expand((e) => e).whereType<Wolf>().where((e) => e.gender == Gender.female).length;
  int get wolves => wolvesM + wolvesF;
}

class LogEntry {
  LogEntry({required this.step, required this.rabbits, required this.wolves});
  final int step;
  final int rabbits;
  final int wolves;
}

typedef Coord = (int x, int y);

abstract class Cell {}

class EmptyCell extends Cell {}

abstract class Animal extends Cell {}

@freezed
class Wolf extends Animal with _$Wolf {
  const factory Wolf({
    required Gender gender,
    @Default(0) int hunger,
    @Default(false) bool reproductionBlocked
  }) = _Wolf;
}

class Rabbit extends Animal {}

enum Gender { male, female }