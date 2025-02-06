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
        print("Переход в режим движения до ближайшего вызова (${state.nearestStopInDirection})");
        emit(state.copyWith(mode: ElevatorMode.travelling, direction: state.nearestStopInDirection! > state.pos ? Direction.up : Direction.down));
        break;
      case ElevatorMode.travelling:
        int targetFloor;
        int? reversingFloor = switch(state.direction) {Direction.up => state.callsDown.last, Direction.down => state.callsUp.last, _ => null};
        if(!state.hasAnyTasksInDirection || state.direction == Direction.up && reversingFloor! < state.pos - 0.2 || state.direction == Direction.down && reversingFloor! > state.pos + 0.2) {
          // Продолжить движение до ближайшего этажа
          targetFloor = state.direction == Direction.up ? state.pos.ceil() : state.pos.floor();
        } else {
          // Продолжить движение до ближайшего запрошенного этажа
          targetFloor = state.nearestStopInDirection!;
        }
        if(state.isOnFloor && (state.currentFloor - targetFloor).abs() < 0.2) {
          print("Прибыл на этаж $targetFloor, открываем двери");
          bool isLastTask = state.stopsInDirection.difference({targetFloor, reversingFloor}).isEmpty;
          Direction? newDirection = isLastTask ? null : state.direction;
          emit(state.copyWith(
            pos: targetFloor.toDouble(),
            mode: ElevatorMode.openingDoors,
            requestedStops: state.requestedStops.difference({targetFloor}),
            callsUp: newDirection == Direction.up || newDirection == null ? state.callsUp.difference({targetFloor}) : state.callsUp,
            callsDown: newDirection == Direction.down ? state.callsDown.difference({targetFloor}) : state.callsDown
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

  // @override
  // void emit(ElevatorState state) {
  //   print(state);
  //   super.emit(state);
  // }

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
  bool get hasAnyTasksInDirection => stopsInDirection.isNotEmpty;

  Set<int> get stopsDown => SplayTreeSet.from([...callsDown.where((floor) => floor <= pos), ...requestedStops.where((floor) => floor <= pos), if(callsUp.isNotEmpty) callsUp.first]);
  Set<int> get stopsUp => SplayTreeSet.from([...callsUp.where((floor) => floor >= pos), ...requestedStops.where((floor) => floor >= pos), if(callsDown.isNotEmpty) callsDown.last]);
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