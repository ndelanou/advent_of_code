
import 'dart:math';

import '../utils/utils.dart';

class Day03 extends GenericDay {
  Day03() : super(2021, 3);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  solvePart1() {
    final lines = parseInput();

    var mostCommons = <int>[];
    var leastCommons = <int>[];

    for (var i = 0; i < lines.first.length; i++) {
      mostCommons.add(mostCommonAtIndex(lines, i));
      leastCommons.add(mostCommonAtIndex(lines, i) == 0 ? 1 : 0);
    }

    final mostCommonNb = intFromBinArray(mostCommons);
    final leastCommonNb = intFromBinArray(leastCommons);

    return mostCommonNb*leastCommonNb;
  }

  @override
  solvePart2() {
    final lines = parseInput();
    
    List<int>? o2;
    List<int>? co2;

    var tmp1 = lines.toList();
    var tmp2 = lines.toList();
    for (var i = 0; i < lines.first.length; i++) {
      
      if (tmp1.length > 1) {
        final criteria = mostCommonAtIndex(tmp1, i) == 0 ? '0' : '1';
        tmp1 = sublistFromCreteria(tmp1, i, criteria);

        if (tmp1.length == 1) o2 = tmp1.first.split('').map((e) => int.parse(e)).toList();
      }

      if (tmp2.length > 1) {
        final criteria = mostCommonAtIndex(tmp2, i) == 0 ? '1' : '0';
        tmp2 = sublistFromCreteria(tmp2, i, criteria);

        if (tmp2.length == 1) co2 = tmp2.first.split('').map((e) => int.parse(e)).toList();
      }

    }
    final o2Nb = intFromBinArray(o2!);
    final co2Nb = intFromBinArray(co2!);
    return o2Nb * co2Nb;
  }


  int mostCommonAtIndex(List<String> input, int index) {
    var count = 0;
    for (var line in input) {
      if (line[index] == '1') count++;
    }
    return count >= (input.length / 2) ? 1 : 0;
  }

  int intFromBinArray(List<int> input) {
    int acc = 0;
    for (var i = 0; i < input.length; i++) {
      if (input[i] == 1) acc += pow(2, input.length - i - 1).toInt();
    }

    return acc;
  }

  List<String> sublistFromCreteria(List<String> input, int index, String criteria) {
    return input.where((l) => l[index] == criteria).toList();
  }

}
