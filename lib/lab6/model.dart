import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

class TransportProblems {
  static const TransportProblem problem = TransportProblem(
    prices: [
      [3, 5, 4],
      [2, 3, 1],
      [2, 3, 3],
      [4, 1, 2]
    ],
    supply: [150, 90, 170, 140],
    demand: [100, 50, 200]
  );
  static const TransportProblem demo = TransportProblem(
    prices: [
      [5, 7, 5, 1],
      [3, 5, 4, 2],
      [4, 5, 4, 3],
      [5, 2, 3, 4]
    ],
    supply: [40, 60, 60, 100],
    demand: [50, 100, 50, 50]
  );
  static const TransportProblem demo3 = TransportProblem(
    prices: [
      [3,2,4,6,7,5],
      [3,8,7,3,3,3],
      [2,8,5,4,4,5],
      [3,5,6,2,3,2],
      [3,2,4,6,2,6]
    ],
    supply: [100, 150, 50, 125, 25],
    demand: [15, 35, 100, 75, 125, 100]
  );
}

@freezed
class TransportProblem with _$TransportProblem {
  const factory TransportProblem({
    required List<List<double>> prices,
    required List<double> supply,
    required List<double> demand
  }) = _TransportProblem;

  const TransportProblem._();

  double get totalSupply => supply.fold(0.0, (a, b) => a + b);
  double get totalDemand => demand.fold(0.0, (a, b) => a + b);
  bool get isBalanced => totalSupply == totalDemand;

  TransportProblem makeBalanced() {
    if(totalSupply > totalDemand) {
      return copyWith(
        demand: [
          ...demand,
          totalSupply - totalDemand
        ],
        prices: [
          for(var i = 0; i < supply.length; i++)
            [...prices[i], 0.0]
        ]
      );
    } else if(totalDemand > totalSupply) {
      return copyWith(
        supply: [
          ...supply,
          totalDemand - totalSupply
        ],
        prices: [
          ...prices,
          List.filled(demand.length, 0.0)
        ]
      );
    } else {
      return this;
    }
  } 
}