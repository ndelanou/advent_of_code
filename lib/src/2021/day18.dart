import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';

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

    return result.magnitude;
  }

  @override
  solvePart2() {
    final lines = parseInput();
    int maxMagnitude = 0;
    for (final left in lines) {
      for (final right in lines) {
        if (right == left) continue;
        maxMagnitude = max(maxMagnitude, add(left.deepCopy, right.deepCopy).magnitude);
      }
    }

    return maxMagnitude; // 4485+
  }

  List add(List left, List right) {
    final added = <dynamic>[left, right];
    return reduce(added);
  }

  List reduce(List list) {
    List current = list.toList();
    while (true) {
      final exploded = explode(current);
      if (exploded != null) {
        current = exploded;
        continue;
      }

      final splitted = split(current);
      if (splitted != null) {
        current = splitted;
        continue;
      }

      break;
    }
    return current;
  }

  List getCurrentElement(List tree, List<int> indices) {
    List currentList = tree;
    for (var i = 0; i < indices.length; i++) {
      currentList = currentList[indices[i]];
    }

    return currentList;
  }

  void setCurrentItem(List tree, List<int> indices, dynamic newValue) {
    List currentList = tree;
    for (var i = 0; i < indices.length - 1; i++) {
      currentList = currentList[indices[i]];
    }

    currentList[indices.last] = newValue;
  }

  int indexHash(List<int> indexArray) {
    return indexArray.length * 10000000 + indexArray.foldIndexed(0, (index, previous, element) => previous + (element << index));
  }

  List<(List<int> indices, dynamic element)> getIndexedElements(List tree) {
    final tmp = <(List<int> indices, dynamic element)>[];
    var prevIndices = <int>[];
    final indices = <int>[];
    final visitedIndexeHashs = <int>{};

    do {
      prevIndices = indices.toList();
      final current = getCurrentElement(tree, indices);
      final currentHash = indexHash(indices);
      if (!visitedIndexeHashs.contains(currentHash)) {
        tmp.add((indices.toList(), current));
        visitedIndexeHashs.add(indexHash(indices));
      }

      final leftChildVisisted = visitedIndexeHashs.contains(indexHash([...indices, 0]));
      if (!leftChildVisisted) {
        if (current[0] is int) {
          tmp.add(([...indices, 0], current[0]));
          visitedIndexeHashs.add(indexHash([...indices, 0]));
        } else {
          indices.add(0);
          continue;
        }
      }

      final rightChildVisisted = visitedIndexeHashs.contains(indexHash([...indices, 1]));
      if (!rightChildVisisted) {
        if (current[1] is int) {
          tmp.add(([...indices, 1], current[1]));
          visitedIndexeHashs.add(indexHash([...indices, 1]));
        } else {
          indices.add(1);
          continue;
        }
      }

      if (indices.isNotEmpty) indices.removeLast();
    } while (indices.isNotEmpty || prevIndices.isNotEmpty);

    return tmp;
  }

  List? explode(List tree) {
    final indexedElements = getIndexedElements(tree);
    final explodedElement = indexedElements.firstWhereOrNull((element) => element.$1.length >= 4 && element.$2 is List);
    if (explodedElement == null) return null;
    final explodedElementIndex = indexedElements.indexOf(explodedElement);

    // Explode current item
    setCurrentItem(tree, explodedElement.$1, 0);

    // Explode left
    for (var i = explodedElementIndex - 1; i >= 0; i--) {
      final left = indexedElements[i];
      if (left.$2 is int) {
        setCurrentItem(tree, left.$1, left.$2 + (explodedElement.$2 as List)[0]);
        break;
      }
    }

    // Explode right
    for (var i = explodedElementIndex + 3; i < indexedElements.length; i++) {
      final right = indexedElements[i];
      if (right.$2 is int) {
        setCurrentItem(tree, right.$1, right.$2 + (explodedElement.$2 as List)[1]);
        break;
      }
    }

    return tree;
  }

  List? split(List tree) {
    final indexedElements = getIndexedElements(tree);
    final splittedElement = indexedElements.firstWhereOrNull((element) => element.$2 is int && element.$2 >= 10);
    if (splittedElement == null) return null;

    setCurrentItem(tree, splittedElement.$1, <dynamic>[((splittedElement.$2 as int) / 2).floor(), ((splittedElement.$2 as int) / 2).ceil()]);

    return tree;
  }
}

extension on List {
  int get magnitude {
    return 3 * (this.first is int ? this.first as int : (this.first as List).magnitude) + 2 * (this.last is int ? this.last as int : (this.last as List).magnitude);
  }

  List get deepCopy {
    return this.map((e) => e is List ? e.deepCopy : e).toList();
  }
}

void main(List<String> args) {
  Day18().printSolutions();
}
