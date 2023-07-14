import 'dart:math';

import '../utils/utils.dart';

extension on (Position a, Position b) {
  bool contains(Position position) => position.x >= this.$1.x && position.x <= this.$2.x && position.y >= this.$1.y && position.y <= this.$2.y;
}

class Day17 extends GenericDay {
  Day17() : super(2021, 17);

  @override
  (Position, Position) parseInput() {
    final line = input.asString;
    final matches = RegExp(r'([-\d]+)\.\.([-\d]+)').allMatches(line).toList();
    return (
      Position(int.parse(matches.first.group(1)!), int.parse(matches.last.group(1)!)),
      Position(int.parse(matches.first.group(2)!), int.parse(matches.last.group(2)!)),
    );
  }

  @override
  solvePart1() {
    final zone = parseInput();
    final rangeX = 20, rangeY = 200, maxIt = 400;
    int maxY = 0;
    for (var x = 0; x < rangeX; x++) {
      for (var y = 0; y < rangeY; y++) {
        int localMaxY = 0;
        Position position = Position(0, 0);
        Position velocity = Position(x, y);
        for (var i = 0; i < maxIt; i++) {
          final result = nextPos(position, velocity);
          position = result.$1;
          velocity = result.$2;
          localMaxY = max(localMaxY, position.y);
          if (zone.contains(position)) {
            maxY = max(maxY, localMaxY);
            break;
          }

          if (position.y < min(zone.$1.y, zone.$2.y)) break;
          if (position.x > max(zone.$1.x, zone.$2.x)) break;
        }
      }
    }

    return maxY;
  }

  (Position newPosition, Position newVelociity) nextPos(Position position, Position velocity) {
    final newVelocityX = max(0, velocity.x - velocity.x.sign);
    final newVelocityY = velocity.y - 1;
    return (
      Position(position.x + velocity.x, position.y + velocity.y),
      Position(newVelocityX, newVelocityY),
    );
  }

  @override
  solvePart2() {
    final zone = parseInput();
    final rangeX = 96, rangeY = 200, maxIt = 400;
    Set<Position> validVelocities = {};
    for (var x = 0; x < rangeX; x++) {
      for (var y = -rangeY; y < rangeY; y++) {
        Position position = Position(0, 0);
        Position velocity = Position(x, y);
        for (var i = 0; i < maxIt; i++) {
          final result = nextPos(position, velocity);
          position = result.$1;
          velocity = result.$2;
          if (zone.contains(position)) {
            validVelocities.add(Position(x, y));
            break;
          }
          if (position.y < min(zone.$1.y, zone.$2.y)) break;
          if (position.x > max(zone.$1.x, zone.$2.x)) break;
        }
      }
    }

    return validVelocities.length;
  }
}

void main(List<String> args) {
  Day17().printSolutions();
}
