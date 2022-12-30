import 'dart:math';

import 'package:advent_of_code/src/2022/day23.dart';
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
    final data = parseInput();
    final points = data.$0;
    final instructions = data.$1;

    final newPoints = fold(points, instructions.first.$0, instructions.first.$1);
    
    return newPoints.length;
  }

  @override
  solvePart2() {
    final data = parseInput();
    var points = data.$0;
    final instructions = data.$1;

    for (var instr in instructions) {
      points = fold(points, instr.$0, instr.$1);
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