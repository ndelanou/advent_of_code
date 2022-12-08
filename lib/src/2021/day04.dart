import 'dart:io';
import 'package:collection/collection.dart';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final lines = (await file.readAsString()).split('\n');
  print('lines: ${lines.length}');

  final numbers = lines.first.split(',').map((e) => int.parse(e));
  final groupedLines = lines.skip(2).splitBefore((l) => l.isEmpty).map((grp) => grp.where((l) => l.isNotEmpty));
  final cards = groupedLines.map((c) => c.map((r) => r.trim().split(' ').where((element) => element.isNotEmpty).map((e) => int.parse(e))));

  // Part 1
  for (var i = 1; i < numbers.length; i++) {
    final pickedNumbers = numbers.toList().sublist(0, i);

    final winningCardScore = cards.map((c) => cardScore(c, pickedNumbers)).firstWhereOrNull((element) => element != null);
    if (winningCardScore != null) {
      print(winningCardScore * pickedNumbers.last);
      break;
    }
  }

  // Part 2
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
      print(losingCardScore * pickedNumbers.last);
      break;
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
