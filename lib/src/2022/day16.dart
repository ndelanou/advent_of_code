import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dijkstra/dijkstra.dart';

import '../utils/utils.dart';

class Day16 extends GenericDay {
  Day16() : super(2022, 16);

  @override
  List<Valve> parseInput() {
    return input.getPerLine().map((l) {
      final splits = l.split(' ');
      final name = splits[1];
      final rate = int.parse(splits[4].substring(5).replaceAll(';', ''));
      final connections = splits.sublist(9).map((e) => e.replaceAll(',', '')).toList();

      return Valve(name, rate, connections);
    }).toList();
  }

  Map<String, Map<String, int>> computeDistances(List<Valve> valves, String start) {
    Map<String, Map<String, int>> distances = {};
    final graph = valves
      .map((v) => v.connections.map((c) => [v.name, c].sorted((a, b) => a.compareTo(b))))
      .expand((e) => e).toSet().toList();

    Iterable<Valve> interestingValves = valves.where((v) => v.rate != 0 || v.name == start);
    for (final valve in interestingValves) {
      for (var target in interestingValves) {
        final d = Dijkstra.findPathFromPairsList(graph, valve.name, target.name).length;
        if (!distances.containsKey(valve.name)) distances[valve.name] = Map();
        distances[valve.name]![target.name] = d;
      }
    }

    return distances;
  }

  @override
  int solvePart1() {
    final valves = parseInput();
    final distances = computeDistances(valves, 'AA');
    final interestingValves = valves.where((v) => v.rate > 0);
    final bestScore = findBestScore(distances, 'AA', interestingValves, 30);
    return bestScore; // 1559 (1651)
  }
  

  @override
  int solvePart2() {
    final valves = parseInput();
    final distances = computeDistances(valves, 'AA');
    final interestingValves = valves.where((v) => v.rate > 0);
    final bestScore = findBestScoreWithMyElephantBuddy(distances, 'AA', 'AA', interestingValves, 26);
    return bestScore; // 2191 (1707)
  }
}

int findBestScore(Map<String, Map<String, int>> graph, String currentValve, Iterable<Valve> valves, int remainingTime) {
  return valves.map((end) {
    final distance = graph[currentValve]![end.name]!;
    final valveOpenMinutes = remainingTime - distance;
    final score = valveOpenMinutes * end.rate;

    if (distance <= remainingTime) {
      final target = end.name;
      return score + findBestScore(graph, target, valves.where((v) => v.name != target).toList(), remainingTime - distance);
    } else {
      return 0;
    }
  }).maxOrNull ?? 0;
}

final Map<String, int> cache = {};
int findBestScoreWithMyElephantBuddy(Map<String, Map<String, int>> graph, String initial, String currentValve, Iterable<Valve> valves, int remainingTime) {
  final availableValves = valves.where((v) => v.name != currentValve).toList();

  final availableValvesKey = availableValves.map((v) => v.name).sorted((a, b) => a.compareTo(b)).join('|');
  final cacheKey = '$currentValve-$remainingTime-$availableValvesKey';
  final cacheValue = cache[cacheKey];
  if (cacheValue != null) return cacheValue;

  int bestScore = findBestScore(graph, initial, availableValves, 26);

  final rec = availableValves.map((v) {
    final dist = graph[currentValve]![v.name]!;
    final newRemainingTime = remainingTime - dist;
    if (newRemainingTime >= 0) {
      return v.rate * newRemainingTime + findBestScoreWithMyElephantBuddy(graph, initial, v.name, availableValves, newRemainingTime);
    }
    return 0;
  }).maxOrNull ?? 0;

  bestScore = max(bestScore, rec);
  cache[cacheKey] = bestScore;
  return bestScore;
}
class Valve {
  final String name;
  final int rate;
  final List<String> connections;

  Valve(this.name, this.rate, this.connections);

  @override
  String toString() => '$name ($rate) - ${connections.join(',')}';
}

