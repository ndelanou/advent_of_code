import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day12 extends GenericDay {
  Day12() : super(2021, 12);

  @override
  List<Tuple2<String, String>> parseInput() {
    return input
        .getPerLine()
        .map(
          (l) => Tuple2<String, String>.fromList(l.split('-')),
        )
        .toList();
  }

  @override
  solvePart1() {
    final connections = parseInput();
    final validPaths = visitCave(connections);
    return validPaths.length;
  }

  @override
  solvePart2() {
    final connections = parseInput();
    final validPaths = visitCaveP2(connections);
    return validPaths.length;
  }

  Iterable<String> visitCave(List<Tuple2<String, String>> connections, [String cave = 'start', String currentPath = '']) {
    if (cave == 'end') return [currentPath + 'end'];

    final newPath = currentPath + cave + ',';
    final availableConnections = cavesFrom(cave, connections).where((t) => !t.startsWithLowercaseChar || !currentPath.contains(t));
    return availableConnections.map((c) => visitCave(connections, c, newPath)).expand((paths) => paths);
  }

  Iterable<String> visitCaveP2(List<Tuple2<String, String>> connections, [String cave = 'start', String currentPath = '', String? smallCaveVisitedTwice]) {
    if (cave == 'end') return [currentPath + 'end'];

    final currentSmallCaveVisitedTwice = smallCaveVisitedTwice ?? (cave.startsWithLowercaseChar && currentPath.contains(cave) ? cave : null);
    final newPath = currentPath + cave + ',';
    final availableConnections = cavesFrom(cave, connections).where((t) => !t.startsWithLowercaseChar || !currentPath.contains(t) || currentSmallCaveVisitedTwice == null);
    return availableConnections.map((c) => visitCaveP2(connections, c, newPath, currentSmallCaveVisitedTwice)).expand((paths) => paths);
  }

  Iterable<String> cavesFrom(String cave, List<Tuple2<String, String>> connections) sync* {
    for (var c in connections) {
      if (c.item1 == cave && c.item2 != 'start') yield c.item2;
      if (c.item2 == cave && c.item1 != 'start') yield c.item1;
    }
  }
}

final _a = 'a'.codeUnits.first;
final _z = 'z'.codeUnits.first;

extension StringExt on String {
  bool get startsWithLowercaseChar {
    final firstChar = codeUnits.first;
    return firstChar >= _a && firstChar <= _z;
  }
}
