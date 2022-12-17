import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day17 extends GenericDay {
  Day17() : super(2022, 17);

  @override
  List<int> parseInput() {
    return input.getBy('').where((element) => element == '<' || element == '>').map((e) => e == '<' ? -1 : 1).toList();
  }

  @override
  int solvePart1() {
    final jets = parseInput();
    return finHeightOfFallenRocks(jets, 2022); 
  }

  @override
  int solvePart2() {
    final jets = parseInput();
    return finHeightOfFallenRocks(jets, 1000000000000);    
  }

  bool willCollide(List<Set<int>> state, List<List<bool>> rock, Position rockPosition) {
    if (rockPosition.y == 0) return true;
    for (var rockY = 0; rockY < rock.length; rockY++) {
      for (var rockX = 0; rockX < rock[rockY].length; rockX++) {
        if (rock[rockY][rockX]) {
          if (state[rockX + rockPosition.x].contains(rockY + rockPosition.y)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  addRock(List<Set<int>> state, List<List<bool>> rock, Position rockPosition) {
    for (var rockY = 0; rockY < rock.length; rockY++) {
      for (var rockX = 0; rockX < rock[rockY].length; rockX++) {
        if (rock[rockY][rockX]) {
          state[rockX + rockPosition.x].add(rockY + rockPosition.y);
        }
      }
    }
  }

  int finHeightOfFallenRocks(List<int> jets, int numberOfBlocks) {
    int jetIndex = 0;
    final state = List.generate(7, (index) => <int>{}); 

    Map<String, Tuple2<int, int>> cache = {};

    // For every falling rock
    for (var roundIndex = 0; roundIndex < numberOfBlocks; roundIndex++) {
      final rockIndex = roundIndex % 5;
      final rock = rocks[rockIndex];
      final maxHeight = getMax(state);
      var rockCursor = Position(2, maxHeight + 4);

      // Cycle detection
      final cacheKey = getKey(jetIndex, rockIndex);
      if (cache.containsKey(cacheKey)) {
        final prev = cache[cacheKey]!;
        final prevRoundIndex = prev.item1;
        final cycleLength = roundIndex - prevRoundIndex;
        
        final remainingRounds = numberOfBlocks - roundIndex;
        if (remainingRounds % cycleLength == 0) {
          final prevMaxHeight = prev.item2;
          final cycleHeight = maxHeight - prevMaxHeight;

          return maxHeight + (remainingRounds ~/ cycleLength) * cycleHeight;
        }
      } else {
        cache[cacheKey] = Tuple2(roundIndex, maxHeight);
      }

      // 
      bool falling = true;
      while(falling) {
        // Move rock with jet
        int jet = jets[jetIndex];
        if (rockCursor.x + jet >= 0 && rockCursor.x + rock.first.length + jet <= 7 && !willCollide(state, rock, rockCursor.moved(jet, 0))) {
          rockCursor = rockCursor.moved(jet, 0);
        }
        jetIndex = (jetIndex + 1) % jets.length;

        // Move/Freeze rock
        if (willCollide(state, rock, rockCursor.moved(0, -1))) {
          addRock(state, rock, rockCursor);
          falling = false;
        } else {
          rockCursor = rockCursor.moved(0, -1);
        }
      }
    }

    return getMax(state);
  }

  int getMax(List<Set<int>> state) => state.map((e) => e.maxOrNull ?? 0).max;

  String getKey(int jetIndex, int rockIndex) {
    return '$jetIndex-$rockIndex';
  }


  final rocks = [
    [[true, true, true, true]],

    [[false, true, false],
    [true, true, true],
    [false, true, false]],

    [[true, true, true],
    [false, false, true],
    [false, false, true]],

    [[true,],
    [true,],
    [true,],
    [true,]],

    [[true, true],
    [true, true]],
  ];
}
