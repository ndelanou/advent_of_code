import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

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

  @override
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
      evaluatingPositions = evaluatingPositions.map((p) => possibleTargets(p, gridDimension, nextBlizzards, start, end)).expand((m) => m).toSet();
      evaluatingPositions = evaluatingPositions.sorted((a, b) => a.distance(end).compareTo(b.distance(end))).take(50).toSet();
      if (evaluatingPositions.any((pos) => pos == end)) return Tuple2(i + 1, nextBlizzards);
      currentBlizzards = nextBlizzards;
    }
    throw 'Should not happend';
  }

  // Returns all filterd possible positions for position
  List<Position> possibleTargets(Position position, Tuple2<int, int> gridDimension, List<Blizzard> nextBlizzards, Position start, Position end) {
    return [
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
    }).toList();
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
