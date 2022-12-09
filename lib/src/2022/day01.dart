import 'dart:math';

import 'package:advent_of_code/src/utils/utils.dart';

class Day01 extends GenericDay {
  Day01() : super(2022, 1);

  @override
  Iterable<int> parseInput() {
    final lines = input.asString;
    final elfs = lines.split('\n\n');

    final elfsCals = elfs.map(
      (e) => e
          .split('\n')
          .map((calStr) => int.parse(calStr))
          .fold(0, (acc, cal) => acc + cal),
    );

    return elfsCals;
  }

  @override
  solvePart1() {
    return parseInput().reduce(max);
  }

  @override
  solvePart2() {
    final sortedCals = (parseInput().toList()..sort()).reversed.toList();
    final top3Sum = sortedCals[0] + sortedCals[1] + sortedCals[2];
    return top3Sum;  
  }

}