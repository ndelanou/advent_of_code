import '../utils/utils.dart';

class Day02 extends GenericDay {
  Day02() : super(2021, 2);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  solvePart1() {
    final lines = parseInput();

    int x = 0, y = 0;

    lines.forEach((element) {
      final splits = element.split(' ');
      final amount = int.parse(splits[1]);
      final instruction = splits[0];
      if (instruction == 'forward') x += amount;
      if (instruction == 'down') y += amount;
      if (instruction == 'up') y -= amount;
    });
    
    return x * y;
  }

  @override
  solvePart2() {
    final lines = parseInput();
    
    int x = 0;
    int aim = 0, z = 0;

    lines.forEach((element) {
      final splits = element.split(' ');
      final amount = int.parse(splits[1]);
      final instruction = splits[0];
      if (instruction == 'forward') {
        x += amount;
        z += aim * amount;
      }
      if (instruction == 'down') aim += amount;
      if (instruction == 'up') aim -= amount;
    });
    
    return x * z;
  }
}
