import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/pathfinding/dijkstra.dart';
import '../utils/utils.dart';

class Day24 extends GenericDay {
  Day24() : super(2022, 24);

  @override
  Tuple2<Position, List<Blizzard>> parseInput() {
    final lines = input.getPerLine();
    final blizzards = lines.mapIndexed(
      (y, l) => l.split('').mapIndexed((x, e) => (e == '.' || e == '#') ? null : Blizzard(Position(x, y), Blizzard.directionFromString(e))).whereNotNull().toList()
    ).expand((element) => element);
    return Tuple2(Position(lines.first.length, lines.length), blizzards.toList());
  }

  int solvePart1() {
    final data = parseInput();
    final gridDimension = data.item1;
    final initialBlizzards = data.item2;

    final start = Position(1, 0);
    final end = Position(gridDimension.x - 2, gridDimension.y - 1);
    final result = findBestPathLength(gridDimension, initialBlizzards, start, end);
    final bestPathLength = result.item1;

    return bestPathLength;
  }

  Tuple2<int, List<Blizzard>> findBestPathLength(Tuple2<int, int> gridDimension, List<Blizzard> initialBlizzards, Position start, Position end) {
    List<Blizzard> currentBlizzards = initialBlizzards;
    Set<Position> evaluatingPositions = {start};
    for (var i = 0; i < 100000000; i++) {
      final nextBlizzards = currentBlizzards.map((b) => b.nextPosition(gridDimension)).toList();
      evaluatingPositions = evaluatingPositions.map((p) => possibleTargets(p, gridDimension, nextBlizzards, start, end)).flattened.toSet();
      evaluatingPositions = evaluatingPositions.sorted((a, b) => a.distance(end).compareTo(b.distance(end))).take(50).toSet();
      if (evaluatingPositions.any((pos) => pos == end)) return Tuple2(i + 1, nextBlizzards);
      currentBlizzards = nextBlizzards;
    }
    throw 'Should not happend';
  }

  // Returns all filterd possible positions for position
  Iterable<Position> possibleTargets(Position position, Tuple2<int, int> gridDimension, List<Blizzard> nextBlizzards, Position start, Position end) sync* {
    yield* [
      Position(position.x, position.y),
      Position(position.x, position.y - 1),
      Position(position.x + 1, position.y),
      Position(position.x, position.y + 1),
      Position(position.x - 1, position.y),
    ].where((pos) {
      return (
          (
            pos.x >= 1 && pos.y >= 1 && pos.x < gridDimension.x - 1 && pos.y < gridDimension.y - 1
          ) || (
            pos == start || pos == end
          )
        ) && nextBlizzards.every((b) => b.position != pos);
    });
  }

  @override
  int solvePart2() {
    final data = parseInput();
    final gridDimension = data.item1;
    final initialBlizzards = data.item2;

    final start = Position(1, 0);
    final end = Position(gridDimension.x - 2, gridDimension.y - 1);
    final result1 = findBestPathLength(gridDimension, initialBlizzards, start, end);
    final result2 = findBestPathLength(gridDimension, result1.item2, end, start);
    final result3 = findBestPathLength(gridDimension, result2.item2, start, end);

    return result1.item1 + result2.item1 + result3.item1;
  }

}

class Day24Dijkstra extends GenericDay {
  Day24Dijkstra() : super(2022, 24);

  @override
  Tuple2<Position, List<Blizzard>> parseInput() {
    final lines = input.getPerLine();
    final blizzards = lines.mapIndexed(
      (y, l) => l.split('').mapIndexed((x, e) => (e == '.' || e == '#') ? null : Blizzard(Position(x, y), Blizzard.directionFromString(e))).whereNotNull().toList()
    ).expand((element) => element);
    return Tuple2(Position(lines.first.length, lines.length), blizzards.toList());
  }

  @override
  int solvePart1() {
    final data = parseInput();
    final gridDimension = data.item1;
    final initialBlizzards = data.item2;

    final start = Position(1, 0);
    final end = Position(gridDimension.x - 2, gridDimension.y - 1);
    final bestPathLength = findBestPathLength(gridDimension, initialBlizzards, start, end);

    return bestPathLength.item1;
  }


  Tuple2<int, List<Blizzard>> findBestPathLength(Tuple2<int, int> gridDimension, List<Blizzard> initialBlizzards, Position start, Position end) {
    final paths = dBuildPathMap(300, gridDimension, initialBlizzards, start, end).toList();
    final oneWayGraph = paths.groupFoldBy<String, List<(String, int)>>((p) => p.first, (agg, p) => (agg ?? [])..add((p.last, 1))); 
    final bestPath = Dijkstra.findPathFromGraph(oneWayGraph, start: 'start', end: 'end');
    final bestPathLength = bestPath.$0.length - 1;
    return Tuple2(bestPathLength, blizzardAfter(bestPathLength, initialBlizzards, gridDimension));
  }

  List<Blizzard> blizzardAfter(int nbRound, List<Blizzard> initialBlizzards, Position gridDimension) {
    var currentBlizzards = initialBlizzards;
    for (var i = 0; i < nbRound; i++) {
      currentBlizzards = currentBlizzards.map((b) => b.nextPosition(gridDimension)).toList();
    }
    return currentBlizzards;
  }


  Iterable<List<String>> dBuildPathMap(int iterations, Tuple2<int, int> gridDimension, List<Blizzard> initialBlizzards, Position start, Position end) sync* {
    
    List<Blizzard> currentBlizzards = initialBlizzards;
    for (var i = 0; i < iterations; i++) {
      final nextBlizzards = currentBlizzards.map((b) => b.nextPosition(gridDimension)).toList();

      final availablePositions = dAllGridPositions(gridDimension, currentBlizzards, start, end);
      final availableMoves = availablePositions.map((p) => possibleTargets(p, gridDimension, nextBlizzards, start, end).map((t) => Tuple2(p, t))).expand((m) => m);
      final pathPairs = availableMoves.map((e) {
        final from = e.item1 == start ? '${i == 0 ? '' : '$i-'}start' : e.item1 == end ? 'end' : '$i-${e.item1.x}-${e.item1.y}';
        final to = e.item2 == start ? '${i+1}-start' : e.item2 == end ? 'end' : '${i+1}-${e.item2.x}-${e.item2.y}';
        return [from, to];
      });
      yield* pathPairs;
      currentBlizzards = nextBlizzards;
    }
  }

  Iterable<Position> dAllGridPositions(Tuple2<int, int> gridDimension, Iterable<Blizzard> currentBlizzards, Position start, Position end) sync* {
    yield start;
    for (var i = 1; i < gridDimension.x - 1; i++) {
      for (var j = 1; j < gridDimension.y - 1; j++) {
        final pos = Position(i, j);
        if (!currentBlizzards.any((b) => b.position == pos)) {
          yield pos;
        }
      } 
    }
  }


  // Returns all filterd possible positions for position
  Iterable<Position> possibleTargets(Position position, Tuple2<int, int> gridDimension, List<Blizzard> nextBlizzards, Position start, Position end) sync* {
    yield* [
      Position(position.x, position.y),
      Position(position.x, position.y - 1),
      Position(position.x + 1, position.y),
      Position(position.x, position.y + 1),
      Position(position.x - 1, position.y),
    ].where((pos) {
      return (
          (
            pos.x >= 1 && pos.y >= 1 && pos.x < gridDimension.x - 1 && pos.y < gridDimension.y - 1
          ) || (
            pos == start || pos == end
          )
        ) && nextBlizzards.every((b) => b.position != pos);
    });
  }

  @override
  int solvePart2() {
    final data = parseInput();
    final gridDimension = data.item1;
    final initialBlizzards = data.item2;

    final start = Position(1, 0);
    final end = Position(gridDimension.x - 2, gridDimension.y - 1);
    final result1 = findBestPathLength(gridDimension, initialBlizzards, start, end);
    final result2 = findBestPathLength(gridDimension, result1.item2, end, start);
    final result3 = findBestPathLength(gridDimension, result2.item2, start, end);

    return result1.item1 + result2.item1 + result3.item1;
  }

}

extension PositionExtension on Position {
  int distance(Position other) {
    return (this.x - other.x).abs() + (this.y - other.y).abs();
  }    
}

extension ListExtension<T> on List<T> {
  Iterable<T> flatten<T>(Iterable<Iterable<T>> items) sync* {
    for (var i in items) {
      yield* i;
    }
  }
}

class Blizzard {
  final Position position;
  final Position direction;

  Blizzard(this.position, this.direction);

  @override
  String toString() {
    return '(${position.x}, ${position.y}) - ${stringFromDirection(direction)}';
  }

  Blizzard nextPosition(Tuple2<int, int> gridDimension) {
    final newX = (position.x + direction.x - 1) % (gridDimension.x - 2) + 1;
    final newY = (position.y + direction.y - 1) % (gridDimension.y - 2) + 1;
    return Blizzard(Position(newX, newY), direction);
  }

  static const _directions = [ 
    Position(1, 0), 
    Position(0, 1), 
    Position(-1, 0), 
    Position(0, -1),
  ];

  static const _directionChars = [ 
    '>',
    'v',
    '<',
    '^',
  ];

  static Position directionFromString(String char) {
    return _directions[_directionChars.indexOf(char)];
  }

  static String stringFromDirection(Position direction) {
    return _directionChars[_directions.indexOf(direction)];
  }
}
