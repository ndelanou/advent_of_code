import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day20 extends GenericDay {
  Day20() : super(2022, 20);

  @override
  List<int> parseInput() {
    return input.getPerLine().map((l) => int.parse(l)).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput().mapIndexed((i, e) => Tuple2(e, i)).toList();
    final mixed = mix(lines.toList());

    final coord = computeCoord(mixed.map((e) => e.item1).toList());
    return coord;
  }

  static const decriptionKey = 811589153;

  @override
  int solvePart2() {
    final lines = parseInput().mapIndexed((i, e) => Tuple2(decriptionKey * e, i)).toList();
    List<Tuple2<int, int>> mixed = lines.toList();
    for (var i = 0; i < 10; i++) {
      mixed = mix(mixed);
    }

    final coord = computeCoord(mixed.map((e) => e.item1).toList());
    return coord;
  }

  int computeCoord(List<int> list) {
    final zeroIndex = list.indexWhere((i) => i == 0);
    final coord = list[(zeroIndex + 1000) % list.length] + list[(zeroIndex + 2000) % list.length] + list[(zeroIndex + 3000) % list.length];
    return coord;
  }

  List<Tuple2<int, int>> mix(List<Tuple2<int, int>> list) {
    for (var i = 0; i < list.length; i++) {
      final index = list.indexWhere((e) => e.item2 == i);
      final value = list[index];

      list.removeAt(index);
      int newIndex = (index + value.item1) % (list.length);
      if (index != 0 && newIndex == 0) newIndex = list.length ;
      list.insert(newIndex, value);
    }

    return list;
  }
}
