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

  @override
  String toString() {
    return '(${start.x},${start.y})-(${end.x},${end.y})';
  }
}