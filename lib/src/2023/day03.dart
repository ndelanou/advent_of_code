import 'dart:math';

import '../utils/utils.dart';

class Day03 extends GenericDay {
  Day03() : super(2023, 3);

  @override
  Grid parseInput() {
    return Grid(input.getPerLine().map((e) => e.split('').toList()).toList());
  }

  @override
  int solvePart1() {
    final rxNumber = RegExp(r'(\d)+');
    final rxSymbol = RegExp(r'[^\.1-9]');

    final grid = parseInput();
    int sum = 0;
    for (var i = 0; i < grid.height; i++) {
      final row = grid.getRow(i).join('');
      final matches = rxNumber.allMatches(row);
      for (var match in matches) {
        final start = match.start;
        final end = match.end;
        final number = int.parse(match.group(0)!);

        String adjacent = '';
        if (i > 0) {
          final top = grid.getRow(i - 1).toList().sublist(max(0, start - 1), min(grid.width - 1, end + 1)).join('');
          adjacent += top;
        }

        if (i < grid.height - 1) {
          final bottom = grid.getRow(i + 1).toList().sublist(max(0, start - 1), min(grid.width - 1, end + 1)).join('');
          adjacent += bottom;
        }

        if (start > 0) {
          final left = grid.getRow(i).toList()[start - 1];
          adjacent += left;
        }

        if (end < row.length - 1) {
          final right = grid.getRow(i).toList()[end];
          adjacent += right;
        }

        if (rxSymbol.hasMatch(adjacent)) {
          sum += number;
        }
      }
    }

    return sum;
  }

  @override
  int solvePart2() {
    final rxNumber = RegExp(r'(\d)+');
    final rxGear = RegExp(r'\*');

    final grid = parseInput();
    List<(Match, int, int)> numbers = [];
    List<(int, int)> gears = [];

    for (var i = 0; i < grid.height; i++) {
      final row = grid.getRow(i).join('');
      final matches = rxNumber.allMatches(row);
      for (var match in matches) {
        final number = int.parse(match.group(0)!);
        numbers.add((match, i, number));
      }
    }

    for (var i = 0; i < grid.height; i++) {
      final row = grid.getRow(i).join('');
      final matches = rxGear.allMatches(row);
      for (var match in matches) {
        gears.add((match.start, i));
      }
    }

    int sum = 0;

    for (final gear in gears) {
      final (x, y) = gear;

      Set<(Match, int, int)> matchingNumers = {};

      final neighbours = grid.neighbours(x, y);
      for (final n in neighbours) {
        for (final number in numbers) {
          if (number.$1.start <= n.x && number.$1.end > n.x && number.$2 == n.y) {
            matchingNumers.add(number);
          }
        }
      }

      if (matchingNumers.length == 2) {
        sum += matchingNumers.first.$3 * matchingNumers.last.$3;
      }
    }

    return sum;
  }
}

void main(List<String> args) {
  Day03().printSolutions();
}
