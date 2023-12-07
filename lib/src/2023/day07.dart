import 'package:collection/collection.dart';

import '../utils/utils.dart';

typedef HandEntry = ({Hand hand, int bid});

const cardRanks = '23456789TJQKA';
const p2cardRanks = 'J23456789TQKA';

enum HandType { HighCard, OnePair, TwoPairs, ThreeOfAKind, FullHouse, FourOfAKind, FiveOfAKind }

class Hand {
  final List<int> ranks;
  late final List<List<int>> groups;
  late final HandType type;

  Hand(this.ranks) {
    final sortedGroups = ranks.groupListsBy((e) => e).entries.sorted((a, b) {
      if (b.value.length == a.value.length) {
        return b.key.compareTo(a.key);
      } else {
        return b.value.length.compareTo(a.value.length);
      }
    });

    groups = sortedGroups.map((e) => e.value).toList();

    if (groups.length == 5) {
      type = HandType.HighCard;
    } else if (groups.length == 4) {
      type = HandType.OnePair;
    } else if (groups.length == 3) {
      if (groups[0].length == 3) {
        type = HandType.ThreeOfAKind;
      } else {
        type = HandType.TwoPairs;
      }
    } else if (groups.length == 2) {
      if (groups[0].length == 4) {
        type = HandType.FourOfAKind;
      } else {
        type = HandType.FullHouse;
      }
    } else if (groups.length == 1) {
      type = HandType.FiveOfAKind;
    } else {
      throw Exception('Invalid hand');
    }
  }
}

class HandJ extends Hand {
  final List<int> originalRanks;

  HandJ(super.ranks, {required this.originalRanks});
}

class Day07 extends GenericDay {
  Day07() : super(2023, 7);

  @override
  List<HandEntry> parseInput() {
    return input.getPerLine().map((line) {
      final parts = line.split(' ');
      final hand = parts.first;

      final cardIndexs = hand.split('').map((c) => cardRanks.indexOf(c)).toList();

      return (hand: Hand(cardIndexs), bid: int.parse(parts.last));
    }).toList();
  }

  @override
  int solvePart1() {
    final hands = parseInput();

    final sortedHands = sortedHandEntries(hands);

    return getScore(sortedHands);
  }

  List<HandEntry> sortedHandEntries(List<HandEntry> entries) {
    return entries.sorted((a, b) {
      final handTypeA = a.hand.type;
      final handTypeB = b.hand.type;

      if (handTypeA == handTypeB) {
        for (var i = 0; i < a.hand.ranks.length; i++) {
          final int rankA = (a.hand is HandJ) ? (a.hand as HandJ).originalRanks[i] : a.hand.ranks[i];
          final int rankB = (b.hand is HandJ) ? (b.hand as HandJ).originalRanks[i] : b.hand.ranks[i];

          if (rankA == rankB) {
            continue;
          } else {
            return rankA.compareTo(rankB);
          }
        }
        return 0;
      } else {
        return handTypeA.index.compareTo(handTypeB.index);
      }
    }).toList();
  }

  int getScore(List<HandEntry> sortedHands) {
    int score = 0;

    for (var i = 0; i < sortedHands.length; i++) {
      final hand = sortedHands[i];
      score += (i + 1) * hand.bid;
    }

    return score;
  }

  List<HandEntry> parseInputP2() {
    return input.getPerLine().map((line) {
      final parts = line.split(' ');
      final hand = parts.first;

      final cardIndexs = hand.split('').map((c) => p2cardRanks.indexOf(c)).toList();

      return (hand: Hand(cardIndexs), bid: int.parse(parts.last));
    }).toList();
  }

  @override
  int solvePart2() {
    final hands = parseInputP2();

    final bestHands = <HandEntry>[];

    for (final hand in hands) {
      if (hand.hand.ranks.contains(0)) {
        final allPossibleHands = <HandEntry>[];
        for (var i = 1; i < p2cardRanks.length; i++) {
          allPossibleHands.add((hand: HandJ(hand.hand.ranks.replace(0, by: i), originalRanks: hand.hand.ranks), bid: hand.bid));
        }
        print(hand.hand.ranks.where((element) => element == 0).length);
        bestHands.add(sortedHandEntries(allPossibleHands).last);
      } else {
        bestHands.add(hand);
      }
    }

    final sortedHands = sortedHandEntries(bestHands);

    print(sortedHands.map((e) => e.hand.ranks).join('\n'));

    return getScore(sortedHands); // 250869076
  }
}

void main() {
  Day07().printSolutions();
}

extension ReplaceListExt<T> on List<T> {
  List<T> replace(T replacedValue, {required T by}) {
    return [for (final value in this) value == replacedValue ? by : value];
  }
}
