import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day11 extends GenericDay {
  Day11() : super(2021, 11);

  @override
  Grid parseInput() {
    final lines = input
      .getPerLine()
      .map((l) => 
        l.split('').map((c) => int.parse(c)).toList()
      ).toList();
      
    return Grid(lines);
  }

  @override
  solvePart1() {
    final grid = parseInput();
    int flashes = 0;

    for (var step = 0; step < 100; step++) {
      // Increment each by 1
      grid.forEach((x, y) {
        grid.setValueAt(x, y, grid.getValueAt(x, y) + 1);
      });

      final Set<Position> flashed = {};
      final Set<Position> needToFlash = {};

      do {
        needToFlash.forEach((pos) {
          grid.neighbours(pos.x, pos.y).forEach((n) {
            grid.setValueAt(n.x, n.y, grid.getValueAt(n.x, n.y) + 1);
          });
        });
        flashed.addAll(needToFlash);

        needToFlash.clear();
        grid.forEach((x, y) {
          final pos = Position(x, y);
          final cellValue = grid.getValueAt(x, y);
          if (cellValue >= 10 && !flashed.contains(pos)) needToFlash.add(pos);
        });
      } while (needToFlash.isNotEmpty);

      // Reset flashed octopuses
      grid.forEach((x, y) {
        final cellValue = grid.getValueAt(x, y);
        if (cellValue >= 10) {
          flashes++;
          grid.setValueAt(x, y, 0);
        }
      });
    }

    grid.rows.forEach((row) {
      print(row.join(' '));
    });

    return flashes;
  }

  @override
  solvePart2() {
    final grid = parseInput();
    int step = 0;
    bool allFlashes = false;

    while(!allFlashes) {
      // Increment each by 1
      grid.forEach((x, y) {
        grid.setValueAt(x, y, grid.getValueAt(x, y) + 1);
      });

      final Set<Position> flashed = {};
      final Set<Position> needToFlash = {};

      do {
        needToFlash.forEach((pos) {
          grid.neighbours(pos.x, pos.y).forEach((n) {
            grid.setValueAt(n.x, n.y, grid.getValueAt(n.x, n.y) + 1);
          });
        });
        flashed.addAll(needToFlash);

        needToFlash.clear();
        grid.forEach((x, y) {
          final pos = Position(x, y);
          final cellValue = grid.getValueAt(x, y);
          if (cellValue >= 10 && !flashed.contains(pos)) needToFlash.add(pos);
        });
      } while (needToFlash.isNotEmpty);

      // Reset flashed octopuses
      int flashCount = 0;
      grid.forEach((x, y) {
        final cellValue = grid.getValueAt(x, y);
        if (cellValue >= 10) {
          flashCount++;
          grid.setValueAt(x, y, 0);
        }
      });
      if (flashCount == 100) allFlashes = true;
      step++;
    }

    grid.rows.forEach((row) {
      print(row.join(' '));
    });

    return step;
  }
}

void main(List<String> args) {
  Day11().printSolutions();
}