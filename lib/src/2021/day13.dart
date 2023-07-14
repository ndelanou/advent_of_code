import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

typedef Pos = Point<int>;

class Day13 extends GenericDay {
  Day13() : super(2021, 13);

  @override
  (Set<Pos>, List<(String, int)>) parseInput() {
    final splits = input.getPerLine().splitBefore((element) => element == '');
    final points = splits.first.map((l) {
      final s = l.split(',');
      return Pos(int.parse(s.first), int.parse(s.last));
    }).toSet();

    final instructions = (splits.last..removeAt(0)).map((s) {
      final equalSplit = s.split('=');
      return (equalSplit.first.split('').last, int.parse(equalSplit.last));
    }).toList();
    return (points, instructions);
  }

  Set<Pos> fold(Set<Pos> points, String axis, int index) {
    final tmp = <Pos>{};

    for (var p in points) {
      if (axis == 'x') {
        if (p.x <= index) {
          tmp.add(p);
        } else {
          tmp.add(Pos(index - (index - p.x).abs(), p.y));
        }
      } else {
        if (p.y <= index) {
          tmp.add(p);
        } else {
          tmp.add(Pos(p.x, index - (index - p.y).abs()));
        }
      }
    }

    return tmp;
  }

  @override
  solvePart1() {
    final (points, instructions) = parseInput();

    final newPoints = fold(points, instructions.first.$1, instructions.first.$2);

    return newPoints.length;
  }

  @override
  solvePart2() {
    var (points, instructions) = parseInput();

    for (var instr in instructions) {
      points = fold(points, instr.$1, instr.$2);
    }

    printPoints(points);
  }
}

void printPoints(Set<Pos> points) {
  final maxX = points.map((p) => p.x).max;
  final maxY = points.map((p) => p.y).max;

  for (var y = 0; y <= maxY; y++) {
    print(Range(0, maxX).iterable.map((x) => points.contains(Pos(x, y)) ? '#' : ' ').join());
  }
}

void main(List<String> args) {
  Day13().printSolutions();
}
