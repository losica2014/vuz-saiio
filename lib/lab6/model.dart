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
          ...prices,
          List.filled(supply.length, 0.0)
        ]
      );
    } else if(totalDemand > totalSupply) {
      return copyWith(
        supply: [
          ...supply,
          totalDemand - totalSupply
        ],
        prices: [
          for(var i = 0; i < prices.length; i++)
            [...prices[i], 0.0]
        ]
      );
    } else {
      return this;
    }
  } 
}