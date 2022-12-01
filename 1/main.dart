import 'dart:io';
import 'dart:math';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File(filename);
  final lines = await file.readAsString();
  print('lines: ${lines.length}');

  final elfs = lines.split('\n\n');
  print('elfs: ${elfs.length}');

  final elfsCals = elfs.map(
    (e) => e
        .split('\n')
        .map((calStr) => int.parse(calStr))
        .fold(0, (acc, cal) => acc + cal),
  );

  // Part 1
  final maxCal = elfsCals.reduce(max);
  print('max: $maxCal');

  // Part 2
  final sortedCals = (elfsCals.toList()..sort()).reversed.toList();
  final top3Sum = sortedCals[0] + sortedCals[1] + sortedCals[2];
  print('top 3 sum: $top3Sum');
}
