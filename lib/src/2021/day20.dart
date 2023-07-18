import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day20 extends GenericDay {
  Day20() : super(2021, 20);

  @override
  (List<bool> algorithm, Set<Pos2D> points) parseInput() {
    final litCodeUnit = '#'.codeUnits.first;
    final lines = input.getPerLine();
    final algorithm = lines.first.codeUnits.map((code) => code == litCodeUnit).toList();
    final points = lines
        .skip(2)
        .mapIndexed((lineIndex, line) {
          return line.codeUnits.mapIndexed((charIndex, char) => (char == litCodeUnit) ? (charIndex, lineIndex) : null).whereNotNull();
        })
        .expand((element) => element)
        .toSet();

    return (algorithm, points);
  }

  Set<Pos2D> enhance(List<bool> algorithm, Set<Pos2D> points, int minValue, int maxValue) {
    final newPoints = <Pos2D>{};

    for (var y = minValue; y <= maxValue; y++) {
      for (var x = minValue; x <= maxValue; x++) {
        final index = (x, y).algoIndex(points);
        if (algorithm[index]) {
          newPoints.add((x, y));
        }
      }
    }

    return newPoints;
  }

  Set<Pos2D> enhanceMutlipleTimes(List<bool> algorithm, Set<Pos2D> points, {required int times}) {
    var tmp = points;

    final (minX, maxX) = minMax(points.map((p) => p.$1).toList());
    final (minY, maxY) = minMax(points.map((p) => p.$2).toList());

    for (var i = 0; i < times; i++) {
      tmp = enhance(algorithm, tmp, min(minX, minY) - (times * 2), max(maxX, maxY) + (times * 2));
    }

    return tmp
        .where(
          (point) =>
              point.$1 >= minX - times &&
              point.$1 <= maxX + times //
              &&
              point.$2 >= minY - times &&
              point.$2 <= maxY + times,
        )
        .toSet();
  }

  (int min, int max) minMax(Iterable<int> input) {
    return (input.min, input.max);
  }

  @override
  int solvePart1() {
    var (algo, points) = parseInput();

    final enhancedPoints = enhanceMutlipleTimes(algo, points, times: 2);

    return enhancedPoints.length;
  }

  @override
  int solvePart2() {
    var (algo, points) = parseInput();

    final enhancedPoints = enhanceMutlipleTimes(algo, points, times: 50); // 20793 too hight

    return enhancedPoints.length;
  }
}

typedef Pos2D = (int x, int y);

extension on Pos2D {
  Iterable<Pos2D> get neighbours {
    return <Pos2D>{
      // positions are added in a circle, starting at the top middle
      (this.$1 - 1, this.$2 - 1),
      (this.$1, this.$2 - 1),
      (this.$1 + 1, this.$2 - 1),
      (this.$1 - 1, this.$2),
      (this.$1, this.$2),
      (this.$1 + 1, this.$2),
      (this.$1 - 1, this.$2 + 1),
      (this.$1, this.$2 + 1),
      (this.$1 + 1, this.$2 + 1),
    };
  }

  int algoIndex(Set<Pos2D> points) {
    return neighbours.foldIndexed(0, (index, previous, element) {
      if (points.contains(element)) {
        return previous + (1 << (8 - index));
      }
      return previous;
    });
  }
}

void main(List<String> args) {
  final day = Day20();
  day.printSolutions();
}
