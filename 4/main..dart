import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File(filename);
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  int sum = 0;
  int sum2 = 0;
  final pairs = lines.map((l) => l.split(',').map((r) => r.split('-').map((b) => int.parse(b))));
  for (var pair in pairs) {
    final e1 = pair.elementAt(0).toList();
    final e2 = pair.elementAt(1).toList();

    sum += isRangeContained(e1, e2) || isRangeContained(e2, e1) ? 1 : 0;
    sum2 += isRangeOverlapped(e2, e1) ? 1 : 0;
  }

  print(sum); // 530
  print(sum2); // 903
  
}

bool isRangeContained(List<int> r1, List<int> r2) {
  final r11 = r1[0];
  final r12 = r1[1];

  final r21 = r2[0];
  final r22 = r2[1];

  
  return r21 >= r11 && r21 <= r12 && r22 >= r11 && r22 <= r12;
}

bool isRangeOverlapped(List<int> r1, List<int> r2) {

  final r11 = r1[0];
  final r12 = r1[1];

  final r21 = r2[0];
  final r22 = r2[1];

  return !(r12 < r21 || r11 > r22);

}