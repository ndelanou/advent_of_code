import '../utils/utils.dart';

enum _Instruction { left, right }

class Day08 extends GenericDay {
  Day08() : super(2023, 8);

  @override
  ({List<_Instruction> instructions, Map<String, Map<_Instruction, String>> directions}) parseInput() {
    final lines = input.getPerLine();

    final instructions = lines.first.split('').map((e) => e == 'L' ? _Instruction.left : _Instruction.right).toList();

    final directions = Map.fromEntries(lines.skip(2).map((l) {
      final parts = l.replaceAll(RegExp('[^A-Z1-9]'), ' ').replaceAll(RegExp(r'(\s+)'), ' ').split(' ');
      return MapEntry(parts.first, <_Instruction, String>{_Instruction.left: parts[1], _Instruction.right: parts[2]});
    }));

    return (instructions: instructions, directions: directions);
  }

  @override
  int solvePart1() {
    final input = parseInput();

    int step = 0;
    String current = 'AAA';

    do {
      final relativeInstructionIndex = step % input.instructions.length;
      final direction = input.instructions[relativeInstructionIndex];
      current = input.directions[current]![direction]!;
      step++;
    } while (current != 'ZZZ');

    return step;
  }

  @override
  int solvePart2() {
    final input = parseInput();

    final endsWithA = input.directions.keys.where((k) => k[k.length - 1] == 'A').toList();

    var currentSteps = endsWithA;

    int step = 0;
    final repetitions = <int, int>{};
    final repetitionsFrequencies = <int, _RepetitionFreqValue>{};

    do {
      final relativeInstructionIndex = step % input.instructions.length;
      final direction = input.instructions[relativeInstructionIndex];

      currentSteps = currentSteps.map((current) => input.directions[current]![direction]!).toList();

      for (var i = 0; i < currentSteps.length; i++) {
        final current = currentSteps[i];

        if (current[current.length - 1] == 'Z') {
          final rep = repetitions[i];

          if (rep == null) {
            repetitions[i] = step;
          } else if (repetitionsFrequencies[i] == null) {
            repetitionsFrequencies[i] = (offset: rep, frequency: step - rep);
          }
        }
      }

      step++;
    } while (repetitionsFrequencies.length < endsWithA.length);

    final offsets = repetitionsFrequencies.values.map((e) => e.offset + 1).toList();

    return offsets.reduce((value, element) => value.lcm(element));
  }
}

typedef _RepetitionFreqValue = ({int offset, int frequency});

void main() {
  Day08().printSolutions();
}

extension LcdExt on int {
  int lcm(int other) {
    return (this * other) ~/ this.gcd(other);
  }
}
