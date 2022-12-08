import 'dart:math';

import '../utils/utils.dart';

class Day08 extends GenericDay {
  Day08() : super(2022, 8);

  @override
  List<List<int>> parseInput() {
    final lines = input.getPerLine();
    return lines
        .map((l) => l.split('').map((s) => int.parse(s)).toList())
        .toList();
  }

  @override
  solvePart1() {
    final trees = parseInput();
    int sum = 0;
    for (var i = 0; i < trees.length; i++) {
      for (var j = 0; j < trees[i].length; j++) {
        final tree = trees[i][j];
        if (i == 0 ||
            i == trees.length - 1 ||
            j == 0 ||
            j == trees[i].length - 1) {
          sum++;
          continue;
        }
        final clearL = trees[i].sublist(0, j).every((s) => tree > s);
        final clearR =
            trees[i].sublist(j + 1, trees[i].length).every((s) => tree > s);

        final clearT = trees
            .map((r) => r[j])
            .toList()
            .sublist(0, i)
            .every((s) => tree > s);
        final clearB = trees
            .map((r) => r[j])
            .toList()
            .sublist(i + 1, trees.length)
            .every((s) => tree > s);

        if (clearL || clearR || clearT || clearB) {
          sum++;
        }
      }
    }

    return sum;
  }

  @override
  solvePart2() {
    final trees = parseInput();
    int maxScore = 0;
    for (var i = 0; i < trees.length; i++) {
      for (var j = 0; j < trees[i].length; j++) {
        final tree = trees[i][j];

        final left = trees[i].sublist(0, j).reversed.toList();
        final right = trees[i].sublist(j + 1, trees[i].length);
        final top =
            trees.map((r) => r[j]).toList().sublist(0, i).reversed.toList();
        final bottom =
            trees.map((r) => r[j]).toList().sublist(i + 1, trees.length);

        int leftScore = nbUnderSize(left, tree);
        int rightScore = nbUnderSize(right, tree);
        int topScore = nbUnderSize(top, tree);
        int bottomScore = nbUnderSize(bottom, tree);

        int score = safeFromZero(leftScore) *
            safeFromZero(rightScore) *
            safeFromZero(topScore) *
            safeFromZero(bottomScore);

        maxScore = max(maxScore, score);
      }
    }
    return maxScore;
  }

  nbUnderSize(List<int> list, int size) {
    if (list.length == 0) return 1;
    final index = list.indexWhere((t) => t >= size);
    if (index == -1) return list.length;
    if (index == 0) return 1;
    return index + 1;
  }

  int safeFromZero(int input) {
    if (input == 0)
      return 1;
    else
      return input;
  }
}

