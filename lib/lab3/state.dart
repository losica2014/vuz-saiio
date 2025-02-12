import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

final initialState = ElevatorState(
  mode: ElevatorMode.idle,
  pos: 1,
  floors: 10,
  callsUp: SplayTreeSet(),
  callsDown: SplayTreeSet(),
  requestedStops: SplayTreeSet(),
  doorsPos: 0
);

class Elevator extends Cubit<ElevatorState> {
  Timer? _timer;

  Elevator() : super(initialState);

  void stepState() {
    if(isClosed) {
      stopSimulation();
      return;
    }

    switch(state.mode) {
      case ElevatorMode.idle:
        if(!state.hasAnyTasksInDirection) break;
        print("Переход в режим движения до ближайшего вызова (${state.nearestStopInDirection})");
        emit(state.copyWith(mode: ElevatorMode.travelling, direction: (state.nearestStopInDirection ?? state.nearestStartCall)! > state.pos ? Direction.up : Direction.down));
        break;
      
      case ElevatorMode.travelling:
        int reversingFloor = switch(state.direction) {
          Direction.up => state.callsDown.lastOrNull ?? state.pos.ceil(),
          Direction.down => state.callsUp.firstOrNull ?? state.pos.floor(),
          _ => state.pos.round()
        };

        if(state.isOnFloor && (state.stopsInDirection.contains(state.currentFloor) || state.stopsInDirection.isEmpty && state.nearestStartCall == state.currentFloor)) {
          print("Прибыл на этаж ${state.currentFloor}, открываем двери");
          emit(state.copyWith(
            pos: state.currentFloor.toDouble(),
            mode: ElevatorMode.openingDoors,
            requestedStops: SplayTreeSet.from(state.requestedStops.difference({state.currentFloor})),
            callsUp: state.direction == Direction.up || state.currentFloor == reversingFloor ? SplayTreeSet.from(state.callsUp.difference({state.currentFloor})) : state.callsUp,
            callsDown: state.direction == Direction.down || state.currentFloor == reversingFloor ? SplayTreeSet.from(state.callsDown.difference({state.currentFloor})) : state.callsDown
          ));
        } else if(state.isOnFloor && !state.hasAnyTasksInDirection && state.currentFloor == reversingFloor) {
          print("Прибыл на этаж ${state.currentFloor}, ждём");
          emit(state.copyWith(mode: ElevatorMode.idle, direction: null));
        } else {
          emit(state.copyWith(pos: state.pos + (state.direction == Direction.up ? 0.1 : -0.1)));
        }
        break;
      
      case ElevatorMode.openingDoors:
        if(state.areDoorsOpened) {
          print("Двери открыты, ждём");
          emit(state.copyWith(mode: ElevatorMode.waiting, doorsPos: 1));
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
          emit(state.copyWith(mode: ElevatorMode.idle, direction: null, doorsPos: 0));
        } else if(state.areDoorsClosed) {
          print("Двери закрыты, продолжаем движение");
          emit(state.copyWith(mode: ElevatorMode.travelling, doorsPos: 0));
        } else {
          emit(state.copyWith(doorsPos: state.doorsPos - 0.1));
        }
        break;
    }
  }

  void startSimulation() {
    _timer = Timer.periodic(Duration(milliseconds: 40), (_) => stepState());
  }

  void stopSimulation() {
    _timer?.cancel();
  }

  void callUp(int floor) => emit(state.copyWith(callsUp: SplayTreeSet.from({...state.callsUp, floor})));
  void callDown(int floor) => emit(state.copyWith(callsDown: SplayTreeSet.from({...state.callsDown, floor})));
  void requestStop(int floor) => emit(state.copyWith(requestedStops: SplayTreeSet.from({...state.requestedStops, floor})));

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
    required SplayTreeSet<int> callsUp,
    required SplayTreeSet<int> callsDown,
    required SplayTreeSet<int> requestedStops,
    required double doorsPos,
    double? doorsTimer
  }) = _ElevatorState;

  const ElevatorState._();

  int get currentFloor => pos.round();
  bool get isOnFloor => (pos % 1).abs() < 0.01 || (pos % 1).abs() > 0.99;

  bool get areDoorsOpened => doorsPos >= 1;
  bool get areDoorsClosed => doorsPos <= 0;

  bool get hasAnyTasksInDirection => stopsInDirection.isNotEmpty;

  SplayTreeSet<int> get stopsUp => SplayTreeSet.from([...callsUp.where((floor) => floor >= currentFloor), ...requestedStops.where((floor) => floor >= currentFloor)]);
  SplayTreeSet<int> get stopsDown => SplayTreeSet.from([...callsDown.where((floor) => floor <= currentFloor), ...requestedStops.where((floor) => floor <= currentFloor)]);
  SplayTreeSet<int> get stopsAll => SplayTreeSet.from([...callsUp, ...callsDown, ...requestedStops]);
  SplayTreeSet<int> get stopsInDirection => switch(direction) {
    Direction.up => stopsUp,
    Direction.down => stopsDown,
    _ => stopsAll
  };

  int? get nearestStopRequest => stopsAll.fold(null, (min, stop) => (min == null || (stop - currentFloor).abs() < (min - currentFloor).abs()) ? stop : min);
  int? get nearestStartCall => (callsUp.isNotEmpty && callsDown.isNotEmpty) ? ((callsUp.first - currentFloor).abs() < (callsDown.last - currentFloor).abs() ? callsUp.firstOrNull : callsDown.lastOrNull) : callsUp.firstOrNull ?? callsDown.lastOrNull;

  int? get nearestStopInDirection => switch(direction) {
    Direction.up => stopsUp.firstOrNull,
    Direction.down => stopsDown.lastOrNull,
    _ => nearestStopRequest ?? nearestStartCall
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