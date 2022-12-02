import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File(filename);
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  final offset = 'X'.codeUnits.first - 'A'.codeUnits.first;

  // Part 1
  final scores = lines.map((l) {
    final oMove = l[0];
    final yMove = l[2];

    int moveScore;
    if (yMove == 'X') {
      moveScore = 1;
    } else if (yMove == 'Y') {
      moveScore = 2;
    } else if (yMove == 'Z') {
      moveScore = 3;
    } else {
      throw 'Move not allowed $yMove';
    }

    int resultScore;
    if (oMove == 'A' && yMove == 'Y' || oMove == 'B' && yMove == 'Z' || oMove == 'C' && yMove == 'X') {
      resultScore = 6;
    } else if (yMove.codeUnits.first == oMove.codeUnits.first + offset) {
      resultScore = 3;
    } else {
      resultScore = 0;
    }

    return moveScore + resultScore;
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
      yMove = String.fromCharCode(oMove.codeUnits.first + offset);
    } else {
      if (oMove == 'A') {
        yMove = 'Y';
      } else if (oMove == 'B') {
        yMove = 'Z';
      } else {
        yMove = 'X';
      }
    }

    int moveScore;
    if (yMove == 'X') {
      moveScore = 1;
    } else if (yMove == 'Y') {
      moveScore = 2;
    } else if (yMove == 'Z') {
      moveScore = 3;
    } else {
      throw 'Move not allowed $yMove';
    }

    int resultScore;
    if (oMove == 'A' && yMove == 'Y' || oMove == 'B' && yMove == 'Z' || oMove == 'C' && yMove == 'X') {
      resultScore = 6;
    } else if (yMove.codeUnits.first == oMove.codeUnits.first + offset) {
      resultScore = 3;
    } else {
      resultScore = 0;
    }

    return moveScore + resultScore;
  });

  print(scores2.fold<int>(0, (acc, score) => acc + score)); // 8295
  
}
