import 'package:advent_of_code/src/utils/utils.dart';

class Day05 extends GenericDay {
  Day05() : super(2022, 5);

  @override
  List<List<String>> parseInput() {
    final List<List<String>> stacks = List.generate(9, (index) => []);
    final lines = input.getPerLine();
    lines.take(8).toList().reversed.forEach((l) {
      for (var i = 0; i < 9; i++) {
        final char = l[i * 4 +1];
        if (char != ' ') stacks[i].add(char);
      }
    });
    return stacks;
  }

  Iterable<String> parseInstructions() {
    return input.getPerLine().skip(10);
  }
  
  @override
  solvePart1() { // QMBMJDFTD
    final stacks = parseInput();
    final instructions = parseInstructions();

    instructions.forEach((i) {
      final splits = i.split(' ');
      int nb = int.parse(splits[1]);
      int from = int.parse(splits[3]) - 1;
      int to = int.parse(splits[5]) - 1;

      for (var i = 0; i < nb; i++) {
        move(stacks, from, to);
      }
    });
  }
  
  @override
  solvePart2() { //  NBTVTJNFJ
    final stacks = parseInput();
    final instructions = parseInstructions();

    instructions.forEach((i) {
      final splits = i.split(' ');
      int nb = int.parse(splits[1]);
      int from = int.parse(splits[3]) - 1;
      int to = int.parse(splits[5]) - 1;

      moveMultiple(stacks, from, to, nb);
    });
  }

  void move(List<List<String>> stacks, int from, int to) {

    final moved = stacks[from].last;
    stacks[to].add(moved);
    stacks[from].removeLast();
  }

  void moveMultiple(List<List<String>> stacks, int from, int to, int nb) {

    final moved = stacks[from].sublist(stacks[from].length - nb);
    stacks[to].addAll(moved);
    stacks[from] = stacks[from].sublist(0, stacks[from].length - nb);
  }

}
