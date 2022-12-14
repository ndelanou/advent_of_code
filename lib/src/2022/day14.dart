import 'dart:math';

import '../utils/utils.dart';
import 'package:collection/collection.dart';

class Day14 extends GenericDay {
  Day14() : super(2022, 14);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  List<Segment> getSegments() {
    final lines = parseInput().map((l) => l.split(' -> ').map((e) {
          final splits = e.split(',').map((e) => int.parse(e));
          return Position(splits.first, splits.last);
        }));

    final List<Segment> segments = lines.fold([], (acc, line) {
      final List<Segment> s = [];
      for (var i = 1; i < line.length; i++) {
        s.add(Segment(line.elementAt(i - 1), line.elementAt(i)));
      }
      return acc..addAll(s);
    });

    return segments;
  }

  Position sandSource = Position(500, 0);

  bool isPointBlocked(Set<Position> walls, Iterable<Position> stillSand, Position position) {
    return stillSand.contains(position) || walls.contains(position);
  }

  @override
  int solvePart1() {
    final segments = getSegments();
    Set<Position> walls = segments.expand((s) => s.points).toSet();
    final maxY = segments.map((e) => max(e.start.y, e.end.y)).max;

    Set<Position> stillSand = {};
    Position sand = sandSource;

    while (sand.y < maxY) {
      Position evalPosition = sand.moved(0, 1);

      // direct down blocked
      if (isPointBlocked(walls, stillSand, evalPosition)) {
        if (!isPointBlocked(walls, stillSand, evalPosition.moved(-1, 0))) {
          evalPosition = evalPosition.moved(-1, 0);
        } else if (!isPointBlocked(walls, stillSand, evalPosition.moved(1, 0))) {
          evalPosition = evalPosition.moved(1, 0);
        } else {
          evalPosition = sand;
        }
      }

      if (evalPosition == sand) {
        stillSand.add(sand);
        sand = sandSource;
      } else {
        sand = evalPosition;
      }
    }

    return stillSand.length;
  }

  @override
  int solvePart2() {
    final segments = getSegments();
    final maxY = segments.map((e) => max(e.start.y, e.end.y)).max;

    segments.add(Segment(Position(300, maxY + 2), Position(700, maxY + 2)));

    Set<Position> walls = segments.expand((s) => s.points).toSet();

    Set<Position> stillSand = {};
    Position sand = sandSource;

    while (!stillSand.contains(sandSource)) {
      Position evalPosition = sand.moved(0, 1);

      // direct down blocked
      if (isPointBlocked(walls, stillSand, evalPosition)) {
        if (!isPointBlocked(walls, stillSand, evalPosition.moved(-1, 0))) {
          evalPosition = evalPosition.moved(-1, 0);
        } else if (!isPointBlocked(walls, stillSand, evalPosition.moved(1, 0))) {
          evalPosition = evalPosition.moved(1, 0);
        } else {
          evalPosition = sand;
        }
      }

      if (evalPosition == sand) {
        stillSand.add(sand);
        sand = sandSource;
      } else {
        sand = evalPosition;
      }
    }

    return stillSand.length;
  }
}
