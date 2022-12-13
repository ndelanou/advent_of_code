import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day13 extends GenericDay {
  Day13() : super(2022, 13);

  @override
  List<List<List<dynamic>>> parseInput() {
    final lines = input.getPerLine();

    final List<List<List<dynamic>>> pairs = [];
    for (var i = 0; i < lines.length; i = i+3) {
      pairs.add([jsonDecode(lines[i]), jsonDecode(lines[i+1])]);
    }

    return pairs;
  }

  bool? compareList(List<dynamic> left, List<dynamic> right) {
    final minLength = min(left.length, right.length);
    for (var i = 0; i < minLength; i++) {
      dynamic l = left[i];
      dynamic r = right[i];

      if (l is int && r is int) {
        if (l == r) continue;
        return l < r;
      } else {
        final lList = l is List ? l : [l];
        final rList = r is List ? r : [r];
        final res = compareList(lList, rList);
        if (res == null) continue;
        return res;
      }
    }

    if (left.length == right.length) return null;
    return left.length < right.length;
  }

  @override
  int solvePart1() {
    final pairs = parseInput();

    final pairsInRightOrder = <int>[];
    for (var i = 0; i < pairs.length; i++) {
      final pair = pairs[i];

      final result = compareList(pair.first, pair.last);

      if (result ?? true) pairsInRightOrder.add(i); // 5013
    }

    // 5546+
    return pairsInRightOrder.fold(0, (previousValue, element) => previousValue + element + 1); 
  }

  @override
  int solvePart2() {
    final all = parseInput().expand((element) => element).toList();
    final sep1 = [[2]];
    final sep2 = [[6]];
    all.addAll([sep1, sep2]);

    final sorted = all.sorted((a, b) {
      final res = compareList(a, b);
      if (res == null) return 0;
      return res ? -1 : 1;
    });

    final sep1Index = sorted.indexWhere((element) => element == sep1) + 1;
    final sep2Index = sorted.indexWhere((element) => element == sep2) + 1;

    return sep1Index * sep2Index; // 25038
  }
}