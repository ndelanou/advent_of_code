import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dijkstra/dijkstra.dart';

import '../utils/utils.dart';

class Day12 extends GenericDay {
  Day12() : super(2022, 12);

  final S = 'S'.codeUnits.first;
  final E = 'E'.codeUnits.first;
  final a = 'a'.codeUnits.first;
  final z = 'z'.codeUnits.first;

  @override
  List<List<int>> parseInput() {
    final lines = input.getPerLine();
    return lines.map((l) => l.split('').map((e) => e.codeUnits.first).toList()).toList();
  }

  @override
  int solvePart1() {
    final grid = Grid(parseInput());

    final startX = grid.grid.map((e) => e.indexWhere((element) => element == S)).toList().firstWhere((element) => element != -1);
    final startY = grid.grid.indexWhere((element) => element.contains(S));
    final start = Position(startX, startY);

    final endX = grid.grid.map((e) => e.indexWhere((element) => element == E)).toList().firstWhere((element) => element != -1);
    final endY = grid.grid.indexWhere((element) => element.contains(E));
    final end = Position(endX, endY);

    grid.setValueAtPosition(start, a);
    grid.setValueAtPosition(end, z);

    // Explore
    final Set<Link> links = explore(grid);

    // Find path
    final froms = links.map((e) => e.start).toSet();
    final graphInput = Map.fromEntries(froms.map(
      (f) => MapEntry(
        f, 
        Map.fromIterable(
          links.where((l) => l.start == f).map((l) => l.end), 
          key: (element) => element, 
          value: (element) => 1
        ),
      )
    ));
    final dResult = Dijkstra.findPathFromGraph(graphInput, start, end);

    return dResult.length - 1;
  }
  
  explore(Grid<int> grid) {

    Set<Link> links = {};

    grid.forEach((x, y) {
      final possibleMoves = grid
        .adjacent(x, y)
        .where((move) {
          final diff = grid.grid[move.y][move.x] - grid.grid[y][x];
          return (grid.grid[move.y][move.x] >= a) && (diff <= 1);
        }).toList();
      
      final addedLinks = possibleMoves.map((move) => Link(Position(x,y), move)).toList();
      links.addAll(addedLinks);
    });

    return links;
  }

  @override
  int solvePart2() {
    final grid = Grid(parseInput());

    final startX = grid.grid.map((e) => e.indexWhere((element) => element == S)).toList().firstWhere((element) => element != -1);
    final startY = grid.grid.indexWhere((element) => element.contains(S));
    final start = Position(startX, startY);

    final endX = grid.grid.map((e) => e.indexWhere((element) => element == E)).toList().firstWhere((element) => element != -1);
    final endY = grid.grid.indexWhere((element) => element.contains(E));
    final end = Position(endX, endY);

    grid.setValueAtPosition(start, a);
    grid.setValueAtPosition(end, z);

    // Explore
    final Set<Link> links = explore(grid);

    // Find path
    final froms = links.map((e) => e.start).toSet();
    final graphInput = Map.fromEntries(froms.map(
      (f) => MapEntry(
        f, 
        Map.fromIterable(
          links.where((l) => l.start == f).map((l) => l.end), 
          key: (end) => end, 
          value: (_) => 1
        ),
      )
    ));

    final allAPositions = <Position>[];
    grid.forEach((x, y) {
      if (grid.getValueAtPosition(Position(x,y)) == a) allAPositions.add(Position(x,y));
    });

    final allResults = allAPositions.map((currentA) => Dijkstra.findPathFromGraph(graphInput, currentA, end)).where((element) => element.isNotEmpty).sortedBy((element) => element.length as num);

    final bestPath = allResults.fold(1000000000, (prev, res) => min(prev, res.length - 1));

    return bestPath;
  }
}

class Link {
  final Position start;
  final Position end;

  Link(this.start, this.end);

  @override
  bool operator ==(Object other) {
  if (other.runtimeType != runtimeType) {
    return false;
  }
  return other is Link
      && other.start.x == start.x
      && other.start.y == start.y
      && other.end.x == end.x
      && other.end.y == end.y;
}

@override
  int get hashCode => Object.hash(start.hashCode, end.hashCode);

@override
  String toString() {
    return '(${start.x},${start.y})->(${end.x},${end.y})';
  }
}

