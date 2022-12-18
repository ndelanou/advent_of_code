import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day09 extends GenericDay {
  Day09() : super(2021, 10);

  @override
  Iterable<List<String>> parseInput() {
    return input.getPerLine().map((e) => e.split(''));
  }

  final chars = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
  };

  final charPoints = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
  };

  final missingCharPoints = {
    ')': 1,
    ']': 2,
    '}': 3,
    '>': 4,
  };

  @override
  int solvePart1() {
    final lines = parseInput();
    final score = lines.map((l) => corruptedChar(l)).whereNotNull().map((c) => charPoints[c]!).sum;
    return score;
  }

  String? corruptedChar(List<String> line) {
    final stack = <String>[];
    for (var char in line) {
      if (chars.keys.contains(char)) {
        stack.add(char);
      } else {
        if (chars[stack.last] == char) {
          stack.removeLast();
        } else {
          return char;
        }
      }
    }

    return null;
  }

  List<String> missingsChars(List<String> line) {
    final stack = <String>[];
    for (var char in line) {
      if (chars.keys.contains(char)) {
        stack.add(char);
      } else {
        if (chars[stack.last] == char) {
          stack.removeLast();
        } else {
          throw '?';
        }
      }
    }
    return stack.map((c) => chars[c]!).toList();
  }

  int missingCharsScore(List<String> chars) {
    return chars.fold(0, (acc, c) => acc * 5 + missingCharPoints[c]!);
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    final completeLines = lines.where((l) => corruptedChar(l) == null);
    final missingChars = completeLines.map((l) => missingsChars(l).reversed.toList());
    final scores = missingChars.map((mc) => missingCharsScore(mc)).sorted((a, b) => a.compareTo(b)).toList();
    return scores[scores.length ~/ 2];
  }

}

void main(List<String> args) {
  Day09().printSolutions();
}