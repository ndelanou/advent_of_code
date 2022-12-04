import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  // Part 1
  final scores = lines.map((l) {
    final halfLength = l.length ~/ 2;
    final first = l.substring(0, halfLength);
    final second = l.substring(halfLength, l.length);

    final commonLetter = first.codeUnits.firstWhere((f) => second.codeUnits.contains(f));

    return getLetterPrio(commonLetter);
  });

  print(scores.fold<int>(0, (acc, score) => acc + score)); // 7737

  // Part 2
  var sum = 0;
  for (var i = 0; i < lines.length ~/ 3; i++) {

    final a = lines[i*3].codeUnits;
    final b = lines[i*3+1].codeUnits;
    final c = lines[i*3+2].codeUnits;

    final commonLetter = a.firstWhere((aChar) => b.contains(aChar) && c.contains(aChar));

    sum += getLetterPrio(commonLetter);
  }

  print(sum); // 2697
  
}


final aOffset = 'a'.codeUnits.first;
final AOffset = 'A'.codeUnits.first;

int getLetterPrio(int codeUnit) {
  if (codeUnit <= 'Z'.codeUnits.first) {
      return codeUnit - AOffset + 27;
    } else {
      return codeUnit - aOffset + 1;
    }
}
