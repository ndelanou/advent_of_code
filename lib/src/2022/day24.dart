import 'package:collection/collection.dart';
import 'package:dijkstra/dijkstra.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day24 extends GenericDay {
  Day24() : super(2022, 24);

  @override
  Tuple2<Position, Iterable<Blizzard>> parseInput() {
    final lines = input.getPerLine();
    final blizzards = lines.mapIndexed(
      (y, l) => l.split('').mapIndexed((x, e) => (e == '.' || e == '#') ? null : Blizzard(Position(x, y), Blizzard.directionFromString(e))).whereNotNull().toList()
    ).expand((element) => element);
    return Tuple2(Position(lines.first.length, lines.length), blizzards);
  }

  @override
  int solvePart1() {
    final data = parseInput();
    final gridDimension = data.item1;
    final blizzards = data.item2;

    final start = Position(1, 0);
    final end = Position(gridDimension.x - 2, gridDimension.y - 1);
    final paths = buildPathMap(5, gridDimension, blizzards, start, end);
    final oneWayGraph = paths.fold(<String, Map<String, int>>{}, (agg, path) {
      if (!agg.containsKey(path.first)) {
        agg[path.first] = {};
      }
      agg[path.first]![path.last] = 1;
      return agg;
    });
    final bestPath = Dijkstra.findPathFromGraph(oneWayGraph, 'start', 'end');
    print(bestPath);

    return bestPath.length - 1;
  }

  Iterable<List<String>> buildPathMap(int iterations, Tuple2<int, int> gridDimension, Iterable<Blizzard> initialBlizzards, Position start, Position end) sync* {
    
    Iterable<Blizzard> currentBlizzards = initialBlizzards;
    for (var i = 0; i < iterations; i++) {
      final nextBlizzards = currentBlizzards.map((b) => b.nextPosition(gridDimension));

      if (i % 10 == 0) print('========= $i');

      final availablePositions = allGridPositions(gridDimension, currentBlizzards, start, end);
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

  Iterable<Position> allGridPositions(Tuple2<int, int> gridDimension, Iterable<Blizzard> currentBlizzards, Position start, Position end) sync* {
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
  Iterable<Position> possibleTargets(Position position, Tuple2<int, int> gridDimension, Iterable<Blizzard> nextBlizzards, Position start, Position end) {
    return [
      Position(position.x, position.y),
      Position(position.x, position.y - 1),
      // Position(position.x + 1, position.y - 1),
      Position(position.x + 1, position.y),
      // Position(position.x + 1, position.y + 1),
      Position(position.x, position.y + 1),
      // Position(position.x - 1, position.y + 1),
      Position(position.x - 1, position.y),
      // Position(position.x - 1, position.y - 1),
    ].where((pos) {
      return (
          (
            pos.x >= 1 && pos.y >= 1 && pos.x < gridDimension.x - 1 && pos.y < gridDimension.y - 1
          ) || (
            pos == end
          )
        ) && nextBlizzards.every((b) => b.position != pos);
    });
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    return 0;
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

  static Position directionFromString(String char) {
    switch (char) {
      case '>':
        return Position(1, 0);
      case 'v':
        return Position(0, 1);
      case '<':
        return Position(-1, 0);
      case '^':
        return Position(0, -1);
      default:
        throw 'Should not happend';
    }
  }

  static String stringFromDirection(Position direction) {
    if (direction == Position(1, 0)) {
      return '>';
    }
    else if (direction == Position(0, 1)) {
      return 'v';
    }
    else if (direction == Position(-1, 0)) {
      return '<';
    }
    else if (direction == Position(0, -1)) {
      return '^';
    } else {
      throw 'Should not happend';
    }
  }
}
