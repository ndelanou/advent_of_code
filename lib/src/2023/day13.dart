import 'dart:math';

import '../utils/utils.dart';

class Day13 extends GenericDay {
  Day13() : super(2023, 13);

  @override
  List<Grid<String>> parseInput() {
    final patterns = input.getBy('\n\n');
    return patterns
        .map(
          (p) => Grid(
            p
                .split('\n')
                .map(
                  (l) => l.split('').toList(),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  int solvePart1() {
    final grids = parseInput();

    int summary = 0;

    for (int i = 0; i < grids.length; i += 1) {
      if (grids[i].symetricW() case final w?) {
        summary += w;
      }
      if (grids[i].symetricH() case final h?) {
        summary += h * 100;
      }
    }

    return summary;
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    return lines.length;
  }
}

void main() {
  Day13().printSolutions();
}

extension on Grid<String> {
  int? symetricH() {
    cursor:
    for (var i = 1; i < height; i++) {
      final maxRange = min(i, height - i);

      for (var j = 0; j < maxRange; j++) {
        final row1 = getRow(i - j - 1).join();
        final row2 = getRow(i + j).join();

        if (row1 != row2) continue cursor;
      }

      return i;
    }

    return null;
  }

  int? symetricW() {
    final transposed = transpose();
    return transposed.symetricH();
  }
}
