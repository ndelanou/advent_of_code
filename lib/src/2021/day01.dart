import '../utils/utils.dart';

class Day01 extends GenericDay {
  Day01() : super(2021, 1);

  @override
  List<int> parseInput() {
    return input.getPerLine().map((l) => int.parse(l)).toList();
  }

  @override
  solvePart1() {
    final values = parseInput();

    int increaseCount = 0;
    for (var i = 0; i < values.length; i++) {
      if (i == 0) continue;
      if (values[i] > values[i-1]) increaseCount++;
    }
    
    return increaseCount;
  }

  @override
  solvePart2() {
    final values = parseInput();
    
    int slidingIncreaseCount = 0;
    for (var i = 0; i < values.length - 3; i++) {
      final s1 = values[i] + values[i + 1] + values[i + 2];
      final s2 = values[i + 1] + values[i + 2] + values[i + 3];
      if (s2 > s1) slidingIncreaseCount++;
    }
    
    return slidingIncreaseCount;
  }
}
