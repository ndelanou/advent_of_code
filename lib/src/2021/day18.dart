import 'dart:convert';

import '../utils/utils.dart';

class Day18 extends GenericDay {
  Day18() : super(2021, 18);

  @override
  List<List> parseInput() {
    final lines = input.getPerLine();
    final parsed = lines.map((l) => json.decode(l) as List).toList();
    return parsed;
  }

  @override
  solvePart1() {
    final lines = parseInput();
    final result = lines.reduce((value, element) => add(value, element));
    print(result);
    return result.magnitude;
  }

  @override
  solvePart2() {}

  List add(List left, List right) {
    final added = [left, right];
    return reduce(added);
  }

  List reduce(List list) {
    List current = list.toList();
    while (true) {
      break;
    }
    return current;
  }

  List explode(List list, List<int> indexes) {
    List tmp = list;
    List parent = tmp;
    for (var i = 0; i < indexes.length; i++) {
      parent = tmp;
      tmp = tmp[indexes[i]];
    }
    final save = tmp;
    parent[indexes.last] = 0;
    return list;
  }

  // List splits(List list, List<int> indexes) {}
}

class LinkedList<T> {}

extension on List {
  int get magnitude {
    return 3 * (this.first is int ? this.first as int : (this.first as List).magnitude) + 2 * (this.last is int ? this.last as int : (this.last as List).magnitude);
  }
}

void main(List<String> args) {
  Day18().printSolutions();
}
