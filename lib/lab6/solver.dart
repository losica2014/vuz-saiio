import 'dart:math';

import 'package:saiio_lab/lab1/state.dart';

import 'model.dart';

TransportProblemSolution solve(TransportProblem problem) {
  problem = problem.makeBalanced();

  List<List<double?>> coefs = List.generate(problem.supply.length, (e) => List.generate(problem.demand.length, (e) => null));

  // Начальное решение
  List<double?> supplyLeft = List<double?>.from(problem.supply);
  List<double?> demandLeft = List<double?>.from(problem.demand);
  Set<Coord> used = {};

  int iter3 = 0;
  int maxIter3 = 100;

  while(used.length < problem.supply.length * problem.demand.length && iter3 < maxIter3) {
    iter3++;
    List<Coord>? minPrices = _chooseMinPrice(problem, used);
    if(minPrices == null) throw Exception("No min price found");
    print("Min prices: ${minPrices.map((e) => "(${e.$1}, ${e.$2})").join(", ")}");
    for(var minPrice in minPrices) {
      if(supplyLeft[minPrice.$1] != null && demandLeft[minPrice.$2] != null) {
        double coef = min(supplyLeft[minPrice.$1]!, demandLeft[minPrice.$2]!);
        coefs[minPrice.$1][minPrice.$2] = coef;
        supplyLeft[minPrice.$1] = supplyLeft[minPrice.$1]! - coef;
        demandLeft[minPrice.$2] = demandLeft[minPrice.$2]! - coef;
        print("Populated (${minPrice.$1}, ${minPrice.$2}) with $coef");
        if(supplyLeft[minPrice.$1] == 0) {
          supplyLeft[minPrice.$1] = null;
          print("Drained supply ${minPrice.$1}");
        }
        if(demandLeft[minPrice.$2] == 0) {
          print("Drained demand ${minPrice.$2}");
            demandLeft[minPrice.$2] = null;
        }
        used.add(minPrice);
        break;
      } else {
        print("Skipped (${minPrice.$1}, ${minPrice.$2})");
        used.add(minPrice);
      }
    }
    print("Remaining unused coords: ${problem.supply.length * problem.demand.length - used.length}");
    print("Remaining supply: ${supplyLeft}");
    print("Remaining demand: ${demandLeft}");
  }

  // Нахождение оптимального решения
  bool continueRunning = true;
  int iterations = 0;
  int maxIterations = 200;
  do {
    int coefsCount = coefs.fold(0, (e, el) => e + el.fold(0, (ee, ele) => ee + (ele == null ? 0 : 1)));
    int coefsCountTarget = problem.supply.length + problem.demand.length - 1;
    if(coefsCount < coefsCountTarget) {
      for(int i = 0; i < coefsCountTarget - coefsCount; i++) {
        bool done = false;
        for(int x = 0; x < problem.supply.length; x++) {
          for(int y = 0; y < problem.demand.length; y++) {
            if(coefs[x][y] == null) {
              if(getPath(coefs, [(x, y)]) == null) {
                coefs[x][y] = 0;
                done = true;
                break;
              }
            }
          }
          if(done) break;
        }
        if(!done) throw Exception("Недостаточно коэффициентов");
      }
    }

    List<double?> u = List.filled(problem.supply.length, null);
    List<double?> v = List.filled(problem.demand.length, null);

    u[0] = 0;
    int iter = 0;
    int maxIter = 1000;
    while((u.any((e) => e == null) || v.any((e) => e == null)) && iter < maxIter) {
      for(int i = 0; i < problem.supply.length; i++) {
        for(int j = 0; j < problem.demand.length; j++) {
          if(u[i] != null && v[j] == null && coefs[i][j] != null) {
            v[j] = problem.prices[i][j] - u[i]!;
            print("v[$j] = ${problem.prices[i][j]} ($i, $j) - ${u[i]} = ${v[j]}");
          }
          else if(v[j] != null && u[i] == null && coefs[i][j] != null) {
            u[i] = problem.prices[i][j] - v[j]!;
            print("u[$i] = ${problem.prices[i][j]} ($i, $j) - ${v[j]} = ${u[i]}");
          } else if(u[i] != null && v[j] != null && coefs[i][j] != null) {
            if(u[i]! + v[j]! != problem.prices[i][j]) {
              throw Exception("Неравенство в u+v=c: (${u[i]} + ${v[j]} != ${problem.prices[i][j]})");
            }
          }
        }
      }
      iter++;
    }

    List<List<double>> deltas = [];
    double minDelta = double.maxFinite;
    Map<double, List<Coord>> deltaMap = {};
    for(int i = 0; i < problem.supply.length; i++) {
      deltas.add([]);
      for(int j = 0; j < problem.demand.length; j++) {
        double delta = 0;
        if(coefs[i][j] == null) {
          delta = problem.prices[i][j] - (u[i]! + v[j]!);
        }
        deltas[i].add(delta);
        deltaMap.putIfAbsent(delta, () => []).add((i, j));
        if(delta < minDelta) {
          minDelta = delta;
        }
      }
    }
    double totalCost = getTotalCost(coefs, problem.prices);
    String s = "\n";
    for(int i = 0; i < problem.supply.length; i++) {
      s += "A$i\t";
      for(int j = 0; j < problem.demand.length; j++) {
        s += "${coefs[i][j]?.toStringAsFixed(0) ?? '--'} (c${problem.prices[i][j].toStringAsFixed(0)} d${deltas[i][j].toStringAsFixed(0)})\t";
      }
      s += "${u[i]?.toStringAsFixed(0)}\n";
    }
    s += "\t" + v.map((e) => e?.toStringAsFixed(0)).join('\t');
    print(s);
    print("Total cost: $totalCost");

    print('='*20);

    continueRunning = minDelta < 0 && iterations < maxIterations;
    iterations++;

    if(!continueRunning) break;

    bool done = false;
    for(var deltaMapEntry in deltaMap.entries.where((e) => e.key < 0).toList()..sort((e1, e2) => e1.key.compareTo(e2.key))) {
      for(var minDeltaCoord in deltaMapEntry.value) {
        List<Coord>? path = getPath(coefs, [minDeltaCoord]);

        if(path == null) continue;
        print("Path: ${path.join(' -> ')}");

        double minVal = double.infinity;
        for(var (i, c) in path.sublist(1, path.length - 1).indexed) {
          if((i + 1) % 2 == 1) minVal = min(coefs[c.$1][c.$2]!, minVal);
        }

        if(minVal == double.infinity) throw Exception('minVal == infinity');
        if(minVal == 0) {
          print('minVal == 0, skipping');
          continue;
        }
        print("minVal: $minVal");
        print("Predicted total cost change: $totalCost + ${minVal * minDelta}");

        for(var (i, c) in path.sublist(0, path.length - 1).indexed) {
          if(i % 2 == 1) {
            coefs[c.$1][c.$2] = coefs[c.$1][c.$2]! - minVal;
            if(coefs[c.$1][c.$2]! < 0) throw Exception('Negative amount');
            if(coefs[c.$1][c.$2] == 0) coefs[c.$1][c.$2] = null;
          } else {
            coefs[c.$1][c.$2] = (coefs[c.$1][c.$2] ?? 0) + minVal;
          }
        }

        if(totalCost + minVal * minDelta != getTotalCost(coefs, problem.prices)) {
          print('predicted totalCost (${totalCost + minVal * minDelta}) != getTotalCost(coefs, problem.prices) (${getTotalCost(coefs, problem.prices)})');
        }

        done = true;
        break;
      }
      if(done) break;
    }
    if(!done) {
      print('No path found');
      break;
    }
  } while(continueRunning);

  return TransportProblemSolution(coefs: coefs, problem: problem);
}

List<Coord>? _chooseMinPrice(TransportProblem problem, Set<Coord> used) {
  List<Coord> minPrice = [];
  double minPriceValue = double.infinity;
  for(int x = 0; x < problem.supply.length; x++) {
    for(int y = 0; y < problem.demand.length; y++) {
      double price = problem.prices[x][y];
      if(!used.contains((x, y))) {
        if(minPrice.isEmpty || price < minPriceValue) {
          minPrice.clear();
          minPrice.add((x, y));
          minPriceValue = price;
        } else if(price == minPriceValue) {
          minPrice.add((x, y));
        }
      }
    }
  }
  if(minPrice.isEmpty) return null;
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
  
  Coord last = path.last;
  bool anyDirection = path.length == 1;
  bool vertical = anyDirection || path[path.length-1].$2 != path[path.length-2].$2; // Последнее перемещение - горизонтальное
  bool horizontal = anyDirection || path[path.length-1].$1 != path[path.length-2].$1; // Последнее перемещение - вертикальное
  if(vertical) {
    for(int i = 0; i < coefs.length; i++) {
      if(i == last.$1) continue;
      if(coefs[i][last.$2] == null && (i, last.$2) != path.first) {
        continue;
      }
      if(path.contains((i, last.$2)) && (i, last.$2) != path.first) {
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
}