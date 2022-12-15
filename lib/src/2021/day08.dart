import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day08 extends GenericDay {
  Day08() : super(2021, 8);

  @override
  List<List<List<String>>> parseInput() {
    return input.getPerLine().map((l) => l.split(' | ').map((e) => e.split(' ').toList()).toList()).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput();
    final outputs = lines.map((e) => e.last);

    final ones = outputs.map((e) => e.where((element) => element.length == 2).length).sum;
    final fours = outputs.map((e) => e.where((element) => element.length == 4).length).sum;
    final sevens = outputs.map((e) => e.where((element) => element.length == 3).length).sum;
    final eights = outputs.map((e) => e.where((element) => element.length == 7).length).sum;

    return ones + fours + sevens + eights;
  }

  @override
  int solvePart2() {
    final lines = parseInput();

    final sum = lines.map((l) {
      final mapping = getMapping(l.first);
      print(l.first);
      final output = l.last;
      return output.map((e) {
        print(e);
        return mapping[mapping.keys.firstWhere((key) => key.length == e.length && e.split('').every((c) => key.contains(c)))]!;
      })
      .fold(0, (acc, element) => acc * 10 + element);
    }).sum;

    return sum;
  }

  Map<String, int> getMapping(List<String> input) {
    final one = input.firstWhere((element) => element.length == 2);
    final four = input.firstWhere((element) => element.length == 4);
    final seven = input.firstWhere((element) => element.length == 3);
    final eight = input.firstWhere((element) => element.length == 7);

    final topChar = seven.split('').firstWhere((c) => !one.contains(c));

    final nine = input.where((i) => i.length == 6).firstWhere((i) {
      return i
        .split('')
        .where((c) {
          return !(four + topChar).contains(c);
        })
        .length == 1;
    });

    final bottomLeftChar = 'abcdefg'.split('').firstWhere((c) => !nine.contains(c));
    final five = input.firstWhere((i) => i.length == 5 && input.any((element) => element.length == 6 && (i + bottomLeftChar).split('').every((c) => element.contains(c))));
    final six = five + bottomLeftChar;
    final zero = input.firstWhere((i) => i.length == 6 && !i.split('').every((c) => six.contains(c)) && !i.split('').every((c) => nine.contains(c)));
    final three = input.firstWhere((i) => i.length == 5 && one.split('').every((c) => i.contains(c)));
    final two = input.firstWhere((i) => i.length == 5 && i != three && i != five);

    return {
      zero: 0,
      one: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9,
    };
  }
    
}

void main(List<String> args) {
  Day08().printSolutions();
}