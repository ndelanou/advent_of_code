import '../utils/utils.dart';

class Day06 extends GenericDay {
  Day06() : super(2022, 6);

  @override
  String parseInput() {
    return input.asString;
  }

  @override
  solvePart1() {
    final message = parseInput();
    return findMessageKeyIndex(message, 4);
  }

  @override
  solvePart2() {
    final message = parseInput();
    return findMessageKeyIndex(message, 14);
  }

  int findMessageKeyIndex(String input, int keyLength) {
    for (var i = keyLength; i < input.length; i++) {
      final sub = input.substring(i - keyLength, i);

      if (isMessageKey(sub)) return i;
    }
    return -1;
  }

  // V1
  // bool isMessageKey(String input) {
  //   for (var j = 0; j < input.length; j++) {
  //     final char = input[j];
  //     if (input.indexOf(char) != input.lastIndexOf(char)) return false;
  //   }
  //   return true;
  // }

  // V2 : inspired from https://github.com/darrenaustin/advent-of-code-dart/blob/main/lib/src/2022/day06.dart
  bool isMessageKey(String input) {
    return input.codeUnits.toSet().length == input.length;
  }
}
