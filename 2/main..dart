import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File(filename);
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  final diffOffset = 'X'.codeUnits.first - 'A'.codeUnits.first;
  final xOffset = 'X'.codeUnits.first;

  int calculateOutcomeScore(String oMove, String yMove) {
    int oMoveCode = oMove.codeUnits.first;
    int yMoveCode = yMove.codeUnits.first;

    int moveScore = yMoveCode - xOffset + 1;

    int result = (oMoveCode - (yMoveCode - diffOffset) + 3) % 3;
    int resultScore;
    if (result == 0) {
      resultScore = 3;
    } else if (result == 1) {
      resultScore = 0;
    } else {
      resultScore = 6;
    }

    return moveScore + resultScore;
  }

  // Part 1
  final scores = lines.map((l) {
    final oMove = l[0];
    final yMove = l[2];

    return calculateOutcomeScore(oMove, yMove);
  });

  print(scores.fold<int>(0, (acc, score) => acc + score)); // 11150

  // Part 2
  final scores2 = lines.map((l) {
    final oMove = l[0];
    final eOutcome = l[2];

    String yMove;
    if (eOutcome == 'X') {
      if (oMove == 'A') {
        yMove = 'Z';
      } else if (oMove == 'B') {
        yMove = 'X';
      } else {
        yMove = 'Y';
      }
    } else if (eOutcome == 'Y') {
      yMove = String.fromCharCode(oMove.codeUnits.first + diffOffset);
    } else {
      if (oMove == 'A') {
        yMove = 'Y';
      } else if (oMove == 'B') {
        yMove = 'Z';
      } else {
        yMove = 'X';
      }
    }

    return calculateOutcomeScore(oMove, yMove);
  });

  print(scores2.fold<int>(0, (acc, score) => acc + score)); // 8295
  
}
