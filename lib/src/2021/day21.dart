import 'dart:math';

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

  static const int gameMaxPoints = 21;

  @override
  int solvePart2() {
    final playersPositions = parseInput();

    final LookupTable lookupTable = {};

    final result = getLookupValue((pos1: playersPositions.first, pos2: playersPositions.last, points1: 0, points2: 0, playerIndex: 0), lookupTable);

    return max(result.win1, result.win2);
  }

  static const threeRollsProbabilities = {
    3: 1,
    4: 3,
    5: 6,
    6: 7,
    7: 6,
    8: 3,
    9: 1,
  };

  int incrementPosition(int pos, int offset) {
    final newPos = (pos + offset) % 10;
    return newPos == 0 ? 10 : newPos;
  }

  LookupValue getLookupValue(LookupKey key, LookupTable lookupTable) {
    if (key.points1 >= gameMaxPoints) return (win1: 1, win2: 0);
    if (key.points2 >= gameMaxPoints) return (win1: 0, win2: 1);

    if (lookupTable[key] case final lookupValue?) {
      return lookupValue;
    }

    final startingPos = key.playerIndex == 0 ? key.pos1 : key.pos2;

    final nextPlayerIndex = (key.playerIndex + 1) % 2;
    var win1 = 0;
    var win2 = 0;

    for (final roll in threeRollsProbabilities.entries) {
      final nextCase = incrementPosition(startingPos, roll.key);
      final it = getLookupValue((
        pos1: key.playerIndex == 0 ? nextCase : key.pos1,
        pos2: key.playerIndex == 1 ? nextCase : key.pos2,
        points1: key.playerIndex == 0 ? key.points1 + nextCase : key.points1,
        points2: key.playerIndex == 1 ? key.points2 + nextCase : key.points2,
        playerIndex: nextPlayerIndex,
      ), lookupTable);

      win1 += it.win1 * roll.value;
      win2 += it.win2 * roll.value;
    }

    final result = (win1: win1, win2: win2);
    lookupTable[key] = result;

    return result;
  }
}

typedef LookupKey = ({int pos1, int pos2, int points1, int points2, int playerIndex});
typedef LookupValue = ({int win1, int win2});
typedef LookupTable = Map<LookupKey, LookupValue>;

void main(List<String> args) {
  final day = Day21();
  day.printSolutions();
}
