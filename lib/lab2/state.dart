import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

final initialState = PumpStationState(
  clock: 0,
  reservoir: 1000,
  reservoirSize: 1000,
  valveSpeed: 0,
  pumps: Map.fromEntries(List.generate(3, (i) => MapEntry(i + 1, PumpState(
    mode: PumpMode.idle,
    operatingTime: 0
  ))))
);

class PumpStation extends Cubit<PumpStationState> {
  Timer? _timer;

  PumpStation() : super(initialState) {
    startSimulation();
  }

  void stepState() {
    if(isClosed) {
      stopSimulation();
      return;
    }

    int newReservoir = state.reservoir - state.valveSpeed + state.pumps.values.fold(0, (prev, pump) => prev + (pump.mode == PumpMode.running ? 2 : 0));
    if(newReservoir > state.reservoirSize) newReservoir = state.reservoirSize;
    if(newReservoir < 0) newReservoir = 0;

    PumpStationState newState = state.copyWith(reservoir: newReservoir);
    
    if(state.reservoirPercentage < 0.25 && state.pumpsRunning < 2 || state.reservoirPercentage < 0.5 && state.pumpsRunning < 1) {
      int? pumpToRun = _choosePumpToRun();
      if(pumpToRun != null) {
        newState = newState.copyWith(pumps: {
          ...newState.pumps,
          pumpToRun: newState.pumps[pumpToRun]!.copyWith(mode: PumpMode.running)
        });
      }
    } else if(state.reservoirPercentage == 1 && state.pumpsRunning >= 1) {
      int? pumpToStop = _choosePumpToStop();
      if(pumpToStop != null) {
        newState = newState.copyWith(pumps: {
          ...newState.pumps,
          pumpToStop: newState.pumps[pumpToStop]!.copyWith(mode: PumpMode.idle)
        });
      }
    }

    newState = newState.copyWith(
      clock: state.clock + 1,
      pumps: newState.pumps.map(
        (key, value) => MapEntry(
          key,
          value.copyWith(operatingTime: value.operatingTime + (value.mode == PumpMode.running ? 1 : 0))
        )
      )
    );

    emit(newState);
  }

  int? _choosePumpToRun() {
    int? selected;
    for(final pump in state.pumps.entries) {
      if(pump.value.mode == PumpMode.faulty || pump.value.mode == PumpMode.running) continue;
      if(selected == null || pump.value.operatingTime < state.pumps[selected]!.operatingTime) selected = pump.key;
    }
    return selected;
  }

  int? _choosePumpToStop() {
    int? selected;
    for(final pump in state.pumps.entries) {
      if(pump.value.mode == PumpMode.faulty || pump.value.mode == PumpMode.idle) continue;
      if(selected == null || pump.value.operatingTime > state.pumps[selected]!.operatingTime) selected = pump.key;
    }
    return selected;
  }

  void setValveSpeed(int speed) {
    emit(state.copyWith(valveSpeed: speed));
  }

  void makePumpFaulty(int pump) {
    emit(state.copyWith(pumps: {
      ...state.pumps,
      pump: state.pumps[pump]!.copyWith(mode: PumpMode.faulty)
    }));
  }

  void makePumpHealthy(int pump) {
    emit(state.copyWith(pumps: {
      ...state.pumps,
      pump: state.pumps[pump]!.copyWith(mode: PumpMode.idle)
    }));
  }

  void startSimulation() {
    _timer = Timer.periodic(Duration(milliseconds: 20), (_) => stepState());
  }

  void stopSimulation() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    stopSimulation();
    return super.close();
  }
}

@freezed
class PumpStationState with _$PumpStationState {
  const factory PumpStationState({
    required int clock,
    required int reservoir,
    required int reservoirSize,
    required Map<int, PumpState> pumps,
    required int valveSpeed
  }) = _PumpStationState;

  const PumpStationState._();

  int get pumpsRunning => pumps.values.where((pump) => pump.mode == PumpMode.running).length;
  double get reservoirPercentage => reservoir / reservoirSize;
}

@freezed
class PumpState with _$PumpState {
  const factory PumpState({
    @Default(PumpMode.idle) PumpMode mode,
    @Default(0) int operatingTime
  }) = _PumpState;
}

enum PumpMode {
  idle,
  faulty,
  running
}