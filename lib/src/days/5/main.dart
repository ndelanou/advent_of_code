import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  final List<List<String>> stacks = List.generate(9, (index) => []);

  void move(int from, int to) {

    final moved = stacks[from].last;
    stacks[to].add(moved);
    stacks[from].removeLast();
  }

  void moveMultiple(int from, int to, int nb) {

    final moved = stacks[from].sublist(stacks[from].length - nb);
    stacks[to].addAll(moved);
    stacks[from] = stacks[from].sublist(0, stacks[from].length - nb);
  }

  void applyInstruction(String i) {
    final splits = i.split(' ');
    int nb = int.parse(splits[1]);
    int from = int.parse(splits[3]) - 1;
    int to = int.parse(splits[5]) - 1;

    // Part 1
    // for (var i = 0; i < nb; i++) {
    //   move(from, to);
    // }

    // Part 2
    moveMultiple(from, to, nb);

  }

  lines.take(8).toList().reversed.forEach((l) {
    
    for (var i = 0; i < 9; i++) {
      final char = l[i * 4 +1];
      if (char != ' ') stacks[i].add(char);
    }
  });


  lines.skip(10).forEach((i) {
    applyInstruction(i);
  });

  print(stacks.map((e) => e.last).join());
  
}