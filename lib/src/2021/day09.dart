import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day09 extends GenericDay {
  Day09() : super(2021, 9);

  @override
  Grid<int> parseInput() {
    return Grid(input.getPerLine().map((l) => l.split('').map((e) => int.parse(e)).toList()).toList());
  }

  @override
  int solvePart1() {
    final grid = parseInput();

    int sum = 0;
    grid.forEach((x, y) {
      final current = grid.getValueAt(x, y);
      if(grid.adjacent(x, y).every((a) => grid.getValueAt(a.x, a.y) > current)) {
        sum += current + 1;
      }
    });
    return sum;
  }

  @override
  int solvePart2() {
    final grid = parseInput();

    final List<Set<Position>> bassins = [];
    grid.forEach((x, y) {
      final value = grid.getValueAt(x, y);
      if (value < 9 && !bassins.any((b) => b.contains(Position(x,y)))) {
        final Set<Position> adjacents = {};
        Set<Position> newAdjacents = {Position(x,y)};
        while (newAdjacents.isNotEmpty) {
          final adjPoses = newAdjacents.map((e) => grid.adjacent(e.x, e.y)).expand((e) => e).toSet();
          adjacents.addAll(newAdjacents);
          newAdjacents = adjPoses.where((a) => grid.getValueAt(a.x, a.y) < 9 && !adjacents.contains(a)).toSet();
        }

        bassins.add(adjacents);
      }
    });
    final sorted = bassins.sorted((a, b) => -a.length.compareTo(b.length));
    return sorted.take(3).fold(1, (acc, b) => acc * b.length);
  }

    
}