import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day07 extends GenericDay {
  Day07() : super(2021, 7);

  @override
  List<int> parseInput() {
    return input.getBy(',').map((e) => int.parse(e.trim())).toList();
  }

  @override
  int solvePart1() {
    final crabs = parseInput();
    int minCost = 100000000000;
    final maxIndex = crabs.reduce(max);

    for (var i = 0; i < maxIndex; i++) {
      final cost = crabs.map((crab) =>  (i - crab).abs()).sum;
      minCost = min(minCost, cost);
    }

    return minCost;
  }

  @override
  int solvePart2() {
    final crabs = parseInput();
    int minCost = 100000000000;
    final maxIndex = crabs.reduce(max);

    for (var i = 0; i < maxIndex; i++) {
      final cost = crabs.map((crab) => computeCost((i - crab).abs())).sum;
      minCost = min(minCost, cost);
    }

    return minCost;
  }

  int computeCost(int diff) {
    int acc = 0;
    for (var i = 0; i <= diff; i++) acc += i;
    return acc;
  }
}

