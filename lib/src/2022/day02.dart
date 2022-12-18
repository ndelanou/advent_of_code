import '../utils/utils.dart';

class Day02 extends GenericDay {
  Day02() : super(2022, 2);

  @override
  List<String> parseInput() => input.getPerLine();

  @override
  solvePart1() {
    final lines = parseInput();

    final scores = lines.map((l) {
      final oMove = l[0];
      final yMove = l[2];

      return calculateOutcomeScore(oMove, yMove);
    });

    return scores.fold(0, (acc, score) => acc + score);
  }

  @override
  solvePart2() {
    final lines = parseInput();

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

    return scores2.fold(0, (acc, score) => acc + score);
  }

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
}
