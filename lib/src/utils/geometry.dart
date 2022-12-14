import 'dart:math';

import 'utils.dart';

class Segment {
  Segment(this.start, this.end);

  final Position start;
  final Position end;

  Iterable<Position> get points {
    final xDiff = start.x - end.x;
    final yDiff = start.y - end.y;
    final maxDiff = max(xDiff.abs(), yDiff.abs());

    final iterationRange = Range(0, maxDiff).iterable;
    return iterationRange.map((i) {
      return Position(
        start.x + (-xDiff * i / maxDiff).round(),
        start.y + (-yDiff * i / maxDiff).round(),
      );
    });
  }

  bool contains(Position pos) {
    if (pos.x == start.x && pos.x == end.x) {
      return pos.y >= min(start.y, end.y) && pos.y <= max(start.y, end.y);
    } else if (pos.y == start.y && pos.y == end.y) {
      return pos.x >= min(start.x, end.x) && pos.x <= max(start.x, end.x);
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return '(${start.x},${start.y})-(${end.x},${end.y})';
  }
}