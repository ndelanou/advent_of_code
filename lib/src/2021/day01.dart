import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final lines = (await file.readAsString()).split('\n');
  print('lines: ${lines.length}');

  final values = lines.map((l) => int.parse(l)).toList();

  // Part 1
  int increaseCount = 0;
  for (var i = 0; i < values.length; i++) {
    if (i == 0) continue;
    if (values[i] > values[i-1]) increaseCount++;
  }
  
  print(increaseCount);


  // Part 2
  int slidingIncreaseCount = 0;
  for (var i = 0; i < values.length - 3; i++) {
    final s1 = values[i] + values[i + 1] + values[i + 2];
    final s2 = values[i + 1] + values[i + 2] + values[i + 3];
    if (s2 > s1) slidingIncreaseCount++;
  }
  
  print(slidingIncreaseCount);
}
