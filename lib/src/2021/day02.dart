import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final lines = (await file.readAsString()).split('\n');
  print('lines: ${lines.length}');

  int x = 0, y = 0;

  // Part 1
  lines.forEach((element) {
    final splits = element.split(' ');
    final amount = int.parse(splits[1]);
    final instruction = splits[0];
    if (instruction == 'forward') x += amount;
    if (instruction == 'down') y += amount;
    if (instruction == 'up') y -= amount;
  });
  
  print(x*y); // 1692075


  // Part 2
  x = 0;
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
  
  print(x*z); // 1749524700
  
}
