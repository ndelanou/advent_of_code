import 'package:advent_of_code/src/utils/pathfinding/dijkstra.dart';

import '../utils/utils.dart';

class Day15 extends GenericDay {
  Day15() : super(2021, 15);

  @override
  Grid<int> parseInput() {
    final lines = input.getPerLine();
    final gridData = lines.map((l) => l.split('').map((c) => int.parse(c)).toList()).toList();
    return Grid(gridData);
  }

  @override
  solvePart1() {
    final grid = parseInput();
    final graph = <Position, List<(Position, int)>>{};
    grid.forEach((x, y) {
      final neighbours = grid.adjacent(x, y);
      final graphValues = neighbours.map((n) => (n, grid.getValueAtPosition(n))).toList();
      graph[Position(x, y)] = graphValues;
    });
    final bestPath = Dijkstra.findPathFromGraph(graph, start: Position(0, 0), end: Position(grid.width - 1, grid.height - 1));
    return bestPath.$2;
  }

  @override
  solvePart2() {
    final grid = buildGridPart2();
    final graph = <Position, List<(Position, int)>>{};
    grid.forEach((x, y) {
      final neighbours = grid.adjacent(x, y);
      final graphValues = neighbours.map((n) => (n, grid.getValueAtPosition(n))).toList();
      graph[Position(x, y)] = graphValues;
    });
    final bestPath = Dijkstra.findPathFromGraph(graph, start: Position(0, 0), end: Position(grid.width - 1, grid.height - 1));
    return bestPath.$2;
  }

  Grid<int> buildGridPart2() {
    final lines = input.getPerLine();
    final origin = lines.map((l) => l.split('').map((c) => int.parse(c)).toList()).toList();
    final expandedW = origin.map((l) => [...l, ...l.map((n) => n + 1), ...l.map((n) => n + 2), ...l.map((n) => n + 3), ...l.map((n) => n + 4)]).toList();
    final expandedH = [
      ...expandedW,
      ...expandedW.map((n) => n.map((nn) => nn + 1)),
      ...expandedW.map((n) => n.map((nn) => nn + 2)),
      ...expandedW.map((n) => n.map((nn) => nn + 3)),
      ...expandedW.map((n) => n.map((nn) => nn + 4)),
    ];
    final normalized = expandedH
        .map((l) => l.map((n) {
              if (n > 9)
                return n - 9;
              else
                return n;
            }).toList())
        .toList();
    return Grid(normalized);
  }
}

void main(List<String> args) {
  Day15().printSolutions();
}
