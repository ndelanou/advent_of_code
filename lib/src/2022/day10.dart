import '../utils/utils.dart';

class Day10 extends GenericDay {
  Day10() : super(2022, 10);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final instructions = parseInput();

    int cycle = 0;
    int instructionIndex = 0;
    int busy = 0;
    int register = 1;

    final captureCycles = [20, 60, 100, 140, 180, 220];
    int captureSum = 0;

    while(instructionIndex < instructions.length) {
      if (busy == 0) {
        final instruction = instructions[instructionIndex];
        if(instruction == 'noop') {
          busy = 1;
        } else {
          final addValue = int.parse(instruction.split(' ').last);
          register += addValue;
          busy = 2;
        }
        instructionIndex++;
      }

      cycle++;
      busy--;
      if (captureCycles.contains(cycle + 2)) {
        captureSum += register * (cycle + 2);
      };
    }

    return captureSum;
  }

  @override
  int solvePart2() {
    final instructions = parseInput();

    int cycle = 0;
    int instructionIndex = 0;
    int busy = 0;
    int register = 1;

    int increment = 0;

    List<String> pixels = [];

    while(instructionIndex < instructions.length) {

      if (busy == 0) {
        register += increment;
        increment = 0;
      }

      int pixelIndex = ((cycle) % 40);
      if (pixelIndex >= register-1 && pixelIndex <= register+1) {
        pixels.add('#');
      } else {
        pixels.add('.');
      }

      if (busy == 0) {
        final instruction = instructions[instructionIndex];
        if(instruction == 'noop') {
          busy = 1;
        } else {
          final addValue = int.parse(instruction.split(' ').last);
          increment = addValue;
          busy = 2;
        }
        instructionIndex++;
      }

      cycle++;  
      busy--;
    }

    for (var i = 0; i < pixels.length; i+=40) {
      print(pixels.skip(i).take(40).join());
    }

    return 0;
  }
}