import 'dart:io';

import '../utils/range.dart';

// const filename = 'input.txt';
// void main(List<String> args) async {
//   final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
//   final input = await file.readAsString();

//   final lines = input.split('\n');
//   print('lines: ${lines.length}');

//   int part1 = 0;
//   int part2 = 0;
  
//   final pairs = lines.map((l) => l.split(',').map((r) {
//     final range = r.split('-').map((b) => int.parse(b));
//     return Range.fromList(range);
//   }));

//   for (var pair in pairs) {
//     final r1 = pair.elementAt(0);
//     final r2 = pair.elementAt(1);

//     if (r1.contains(r2) || r2.contains(r1)) part1++;
//     if (r1.overlapWith(r2)) part2++;
//   }

//   print(part1); // 530
//   print(part2); // 903
  
// }