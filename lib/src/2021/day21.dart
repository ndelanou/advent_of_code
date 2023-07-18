import '../utils/utils.dart';

class Day21 extends GenericDay {
  Day21() : super(2021, 21);

  @override
  List<int> parseInput() {
    return input.getPerLine().map((line) {
      return int.parse(line.split(' ').last);
    }).toList();
  }

  @override
  int solvePart1() {
    final playersPositions = parseInput();
    final playersScores = playersPositions.map((e) => 0).toList();
    int playerIndex = 0;
    int diceRolls = 0;

    int rollDice() {
      final diceValue = diceRolls % 100 + 1;
      diceRolls = diceRolls + 1;
      return diceValue;
    }

    int play(int playerIndex) {
      final moving = rollDice() + rollDice() + rollDice();
      var newPosition = (playersPositions[playerIndex] + moving) % 10;
      if (newPosition == 0) newPosition = 10;
      playersPositions[playerIndex] = newPosition;
      final addedScore = newPosition;
      final newPlayerScore = playersScores[playerIndex] + addedScore;
      playersScores[playerIndex] = newPlayerScore;

      return newPlayerScore;
    }

    while (true) {
      final newPlayerScore = play(playerIndex);
      playerIndex = (playerIndex + 1) % playersPositions.length;

      if (newPlayerScore >= 1000) break;
    }

    return playersScores[playerIndex] * diceRolls;
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    return lines.length;
  }
}

void main(List<String> args) {
  final day = Day21();
  day.printSolutions();
}
