import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day05 extends GenericDay {
  Day05() : super(2022, 5);

  @override
  Iterable<Segment> parseInput() {
    return input.getPerLine().map((l) {
      final splits = l.split(' -> ');
      final startCoord = splits[0].split(',').map((e) => int.parse(e)).toList();
      final endCoord = splits[1].split(',').map((e) => int.parse(e)).toList();
      return Segment(Position(startCoord[0], startCoord[1]), Position(endCoord[0], endCoord[1]));
    });
  }

  @override
  solvePart1() {
    final segments = parseInput();
    return getOverlapingLines(segments.where((s) => s.start.x == s.end.x || s.start.y == s.end.y));
  }

  @override
  solvePart2() {
    final segments = parseInput();
    return getOverlapingLines(segments.where((s) => s.start.x == s.end.x || s.start.y == s.end.y || (s.start.x - s.end.x).abs() == (s.start.y - s.end.y).abs()));
  }

  int getOverlapingLines(Iterable<Segment> segments, {int overlapThreshold = 2}) {
    final linePoints = segments.expand((segment) => segment.points);
    final overlapsPerPoints = linePoints.groupListsBy((element) => element);
    return overlapsPerPoints.values.where((c) => c.length >= overlapThreshold).length;
  }
}
