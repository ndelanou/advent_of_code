import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day25 extends GenericDay {
  Day25() : super(2022, 25);

  final chars = ['='.codeUnits.first, '-'.codeUnits.first, '0'.codeUnits.first, '1'.codeUnits.first, '2'.codeUnits.first,];

  @override
  List<List<int>> parseInput() {
    return input.getPerLine().map((l) => l.codeUnits.reversed.toList()).toList();
  }

  @override
  String solvePart1() {
    final lines = parseInput();
    final results = lines.map((l) => parseSnafu(l)).toList();
    final resultSum = results.sum;
    return toSnafu(resultSum);
  }

  int parseSnafu(List<int> line) {
    num tmp = 0;
    for (var i = 0; i < line.length; i++) {
      tmp += (chars.indexOf(line[i]) - 2) * pow(5, i);
    }
    return tmp.toInt();
  }

  String toSnafu(int value) {
    int base = 5;
    int tmp = value;
    int maxDiv = 0;
    while (tmp > 0) {
      tmp = tmp ~/ base;
      maxDiv++;
    }

    final arr = [];
    for (var i = 0; i < maxDiv; i++) {
      arr.add((value ~/ pow(base, i)) % base);
    }

    int ret = 0;
    for (var i = 0; i < arr.length; i++) {
      arr[i] += ret;
      if (arr[i] > 2) {
        arr[i] -= base;
        ret = 1;
      } else {
        ret = 0;
      }
    }
    if (ret > 0) {
      arr.add(ret);
    }

    return String.fromCharCodes(arr.reversed.map((e) => chars[e + 2]).toList());
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    return lines.length;
  }
}

