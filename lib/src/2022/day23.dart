import 'dart:math';

import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day23 extends GenericDay {
  Day23() : super(2022, 23);

  @override
  Grid<_Elf?> parseInput() {
    return Grid(input.getPerLine().map((l) => l.split('').map((c) => c == '#' ? _Elf() : null).toList()).toList());
  }

  @override
  int solvePart1() {
    final grid = parseInput();

    final elfs = grid.rows.map((r) => r.where((e) => e != null).whereNotNull()).expand((element) => element).toList();
    // grid.rows.forEach((r) { print(r.map((e) => e == null ? '.' : '#').join()); });
    
    for (var i = 0; i < 10; i++) {
      final startingDirectionIndex = i % ScanDirection.values.length;

      grid.forEach((x, y) {
        final elf = grid.getValueAt(x, y);
        if (elf != null) {
          elf.evaluateDirection(grid, x, y, startingDirectionIndex);
        }
      });

      grid.forEach((x, y) {
        final elf = grid.getValueAt(x, y);
        if (elf != null) {
          if (elf.proposedPosition != null && elfs.where((e) => e.proposedPosition == elf.proposedPosition).length <= 1) {
            grid.setValueAt(x, y, null);
            grid.setValueAtPosition(elf.proposedPosition!, elf);
          }
        }
      });

      // print('======== ${i + 1}');
      // grid.rows.forEach((r) { print(r.map((e) => e == null ? '.' : '#').join()); });
    }

    int minX = grid.width, maxX = 0;
    int minY = grid.height, maxY = 0;

    grid.forEach((x, y) {
      if (grid.getValueAt(x, y) != null) {
        minX = min(minX, x);
        maxX = max(maxX, x);
        minY = min(minY, y);
        maxY = max(maxY, y);
      }
    });

    int count = 0;
    grid.forEach((x, y) { 
      if (x >= minX && x <= maxX && y >= minY && y <= maxY) {
        if (grid.getValueAt(x, y) == null) count++;
      }
    });

    return count; // 2557
  }

  @override
  int solvePart2() {
    final grid = parseInput();

    final elfs = grid.rows.map((r) => r.where((e) => e != null).whereNotNull()).expand((element) => element).toList();
    // grid.rows.forEach((r) { print(r.map((e) => e == null ? '.' : '#').join()); });
    
    for (var i = 0; i < 100000; i++) {
      final startingDirectionIndex = i % ScanDirection.values.length;

      grid.forEach((x, y) {
        final elf = grid.getValueAt(x, y);
        if (elf != null) {
          elf.evaluateDirection(grid, x, y, startingDirectionIndex);
        }
      });

      grid.forEach((x, y) {
        final elf = grid.getValueAt(x, y);
        if (elf != null) {
          if (elf.proposedPosition != null && elfs.where((e) => e.proposedPosition == elf.proposedPosition).length <= 1) {
            grid.setValueAt(x, y, null);
            grid.setValueAtPosition(elf.proposedPosition!, elf);
          }
        }
      });

      if (i % 10 == 0) {
        // print('======== ${i + 1}');
        // grid.rows.forEach((r) { print(r.map((e) => e == null ? '.' : '#').join()); }); 
      }

      if (elfs.every((e) => e.proposedPosition == null)) {
        return i + 1;
      }
    }

    throw 'Should not happend';
  }
}

class _Elf {
  @override
  String toString() => '#';

  Position? proposedPosition;

  evaluateDirection(Grid<_Elf?> grid, int x, int y, int startingDirectionIndex) {
    final moves = _scanDirections(startingDirectionIndex).map((d) => grid.adjacentOnDirection(x, y, d)).where((ms) => ms.isNotEmpty);
    final moveDirection = moves.where((m) => m.every((p) => grid.isOnGrid(p) && grid.getValueAtPosition(p) == null));

    // No possible move or all possible moves
    if (moveDirection.isEmpty || moveDirection.length == moves.length) {
      proposedPosition = null;
    } else {
      proposedPosition = moveDirection.first.first;
    }
  }

  Iterable<ScanDirection> _scanDirections(int fromIndex) sync* {
    for (var i = 0; i < ScanDirection.values.length; i++) {
      yield ScanDirection.values[(i + fromIndex) % ScanDirection.values.length];
    }
  }
}

enum ScanDirection { north, south, west, east }

extension GridExt on Grid {
  Iterable<Position> adjacentOnDirection(int x,  int y, ScanDirection direction) {

    final List<Position> positions;
    switch (direction) {
      case ScanDirection.north:
        positions = [
          Position(x, y - 1),
          Position(x + 1, y - 1),
          Position(x - 1, y - 1),
        ];
        break;
      case ScanDirection.south:
        positions = [
          Position(x, y + 1),
          Position(x + 1, y + 1),
          Position(x - 1, y + 1),
        ];
        break;
      case ScanDirection.west:
        positions = [
          Position(x - 1, y),
          Position(x - 1, y - 1),
          Position(x - 1, y + 1),
        ];
        break;
      case ScanDirection.east:
        positions = [
          Position(x + 1, y),
          Position(x + 1, y + 1),
          Position(x + 1, y - 1),
        ];
        break;
      
    }
    
    return positions.where(
        (pos) => pos.x >= 0 && pos.y >= 0 && pos.x < width && pos.y <= height);

  }
}