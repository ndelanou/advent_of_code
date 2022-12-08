import 'dart:io';
import 'dart:math';
import 'package:collection/collection.dart';

const filename = 'input.txt';

void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final lines = (await file.readAsString()).split('\n');
  print('lines: ${lines.length}');

  final segments = lines.map((l) {
    final splits = l.split(' -> ');
    final startCoord = splits[0].split(',').map((e) => int.parse(e)).toList();
    final endCoord = splits[1].split(',').map((e) => int.parse(e)).toList();
    return Segment(Point(startCoord[0], startCoord[1]), Point(endCoord[0], endCoord[1]));
  });

  // Part 1
  print(getOverlapingLines(segments.where((s) => s.start.x == s.end.x || s.start.y == s.end.y)));

  // Part 2
  print(getOverlapingLines(segments.where((s) => s.start.x == s.end.x || s.start.y == s.end.y || (s.start.x - s.end.x).abs() == (s.start.y - s.end.y).abs())));
 
}

int getOverlapingLines(Iterable<Segment> segments, {int overlapThreshold = 2}) {
  final linePoints = segments.expand((segment) => segment.points);
  final overlapsPerPoints = linePoints.groupListsBy((element) => element);
  return overlapsPerPoints.values.where((c) => c.length >= overlapThreshold).length;
}

class Segment {
  Segment(this.start, this.end);

  final Point start;
  final Point end;

  Iterable<Point> get points {
    final xDiff = start.x - end.x;
    final yDiff = start.y - end.y;
    final maxDiff = max(xDiff.abs(), yDiff.abs());

    final iterationRange = range(0, maxDiff);
    return iterationRange.map((i) {
      return Point(
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

List<num> range(num from, num to) {
  int inc = from < to ? 1 : -1;
  return [for(var i=from; i!=(to + inc); i += inc) i];
}