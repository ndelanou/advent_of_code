import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day04 extends GenericDay {
  Day04() : super(2021, 4);

  @override
  Iterable<String> parseInput() {
    return input.getPerLine();
  }

  @override
  solvePart1() {
    final lines = parseInput();
    final numbers = lines.first.split(',').map((e) => int.parse(e));
    final groupedLines = lines.skip(2).splitBefore((l) => l.isEmpty).map((grp) => grp.where((l) => l.isNotEmpty));
    final cards = groupedLines.map((c) => c.map((r) => r.trim().split(' ').where((element) => element.isNotEmpty).map((e) => int.parse(e))));

    for (var i = 1; i < numbers.length; i++) {
      final pickedNumbers = numbers.toList().sublist(0, i);

      final winningCardScore = cards.map((c) => cardScore(c, pickedNumbers)).firstWhereOrNull((element) => element != null);
      if (winningCardScore != null) {
        return winningCardScore * pickedNumbers.last;
      }
    }
  }

  @override
  solvePart2() {
    final lines = parseInput();
    final numbers = lines.first.split(',').map((e) => int.parse(e));
    final groupedLines = lines.skip(2).splitBefore((l) => l.isEmpty).map((grp) => grp.where((l) => l.isNotEmpty));
    final cards = groupedLines.map((c) => c.map((r) => r.trim().split(' ').where((element) => element.isNotEmpty).map((e) => int.parse(e))));

    int loosingCardIndex = -1;
    for (var i = 1; i < numbers.length; i++) {
      final pickedNumbers = numbers.toList().sublist(0, i);

      final cardsScores = cards.map((c) => cardScore(c, pickedNumbers));
      if (cardsScores.where((cs) => cs == null).length == 1) {
        loosingCardIndex =  cardsScores.toList().indexWhere((element) => element == null);
      }

      int? losingCardScore;
      if (loosingCardIndex > -1) {
        losingCardScore = cardScore(cards.toList()[loosingCardIndex], pickedNumbers);
      }

      if (losingCardScore != null) {
        return losingCardScore * pickedNumbers.last;
      }
    }
  }


  int? cardScore(Iterable<Iterable<int>> card, List<int> pickedNumbers) {
    final hasRow = card.any((row) => row.every((nb) => pickedNumbers.contains(nb)));
    final hasColumn = [0,1,2,3,4].map((x) => [0,1,2,3,4].map((y) => card.elementAt(y).elementAt(x))).any((row) => row.every((nb) => pickedNumbers.contains(nb)));
    if (hasRow || hasColumn) {
      return card.fold<int>(0, (acc, row) => acc + row.fold(0, (accR, nb) => accR + (pickedNumbers.contains(nb) ? 0 : nb)));
    }
    return null;
  }

}