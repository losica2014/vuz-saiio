import 'dart:math';

import 'package:saiio_lab/lab1/state.dart';

import 'model.dart';

List<List<double?>> solve(TransportProblem problem) {
  problem = problem.makeBalanced();

  List<List<double?>> coefs = List.generate(problem.supply.length, (e) => List.generate(problem.demand.length, (e) => null));

  // Начальное решение
  List<double?> supplyLeft = List<double?>.from(problem.supply);
  List<double?> demandLeft = List<double?>.from(problem.demand);
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
  Set<Coord> used = {};

  while(supplyLeft.any((e) => e != null && e > 0) || demandLeft.any((e) => e != null && e > 0)) {
    Coord? minPrice = _chooseMinPrice(problem, used);
    if(minPrice == null) break;
    /* if(supplyLeft[minPrice.$1] == null || demandLeft[minPrice.$2] == null) {
      
    } else  */if(supplyLeft[minPrice.$1] != null && demandLeft[minPrice.$2] != null) {
      double coef = min(supplyLeft[minPrice.$1]!, demandLeft[minPrice.$2]!);
      coefs[minPrice.$1][minPrice.$2] = coef;
      supplyLeft[minPrice.$1] = supplyLeft[minPrice.$1]! - coef;
      demandLeft[minPrice.$2] = demandLeft[minPrice.$2]! - coef;
      if(supplyLeft[minPrice.$1] == 0) supplyLeft[minPrice.$1] = null;
      if(demandLeft[minPrice.$2] == 0) demandLeft[minPrice.$2] = null;
    }
    used.add(minPrice);
  }

  // Нахождение оптимального решения
  bool continueRunning = true;
  do {
    // int coefsCount = coefs.fold(0, (e, el) => e + el.fold(0, (ee, ele) => ee + (ele == null ? 0 : 1)));
    // int coefsCountTarget = problem.supply.length + problem.demand.length - 1;
    // if(coefsCount < coefsCountTarget) {
    //   for(int i = 0; i < coefsCountTarget - coefsCount; i++) {
    //     bool done = false;
    //     for(int x = 0; x < problem.supply.length; x++) {
    //       for(int y = 0; y < problem.demand.length; y++) {
    //         if(coefs[x][y] == null) {
    //           coefs[x][y] = 0;
    //           done = true;
    //           break;
    //         }
    //       }
    //       if(done) break;
    //     }
    //     if(!done) throw Exception("Недостаточно коэффициентов");
    //   }
    // }

    List<double?> u = List.filled(problem.supply.length, null);
    List<double?> v = List.filled(problem.demand.length, null);

    u[0] = 0;

    while(u.any((e) => e == null) || v.any((e) => e == null)) {
      for(int i = 0; i < problem.supply.length; i++) {
        for(int j = 0; j < problem.demand.length; j++) {
          if(u[i] != null && v[j] == null) {
            v[j] = problem.prices[i][j] - u[i]!;
          }
          else if(v[j] != null && u[i] == null) {
            u[i] = problem.prices[i][j] - v[j]!;
          } else if(u[i] != null && v[j] != null) {
            if(u[i]! + v[j]! != problem.prices[i][j]) {
              // throw Exception("Неравенство в u+v=c");
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
        if(coefs[i][j] == null) {
          delta = problem.prices[i][j] - u[i]! - v[j]!;
        }
        deltas[i].add(delta);
        if(delta < minDelta) {
          minDelta = delta;
          minDeltaCoord = (i, j);
        }
      }
    }
    double totalCost = getTotalCost(coefs, problem.prices);
    String s = "\n";
    for(int i = 0; i < problem.supply.length; i++) {
        // print(coefs[i].map((e) => e ?? '--').join('\t') + "\t${u[i]}");
      s += "A$i\t";
      for(int j = 0; j < problem.demand.length; j++) {
        s += "${coefs[i][j] ?? '--'} (${deltas[i][j]})\t";
      }
      s += "${u[i]}\n";
    }
    s += v.join('\t');
    print(s);
    print("Total cost: $totalCost");

    print("Min delta: $minDelta $minDeltaCoord");
    print('='*20);

    continueRunning = minDelta < 0;

    if(!continueRunning) break;

    List<Coord>? path = getPath(coefs, [minDeltaCoord]);

    if(path == null) throw Exception("Путь пуст");

    double minVal = double.infinity;
    for(var (i, c) in path.sublist(1, path.length - 1).indexed) {
      if((i - 1) % 2 == 1) minVal = min(coefs[c.$1][c.$2]!, minVal);
    }

    if(minVal == double.infinity) throw Exception('minVal == infinity');

    for(var (i, c) in path.sublist(0, path.length - 1).indexed) {
      if(i % 2 == 1) {
        coefs[c.$1][c.$2] = (coefs[c.$1][c.$2] ?? 0) - minVal;
        if(coefs[c.$1][c.$2]! < 0) throw Exception('Negative amount');
        if(coefs[c.$1][c.$2] == 0) coefs[c.$1][c.$2] = null;
      } else {
        coefs[c.$1][c.$2] = (coefs[c.$1][c.$2] ?? 0) + minVal;
      }
    }

  } while(continueRunning);

  return coefs;
}

Coord? _chooseMinPrice(TransportProblem problem, Set<Coord> used) {
  Coord minPrice = (-1, -1);
  for(int x = 0; x < problem.supply.length; x++) {
    for(int y = 0; y < problem.demand.length; y++) {
      double price = problem.prices[x][y];
      if(!used.contains((x, y)) && ((minPrice.$1 == -1) || price < problem.prices[minPrice.$1][minPrice.$2])) {
        minPrice = (x, y);
      }
    }
  }
  // used.add(minPrice);
  if(minPrice.$1 == -1) return null;
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

List<Coord>? getPath(List<List<double?>> coefs, List<Coord> path) {
  if(path.last == path.first && path.length > 1) {
    return path;
  }
  // if(path.length > coefs.length + coefs.first.length) return null;
  

  // get possible steps
  Coord last = path.last;
  bool anyDirection = path.length == 1;
  bool vertical = anyDirection || path[path.length-1].$2 != path[path.length-2].$2; // Последнее перемещение - горизонтальное
  bool horizontal = anyDirection || path[path.length-1].$1 != path[path.length-2].$1; // Последнее перемещение - вертикальное
  if(vertical) {
    for(int i = 0; i < coefs.length; i++) {
      if(i == last.$1) continue;
      if(coefs[i][last.$2] == null && (i, last.$2) != path.first) {
        // print("[${path.length+1}] ($i, ${last.$2}) Coef is null");
        continue;
      }
      if(path.contains((i, last.$2)) && (i, last.$2) != path.first) {
        // print("[${path.length+1}] ($i, ${last.$2}) Already in path");
        continue;
      }
      List<Coord>? newPath = getPath(coefs, [...path, (i, last.$2)]);
      if(newPath != null) return newPath;
    }
  }
  if(horizontal) {
    for(int i = 0; i < coefs.first.length; i++) {
      if(i == last.$2) continue;
      if(coefs[last.$1][i] == null && (last.$1, i) != path.first) continue;
      if(path.contains((last.$1, i)) && (last.$1, i) != path.first) continue;
      List<Coord>? newPath = getPath(coefs, [...path, (last.$1, i)]);
      if(newPath != null) return newPath;
    }
  }
  return null;
  // get path with them
  // return first non-null
  // else return null
}