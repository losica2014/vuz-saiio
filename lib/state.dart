import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

class PumpStation extends Cubit<PumpStationState> {
  late final Timer _timer;
  // late final Random _rand;

  PumpStation() : super(PumpStationState(
    time: 0,
    reservoir: 1000,
    reservoirSize: 1000,
    valveSpeed: 0,
    pumps: Map.fromEntries(List.generate(3, (i) => MapEntry(i + 1, PumpState(
      mode: PumpMode.idle,
      operatingTime: 0
    ))))
  )) {
    // _rand = Random(DateTime.now().millisecondsSinceEpoch);
    _timer = Timer.periodic(Duration(milliseconds: 20), (_) => _tick());
  }

  void _tick() {
    int newReservoir = state.reservoir - state.valveSpeed + state.pumps.values.fold(0, (prev, pump) => prev + (pump.mode == PumpMode.running ? 1 : 0));
    if(newReservoir > state.reservoirSize) newReservoir = state.reservoirSize;

    PumpStationState newState = state.copyWith(reservoir: newReservoir);
    
    if(state.reservoir < 0.25 && state.pumpsRunning < 2 || state.reservoir < 0.5 && state.pumpsRunning < 1) {
      int? pumpToRun = _choosePumpToRun();
      if(pumpToRun != null) {
        newState = newState.copyWith(pumps: {
          ...newState.pumps,
          pumpToRun: newState.pumps[pumpToRun]!.copyWith(mode: PumpMode.running)
        });
      }
    } else if(state.reservoir >= 0.5 && state.pumpsRunning >= 2 || state.reservoir == 1 && state.pumpsRunning >= 1) {
      int? pumpToStop = _choosePumpToStop();
      if(pumpToStop != null) {
        newState = newState.copyWith(pumps: {
          ...newState.pumps,
          pumpToStop: newState.pumps[pumpToStop]!.copyWith(mode: PumpMode.idle)
        });
      }
    }

    // if(_rand.nextDouble() < 0.3) {
      
    // }

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

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}

@freezed
class PumpStationState with _$PumpStationState {
  const factory PumpStationState({
    // required PumpStationMode mode,
    required int reservoir,
    required int reservoirSize,
    required int time,
    required Map<int, PumpState> pumps,
    required int valveSpeed
  }) = _PumpStationState;

  const PumpStationState._();

  int get pumpsRunning => pumps.values.where((pump) => pump.mode == PumpMode.running).length;
}

// enum PumpStationMode {
//   idle,
//   pumping_slow,
//   pumping_fast,
//   pumping_max
// }

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