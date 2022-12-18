import '../utils/utils.dart';

class Day03 extends GenericDay {
  Day03() : super(2022, 3);

  @override
  List<String> parseInput() => input.getPerLine();

  @override
  solvePart1() {
    final lines = parseInput();

    final scores = lines.map((l) {
      final halfLength = l.length ~/ 2;
      final first = l.substring(0, halfLength);
      final second = l.substring(halfLength, l.length);

      final commonLetter = first.codeUnits.firstWhere((f) => second.codeUnits.contains(f));

      return getLetterPrio(commonLetter);
    });

    return scores.fold(0, (acc, score) => acc + score);
  }

  @override
  solvePart2() {
    final lines = parseInput();

    var sum = 0;
    for (var i = 0; i < lines.length ~/ 3; i++) {

      final a = lines[i*3].codeUnits;
      final b = lines[i*3+1].codeUnits;
      final c = lines[i*3+2].codeUnits;

      final commonLetter = a.firstWhere((aChar) => b.contains(aChar) && c.contains(aChar));

      sum += getLetterPrio(commonLetter);
    }

    return sum;
  }

  final aOffset = 'a'.codeUnits.first;
  final capAOffset = 'A'.codeUnits.first;

  int getLetterPrio(int codeUnit) {
    if (codeUnit <= 'Z'.codeUnits.first) {
        return codeUnit - capAOffset + 27;
      } else {
        return codeUnit - aOffset + 1;
      }
  }
}
