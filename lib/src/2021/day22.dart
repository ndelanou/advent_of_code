import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

enum ActionType { on, off }

typedef Range = ({int low, int high});
typedef Region = ({Range x, Range y, Range z});
typedef Cuboid = ({int x, int y, int z});
typedef Action = ({ActionType actionType, Region region});

class Day22 extends GenericDay {
  Day22() : super(2021, 22);

  @override
  List<Action> parseInput() {
    return input.getPerLine().map((line) {
      final [actionTypeStr, others] = line.split(' ');
      final [x, y, z] = others.split(',');
      final action = actionTypeStr == 'on' ? ActionType.on : ActionType.off;
      final rangeX = parseRange(x);
      final rangeY = parseRange(y);
      final rangeZ = parseRange(z);
      return (actionType: action, region: (x: rangeX, y: rangeY, z: rangeZ));
    }).toList();
  }

  Range parseRange(String rangeStr) {
    final [start, end] = rangeStr.substring(2).split('..');
    return (low: int.parse(start), high: int.parse(end));
  }

  @override
  int solvePart1() {
    final actions = parseInput();
    final cuboids = <Cuboid>{};
    for (final action in actions) {
      performAction(action, cuboids);
    }

    return cuboids.length;
  }

  void performAction(Action action, Set<Cuboid> cuboids) {
    if (action.region.x.high < -50 || action.region.x.low > 50) return;
    if (action.region.y.high < -50 || action.region.y.low > 50) return;
    if (action.region.z.high < -50 || action.region.z.low > 50) return;

    for (var x = max(action.region.x.low, -50); x <= min(action.region.x.high, 50); x++) {
      for (var y = max(action.region.y.low, -50); y <= min(action.region.y.high, 50); y++) {
        for (var z = max(action.region.z.low, -50); z <= min(action.region.z.high, 50); z++) {
          if (action.actionType == ActionType.on) {
            cuboids.add((x: x, y: y, z: z));
          } else {
            cuboids.remove((x: x, y: y, z: z));
          }
        }
      }
    }
  }

  int countCuboids(Action action) {
    final sign = action.actionType == ActionType.on ? 1 : -1;
    final x = (action.region.x.high - action.region.x.low) + 1;
    final y = (action.region.y.high - action.region.y.low) + 1;
    final z = (action.region.z.high - action.region.z.low) + 1;

    return sign * x * y * z;
  }

  @override
  int solvePart2() {
    final actions = parseInput();

    final lightenRegions = <Region>{};

    for (final Action action in actions) {
      final collidingRegion = lightenRegions
          .map((lr) {
            if (lr.colids(action.region) case Region collisionRegion) return (collisionRegion, lr);
          })
          .whereNotNull()
          .toList();

      for (final (collisionRegion, lightenRegion) in collidingRegion) {
        final explodedRegions = lightenRegion.explode(collisionRegion);
        lightenRegions.remove(lightenRegion);
        lightenRegions.addAll(explodedRegions);
      }

      if (action.actionType == ActionType.on) {
        lightenRegions.add(action.region);
      }
    }

    return lightenRegions.fold(0, (acc, region) => acc + region.volume);
  }
}

void main(List<String> args) {
  final day = Day22();
  day.printSolutions();
}

extension on Region {
  Region? colids(Region other) {
    if (_intersect(this.x, other.x) case final Range intersectX) {
      if (_intersect(this.y, other.y) case final Range intersectY) {
        if (_intersect(this.z, other.z) case final Range intersectZ) {
          return (x: intersectX, y: intersectY, z: intersectZ);
        }
      }
    }
    return null;
  }

  List<Region> explode(Region other) {
    final maxXLow = max(this.x.low, other.x.low);
    final minXHigh = min(this.x.high, other.x.high);
    final maxYLow = max(this.y.low, other.y.low);
    final minYHigh = min(this.y.high, other.y.high);
    final maxZLow = max(this.z.low, other.z.low);
    final minZHigh = min(this.z.high, other.z.high);

    final xBounds = (low: maxXLow, high: minXHigh);
    final yBounds = (low: maxYLow, high: minYHigh);

    return [
      // X
      if (this.x.low < maxXLow) (x: (low: this.x.low, high: maxXLow - 1), y: this.y, z: this.z),
      if (this.x.high > minXHigh) (x: (low: minXHigh + 1, high: this.x.high), y: this.y, z: this.z),

      // Y
      if (this.y.low < maxYLow) (x: xBounds, y: (low: this.y.low, high: maxYLow - 1), z: this.z),
      if (this.y.high > minYHigh) (x: xBounds, y: (low: minYHigh + 1, high: this.y.high), z: this.z),

      // Z
      if (this.z.low < maxZLow) (x: xBounds, y: yBounds, z: (low: this.z.low, high: maxZLow - 1)),
      if (this.z.high > minZHigh) (x: xBounds, y: yBounds, z: (low: minZHigh + 1, high: this.z.high)),
    ];
  }

  int get volume => (x.high - x.low + 1) * (y.high - y.low + 1) * (z.high - z.low + 1);

  Range? _intersect(Range a, Range b) {
    if (a.low > b.high || a.high < b.low) return null;
    return (low: max(a.low, b.low), high: min(a.high, b.high));
  }
}
