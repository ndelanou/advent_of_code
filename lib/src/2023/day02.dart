import 'dart:math';

import 'package:collection/collection.dart';

import '../utils/utils.dart';

typedef SetOfCubes = Map<String, int>;

class Day02 extends GenericDay {
  Day02() : super(2023, 2);

  @override
  List<List<SetOfCubes>> parseInput() {
    final lines = input.getPerLine();
    final games = lines
        .map(
          (l) => l
              .split(':')
              .last
              .trim()
              .split(';')
              .map(
                (g) => g.split(',').fold(<String, int>{}, (previousValue, element) {
                  final splits = element.trim().split(' ');
                  final count = int.parse(splits.first);
                  final color = splits.last;
                  previousValue[color] = count;
                  return previousValue;
                }),
              )
              .toList(),
        )
        .toList();
    return games;
  }

  @override
  int solvePart1() {
    final lines = parseInput();

    const maxCubes = {'red': 12, 'green': 13, 'blue': 14};
    int sumOfIds = 0;

    for (int i = 0; i < lines.length; i++) {
      final game = lines[i];

      if (game.every((setOfCubes) => isPossibleGame(setOfCubes, maxCubes))) {
        print('possibe game: ${i + 1}');
        sumOfIds += i + 1;
      }
    }

    return sumOfIds;
  }

  bool isPossibleGame(SetOfCubes setOfCubes, SetOfCubes maxCubes) {
    for (final color in setOfCubes.keys) {
      if (setOfCubes[color]! > maxCubes[color]!) {
        return false;
      }
    }
    return true;
  }

  @override
  int solvePart2() {
    final lines = parseInput();

    final minSetsOfCubes = lines.map((game) {
      return game.fold(SetOfCubes(), (previousValue, element) {
        for (final entry in element.entries) {
          if (previousValue.containsKey(entry.key)) {
            previousValue[entry.key] = max(previousValue[entry.key]!, entry.value);
          } else {
            previousValue[entry.key] = entry.value;
          }
        }
        return previousValue;
      });
    }).toList();

    final squares = minSetsOfCubes.map((e) => e.values.fold(1, (previousValue, element) => previousValue * element)).toList();

    final sum = squares.sum;

    return sum;
  }
}

void main(List<String> args) {
  Day02().printSolutions();
}
