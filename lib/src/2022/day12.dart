import 'package:collection/collection.dart';

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
    final Set<Link> links = {};
    explore(grid, start, links);
    print(links.length);

    // Find path
    Map<Position, int> visitedPosition = {start: 0};
    final bestPath = findBestPath(links, start, end, visitedPosition);

    return bestPath; // 408
  }


  int findBestPath(Set<Link> links, Position from, Position end, Map<Position, int> visitedPositions, {int currentStep = 0}) {
    final matchLinks = links.where((link) => link.start == from && (visitedPositions[link.end] ?? 100000000000) > currentStep + 1).toList();
    // print(matchLinks);

    if (matchLinks.isEmpty) return 100000000000;

    List<int> results = [];
    for (var matchLinks in matchLinks) {
      visitedPositions[matchLinks.end] = currentStep + 1;

      if (matchLinks.end == end) {
        results.add(currentStep + 1);
      } else {
        results.add(findBestPath(links, matchLinks.end, end, visitedPositions, currentStep: currentStep + 1));
      }
    }

    final lowest = results.sortedBy((element) => element as num).firstOrNull ?? 100000000000;
    
    return lowest;
  }
  
  explore(Grid<int> grid, Position from, Set<Link> links) {
    List<Position> possibleMoves = [];
    if (from.x > 0) {
      possibleMoves.add(Position(from.x - 1, from.y));
    }
    if (from.x < grid.grid.first.length - 1) {
      possibleMoves.add(Position(from.x + 1, from.y));
    }

    if (from.y > 0) {
      possibleMoves.add(Position(from.x, from.y - 1));
    }
    if (from.y < grid.grid.length - 1) {
      possibleMoves.add(Position(from.x, from.y + 1));
    }

    possibleMoves = possibleMoves.where((move) {
      final diff = grid.grid[move.y][move.x] - grid.grid[from.y][from.x];
      return (grid.grid[move.y][move.x] >= a && diff <= 1);
    }).toList();
    
    final addedLinks = possibleMoves.map((move) => Link(from, move)).toList();
    links.addAll(addedLinks);

    final alreadyMappedPositions = links.map((e) => e.start).toList();
    final notMappedMoves = possibleMoves.where((element) => !alreadyMappedPositions.contains(element)).toList();

    for (var move in notMappedMoves) {
      explore(grid, move, links);
    }
  }

  @override
  int solvePart2() {
    return 0;
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

