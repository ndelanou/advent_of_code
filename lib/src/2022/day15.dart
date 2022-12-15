import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day15 extends GenericDay {
  Day15() : super(2022, 15);

  @override
  List<Tuple2<Position, Position>> parseInput() {

    return input.getPerLine().map((l) {
      final splits = l.split(' ');
      final sX = int.parse(splits[2].substring(2, splits[2].length - 1));
      final sY = int.parse(splits[3].substring(2, splits[3].length - 1));
      final bX = int.parse(splits[8].substring(2, splits[8].length - 1));
      final bY = int.parse(splits[9].substring(2, splits[9].length));
      return Tuple2(Position(sX, sY), Position(bX, bY));
    }).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput();

    final testY = 2000000;
    int count = 0;
    final minX = lines.map((l) => l.item1.x - dist(l.item1, l.item2)).min;
    final maxX = lines.map((l) => l.item1.x + dist(l.item1, l.item2)).max;
    for (var i = minX - 2; i < maxX + 2; i++) {
      final pos = Position(i, testY);
      final isCovered = lines.any((l) {
        final currentDist = dist(pos, l.item1);
        final beaconDist = dist(l.item1, l.item2);
        return beaconDist >= currentDist;
      });
      if (isCovered) {
        count++;
      }
    }
    final nbBeaconOnLine = lines.map((e) => e.item2).where((b) => b.y == testY).toSet().length;
    return count - nbBeaconOnLine; 
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    final ranges = lines.map((l) => Tuple2(l.item1, dist(l.item1, l.item2)));
    List<Position> matchs = [];
    final maxLinesWidth = 4000000;
    for (var y = 0; y < maxLinesWidth; y++) {
      for (var x = 0; x < maxLinesWidth; x++) {
        final pos = Position(x, y);
        final range = ranges.firstWhereOrNull((l) {
          final currentDist = dist(pos, l.item1);
          return l.item2 >= currentDist;
        });
        if (range == null) {
          matchs.add(pos);
          return matchs.first.x * 4000000 + matchs.first.y; 
        } else {
          x = range.item1.x + range.item2 - (range.item1.y - pos.y).abs();
        }
      }
    }

    throw 'Solution not found';
  }
}

int dist(Position a, Position b) {
  return (a.x - b.x).abs() + (a.y - b.y).abs(); 
}