import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

final initialState = ElevatorState(
  mode: ElevatorMode.idle,
  pos: 1,
  floors: 10,
  callsUp: {},
  callsDown: {},
  requestedStops: {},
  doorsPos: 1
);

class Elevator extends Cubit<ElevatorState> {
  Timer? _timer;

  Elevator() : super(initialState) {
    // startSimulation();
  }

  void _tick() {
    if(isClosed) {
      stopSimulation();
      return;
    }
    switch(state.mode) {
      case ElevatorMode.idle:
        if(!state.hasAnyTasksInDirection) break;
        print("Переход в режим движения");
        emit(state.copyWith(mode: ElevatorMode.travelling, direction: state.nearestStopInDirection! > state.pos ? Direction.up : Direction.down));
        break;
      case ElevatorMode.travelling:
        int targetFloor;
        if(!state.hasAnyTasksInDirection) {
          // Продолжить движение до ближайшего этажа
          targetFloor = state.pos.ceil();
        } else {
          // Продолжить движение до ближайшего запрошенного этажа
          targetFloor = state.nearestStopInDirection!;
        }
        if(state.isOnFloor && (state.currentFloor - targetFloor).abs() < 0.1) {
          print("Прибыл на этаж $targetFloor, открываем двери");
          emit(state.copyWith(
            mode: ElevatorMode.openingDoors,
            requestedStops: state.requestedStops.difference({targetFloor}),
            callsUp: state.direction == Direction.up ? state.callsUp.difference({targetFloor}) : state.callsUp,
            callsDown: state.direction == Direction.down ? state.callsDown.difference({targetFloor}) : state.callsDown
          ));
        } else {
          emit(state.copyWith(pos: state.pos + (state.direction == Direction.up ? 0.1 : -0.1)));
        }
        break;
      case ElevatorMode.openingDoors:
        if(state.areDoorsOpened) {
          print("Двери открыты, ждём");
          emit(state.copyWith(mode: ElevatorMode.waiting));
        } else {
          emit(state.copyWith(doorsPos: state.doorsPos + 0.1));
        }
        break;
      case ElevatorMode.waiting:
        switch(state.doorsTimer) {
          case null:
            emit(state.copyWith(doorsTimer: 5));
            break;
          case <= 0:
            print("Двери закрываются");
            emit(state.copyWith(doorsTimer: null, mode: ElevatorMode.closingDoors));
            break;
          default:
            emit(state.copyWith(doorsTimer: state.doorsTimer! - 0.05));
            break;
        }
        break;
      case ElevatorMode.closingDoors:
        if(state.areDoorsClosed && !state.hasAnyTasksInDirection) {
          print("Двери закрыты. Вызовов нет, ждём");
          emit(state.copyWith(mode: ElevatorMode.idle, direction: null));
        } else if(state.areDoorsClosed) {
          print("Двери закрыты, продолжаем движение");
          emit(state.copyWith(mode: ElevatorMode.travelling));
        } else {
          emit(state.copyWith(doorsPos: state.doorsPos - 0.1));
        }
        break;
    }
  }

  void startSimulation() {
    _timer = Timer.periodic(Duration(milliseconds: 40), (_) => _tick());
  }

  void stepState() => _tick();

  void stopSimulation() {
    _timer?.cancel();
  }

  void callUp(int floor) => emit(state.copyWith(callsUp: {...state.callsUp, floor}));
  void callDown(int floor) => emit(state.copyWith(callsDown: {...state.callsDown, floor}));
  void requestStop(int floor) => emit(state.copyWith(requestedStops: {...state.requestedStops, floor}));

  @override
  Future<void> close() {
    stopSimulation();
    return super.close();
  }
}

@freezed
class ElevatorState with _$ElevatorState {
  const factory ElevatorState({
    required ElevatorMode mode,
    Direction? direction,
    required double pos,
    required int floors,
    required Set<int> callsUp,
    required Set<int> callsDown,
    required Set<int> requestedStops,
    required double doorsPos,
    double? doorsTimer
  }) = _ElevatorState;

  const ElevatorState._();

  int get currentFloor => pos.round();
  bool get isOnFloor => (pos % 1).abs() < 0.01 || (pos % 1).abs() > 0.99;

  bool get areDoorsOpened => doorsPos >= 1;
  bool get areDoorsClosed => doorsPos <= 0;
  bool get areDoorsMoving => !areDoorsOpened && !areDoorsClosed;

  // bool get hasAnyCalls => callsUp.isNotEmpty || callsDown.isNotEmpty;
  // bool get hasAnyTasks => hasAnyCalls || requestedStops.isNotEmpty;
  bool get hasAnyTasksInDirection => switch(direction) {
    Direction.up => stopsUp.isNotEmpty,
    Direction.down => stopsDown.isNotEmpty,
    _ => stopsUp.isNotEmpty || stopsDown.isNotEmpty
  };

  Set<int> get stopsDown => SplayTreeSet.from([...callsDown.where((floor) => floor <= pos), ...requestedStops.where((floor) => floor <= pos)]);
  Set<int> get stopsUp => SplayTreeSet.from([...callsUp.where((floor) => floor >= pos), ...requestedStops.where((floor) => floor >= pos)]);
  Set<int> get stopsInDirection => switch(direction) {
    Direction.up => stopsUp,
    Direction.down => stopsDown,
    _ => SplayTreeSet.from([...callsUp, ...callsDown, ...requestedStops])
  };

  int? get nearestStopInDirection => switch(direction) {
    Direction.up => stopsUp.firstOrNull,
    Direction.down => stopsDown.lastOrNull,
    _ => stopsInDirection.fold(null, (min, stop) => (min == null || (stop - pos).abs() < (min - pos).abs()) ? stop : min)
  };
}

enum ElevatorMode {
  idle,
  travelling,
  openingDoors,
  waiting,
  closingDoors
}

enum Direction {
  up, down
}