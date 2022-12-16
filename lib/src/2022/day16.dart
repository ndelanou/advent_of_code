import 'package:collection/collection.dart';
import 'package:dijkstra/dijkstra.dart';
import 'package:tuple/tuple.dart';

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
      for (var target in interestingValves.where((v) => v.name != valve.name)) {
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
    final bestScore = findBestScore(distances, 'AA', valves, {}, 0, 30, 0);
    return bestScore;
  }

  

  @override
  int solvePart2() {
    final valves = parseInput();
    final distances = computeDistances(valves, 'AA');
    final bestScore = findBestScoreWithMyElephantBuddy(distances, 'AA', valves, 26);
    return bestScore;
  }
}

// final test = ['DD', 'BB', 'JJ', 'HH', 'EE', 'CC'];
int findBestScore(Map<String, Map<String, int>> graph,  String currentValve, List<Valve> valves, Set<String> history, int time, int maxTime, int score) {
  final possibilities = valves.where((v) => !history.contains(v.name) && v.rate != 0).map((end) {
    final distance = graph[currentValve]![end.name]!;
    final valveOpenMinutes = maxTime - time - distance;
    final potentialScore = valveOpenMinutes * end.rate;
    return Tuple3(end.name, distance, potentialScore);
  }).where((element) => time + element.item2 <= maxTime);

  if (possibilities.isEmpty) return score;

  final results = possibilities.map((r) {
    final target = r.item1;
    final newHistory = {...history, target};
    return findBestScore(graph, target, valves, newHistory, time + r.item2, maxTime, score + r.item3);
  }).toList();

  return results.max; // --------1707
}


int findBestScoreWithMyElephantBuddy(Map<String, Map<String, int>> graph, String start, List<Valve> valves, int maxTime) {
  int score = 0;
  int time = 0;
  int mArrivingTime = 0, eArrivingTime = 0;

  while(time < maxTime) {
    // TODO;
    time++;
  }

  return score;
}


class Valve {
  final String name;
  final int rate;
  final List<String> connections;

  Valve(this.name, this.rate, this.connections);

  @override
  String toString() => '$name ($rate) - ${connections.join(',')}';
}

