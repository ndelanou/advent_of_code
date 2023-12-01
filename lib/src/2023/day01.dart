import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day01 extends GenericDay {
  Day01() : super(2023, 1);

  static const intStringMapping = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9,
  };

  @override
  List<(int first, int last)> parseInput() {
    final lines = input.getPerLine().map((e) {
      int? first;
      int? last;

      for (var i = 0; i < e.length; i++) {
        final intValue = int.tryParse(e[i]);
        if (intValue != null) {
          if (first == null) {
            first = intValue;
          }
          last = intValue;
        }
      }

      return (first!, last!);
    }).toList();

    return lines;
  }

  List<(int first, int last)> parseInputv2() {
    final lines = input.getPerLine().map((e) {
      int? first;
      int? last;

      for (var i = 0; i < e.length; i++) {
        int? intValue = int.tryParse(e[i]);
        if (intValue == null) {
          final subStr = e.substring(i);
          for (final strValue in intStringMapping.entries) {
            if (subStr.startsWith(strValue.key)) {
              intValue = strValue.value;
              break;
            }
          }
        }

        if (intValue != null) {
          if (first == null) {
            first = intValue;
          }
          last = intValue;
        }
      }

      return (first!, last!);
    }).toList();

    return lines;
  }

  @override
  int solvePart1() {
    final lines = parseInput();
    final combined = lines.map((e) => e.$1 * 10 + e.$2).toList();
    final sum = combined.sum;
    return sum;
  }

  @override
  int solvePart2() {
    final lines = parseInputv2();
    final combined = lines.map((e) => e.$1 * 10 + e.$2).toList();
    final sum = combined.sum;
    return sum;
  }
}

void main(List<String> args) {
  Day01().printSolutions();
}
