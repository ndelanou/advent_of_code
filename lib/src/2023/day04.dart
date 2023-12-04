import 'package:collection/collection.dart';

import '../utils/utils.dart';

typedef Card = ({List<int> winningNumbers, List<int> myNumbers});

class Day04 extends GenericDay {
  Day04() : super(2023, 4);

  @override
  List<Card> parseInput() {
    return input.getPerLine().map((e) {
      final numbers = e.split(RegExp(r'(\s)+')).skip(2).toList();
      final separatorIndex = numbers.indexOf('|');
      final winningNumbers = numbers.sublist(0, separatorIndex).map(int.parse).toList();
      final myNumbers = numbers.sublist(separatorIndex + 1).map(int.parse).toList();

      return (
        winningNumbers: winningNumbers,
        myNumbers: myNumbers,
      );
    }).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput();
    final sum = lines.map((card) {
      int score = 0;
      for (final number in card.myNumbers) {
        if (card.winningNumbers.contains(number)) {
          if (score == 0) {
            score = 1;
          } else {
            score *= 2;
          }
        }
      }
      return score;
    }).sum;
    return sum;
  }

  @override
  int solvePart2() {
    final cards = parseInput();

    int cardCount = 0;
    for (var i = 0; i < cards.length; i++) {
      cardCount += _processCard(cards, i);
    }
    return cardCount;
  }

  var _cache = <int, int>{};

  int _processCard(List<Card> cards, int cardIndex) {
    if (cardIndex >= cards.length) {
      return 0;
    }

    if (_cache[cardIndex] case final cachedValue?) return cachedValue;

    final card = cards[cardIndex];

    int matches = 0;
    for (final number in card.myNumbers) {
      if (card.winningNumbers.contains(number)) {
        matches++;
      }
    }

    int cardCount = 1;
    for (var i = 0; i < matches; i++) {
      cardCount += _processCard(cards, cardIndex + i + 1);
    }

    _cache[cardIndex] = cardCount;

    return cardCount;
  }
}

void main(List<String> args) {
  Day04().printSolutions();
}
