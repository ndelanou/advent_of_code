import '../utils/utils.dart';

typedef _Position = ({int x, int y});
typedef _Dimension = ({int w, int h});
typedef _Input = ({List<_Position> galaxies, _Dimension dimension});

class Day11 extends GenericDay {
  Day11() : super(2023, 11);

  @override
  _Input parseInput() {
    final lines = input.getPerLine();
    final galaxies = <_Position>[];

    for (var y = 0; y < lines.length; y++) {
      final line = lines[y];
      for (var x = 0; x < line.length; x++) {
        if (line[x] == '#') {
          galaxies.add((x: x, y: y));
        }
      }
    }
    return (galaxies: galaxies, dimension: (w: lines.first.length, h: lines.length));
  }

  List<_Position> expand(List<_Position> galaxies, _Dimension dimension, {int expansionRate = 1}) {
    final expandedR = <_Position>[];
    int emptyRowsCount = 0;
    for (var y = 0; y < dimension.h; y++) {
      final galaxiesInRow = galaxies.where((g) => g.y == y).toList();
      if (galaxiesInRow.isEmpty) {
        emptyRowsCount++;
      } else {
        expandedR.addAll(galaxiesInRow.map((e) => (x: e.x, y: y + emptyRowsCount * (expansionRate - 1))));
      }
    }

    final expandedC = <_Position>[];
    int emptyColumnsCount = 0;
    for (var x = 0; x < dimension.w; x++) {
      final galaxiesInColumns = expandedR.where((g) => g.x == x).toList();
      if (galaxiesInColumns.isEmpty) {
        emptyColumnsCount++;
      } else {
        expandedC.addAll(galaxiesInColumns.map((e) => (x: x + emptyColumnsCount * (expansionRate - 1), y: e.y)));
      }
    }

    return expandedC;
  }

  int distanceSum(List<_Position> galaxies) {
    int sum = 0;
    for (var i = 0; i < galaxies.length - 1; i++) {
      final galaxy = galaxies[i];
      for (var j = i + 1; j < galaxies.length; j++) {
        if (i == j) continue;
        final other = galaxies[j];
        sum += galaxy.dist(other);
      }
    }

    return sum;
  }

  @override
  int solvePart1() {
    final (:galaxies, :dimension) = parseInput();

    final expandedGalaxies = expand(galaxies, dimension);

    final distances = distanceSum(expandedGalaxies);

    return distances;
  }

  @override
  int solvePart2() {
    final (:galaxies, :dimension) = parseInput();

    final expandedGalaxies = expand(galaxies, dimension, expansionRate: 1000000);

    final distances = distanceSum(expandedGalaxies);

    return distances;
  }
}

extension _PosExt on _Position {
  int dist(_Position other) => (x - other.x).abs() + (y - other.y).abs();
}

void main() {
  Day11().printSolutions();
}
