import 'dart:math';

import 'package:saiio_lab/lab1/state.dart';

import 'model.dart';

List<List<double>> solve(TransportProblem problem) {
  List<List<double?>> coefs = List.generate(problem.supply.length, (e) => List.generate(problem.demand.length, (e) => null));

  problem = problem.makeBalanced();

  // Начальное решение
  List<double> supplyLeft = List<double>.from(problem.supply);
  List<double> demandLeft = List<double>.from(problem.demand);
  // for(int i = 0; i < problem.supply.length; i++) {
  //   coefs.add([]);
  //   double supplyLeft = problem.supply[i];
  //   for(int j = 0; j < problem.demand.length; j++) {
  //     // coefs[i].add(problem.supply[i] * problem.demand[j] / problem.totalSupply);
  //     coefs[i].add(min(supplyLeft, demandLeft[j]));
  //     supplyLeft -= coefs[i][j];
  //     demandLeft[j] -= coefs[i][j];
  //   }
  // }
  List<Coord> used = [];

  while(supplyLeft.any((e) => e > 0) || demandLeft.any((e) => e > 0)) {
    Coord minPrice = _chooseMinPrice(problem, used);
    double coef = min(supplyLeft[minPrice.$1], demandLeft[minPrice.$2]);
    coefs[minPrice.$1][minPrice.$2] = coef;
    supplyLeft[minPrice.$1] -= coef;
    demandLeft[minPrice.$2] -= coef;
    used.add(minPrice);
  }

  // Нахождение оптимального решения
  bool continueRunning = true;
  do {
    int coefsCount = coefs.fold(0, (e, el) => e + el.fold(0, (ee, ele) => ee + (ele == null ? 0 : 1)));
    int coefsCountTarget = problem.supply.length + problem.demand.length - 1;

    if(coefsCount < coefsCountTarget) {
      for(int i = 0; i < coefsCountTarget - coefsCount; i++) {
        coefs // TODO
      }
    }

    double totalCost = getTotalCost(coefs, problem.prices);
    List<double?> u = List.filled(problem.supply.length, null);
    List<double?> v = List.filled(problem.demand.length, null);

    // for(int i = 0; i < problem.supply.length; i++) {
    //   if(i == 0) {
    //     u.add(0);
    //   } else {    
    //   }
    // }

    u[0] = 0;

    while(u.any((e) => e == null) || v.any((e) => e == null)) {
      for(int i = 0; i < problem.supply.length; i++) {
        for(int j = 0; j < problem.demand.length; i++) {
          if(u[i] != null && v[j] == null) {
            v[j] = problem.prices[i][j] - u[i]!;
          }
          else if(v[j] != null && u[i] == null) {
            u[i] = problem.prices[i][j] - v[j]!;
          } else if(u[i] != null && v[j] != null) {
            if(u[i]! + v[j]! != problem.prices[i][j]) {
              throw Exception("Неравенство в u+v=c");
            }
          }
        }
      }
    }

    List<List<double>> deltas = [];
    double minDelta = double.maxFinite;
    Coord minDeltaCoord = (-1, -1);
    for(int i = 0; i < problem.supply.length; i++) {
      deltas.add([]);
      for(int j = 0; j < problem.demand.length; j++) {
        double delta = 0;
        if(coefs[i][j] == 0) {
          delta = problem.prices[i][j] - u[i]! - v[j]!;
        }
        deltas[i].add(delta);
        if(delta < minDelta) {
          minDelta = delta;
          minDeltaCoord = (i, j);
        }
      }
    }



    continueRunning = minDelta < 0;

  } while(continueRunning);

  return coefs;
}

Coord _chooseMinPrice(TransportProblem problem, List<Coord> used) {
  Coord minPrice = (0, 0);
  for(int x = 0; x < problem.supply.length; x++) {
    for(int y = 0; y < problem.demand.length; y++) {
      double price = problem.prices[x][y];
      if(!used.contains((x, y)) && price < problem.prices[minPrice.$1][minPrice.$2]) {
        minPrice = (x, y);
      }
    }
  }
  used.add(minPrice);
  return minPrice;
}

double getTotalCost(List<List<double?>> coefs, List<List<double>> prices) {
  double totalCost = 0;
  for(int i = 0; i < coefs.length; i++) {
    for(int j = 0; j < coefs[i].length; j++) {
      totalCost += (coefs[i][j] ?? 0) * prices[i][j];
    }
  }
  return totalCost;
}