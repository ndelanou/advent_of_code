import 'dart:math';

import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

class Day19 extends GenericDay {
  Day19() : super(2022, 19);

  @override
  List<Blooprint> parseInput() {
    return input.getPerLine().map((l) {
      final splits = l.split(' ');
      return Blooprint(
        Cost(ore: int.parse(splits[6])),
        Cost(ore: int.parse(splits[12])),
        Cost(ore: int.parse(splits[18]), clay: int.parse(splits[21])),
        Cost(ore: int.parse(splits[27]), obsidian: int.parse(splits[30])),
      );
    }).toList();
  }

  int maxGeodes(State state, Blooprint bp, int remainingRounds) {
    if (remainingRounds <= 0) return state.geode;
    
    int geodes = 0;
    if (state.oreRobots < bp.geode.ore || state.oreRobots < bp.obsidian.ore || state.oreRobots < bp.clay.ore) {
      final oreWaitRounds = state.nbRoundsFor(bp.ore) + 1;
      if (remainingRounds - oreWaitRounds < 0) {
        geodes = max(geodes, maxGeodes(state.copy()..applyRounds(remainingRounds), bp, 0));
      } else {
        geodes = max(geodes, maxGeodes(state.copy()..applyRounds(oreWaitRounds)..applyCost(bp.ore)..oreRobots+=1, bp, remainingRounds - oreWaitRounds));
      }
    }
    if (state.clayRobots < bp.geode.clay || state.clayRobots < bp.obsidian.clay) {
      final clayWaitRounds = state.nbRoundsFor(bp.clay) + 1;
      if (remainingRounds - clayWaitRounds < 0) {
        geodes = max(geodes, maxGeodes(state.copy()..applyRounds(remainingRounds), bp, 0));
      } else {
        geodes = max(geodes, maxGeodes(state.copy()..applyRounds(clayWaitRounds)..applyCost(bp.clay)..clayRobots+=1, bp, remainingRounds - clayWaitRounds));
      }
    }
    if (state.obsidianRobots < bp.geode.obsidian) {
      final obsidianWaitRounds = state.nbRoundsFor(bp.obsidian) + 1;
      if (remainingRounds - obsidianWaitRounds < 0) {
        geodes = max(geodes, maxGeodes(state.copy()..applyRounds(remainingRounds), bp, 0));
      } else {
        geodes = max(geodes, maxGeodes(state.copy()..applyRounds(obsidianWaitRounds)..applyCost(bp.obsidian)..obsidianRobots+=1, bp, remainingRounds - obsidianWaitRounds));
      }
    }
    
    final geodeWaitRounds = state.nbRoundsFor(bp.geode) + 1;
    if (remainingRounds - geodeWaitRounds < 0) {
      geodes = max(geodes, maxGeodes(state.copy()..applyRounds(remainingRounds), bp, 0));
    } else {
      geodes = max(geodes, maxGeodes(state.copy()..applyRounds(geodeWaitRounds)..applyCost(bp.geode)..geodeRobots+=1, bp, remainingRounds - geodeWaitRounds));
    }
    return geodes;
  }

  @override
  int solvePart1() {
    final bps = parseInput();
    final maxScore = bps.mapIndexed((bpIndex, bp) {
      final geodes = maxGeodes(State(), bp, 24);
      return Tuple2(bpIndex + 1, geodes);
    }).toList();

    final scoreSum = maxScore.map((e) => e.item1 * e.item2).sum;
    return scoreSum;
  }

  @override
  int solvePart2() {
    final bps = parseInput();
    final maxScores = bps.take(3).mapIndexed((bpIndex, bp) => maxGeodes(State(), bp, 32));
    final score = maxScores.fold(1, (acc, element) => acc * element);
    return score;
  }
}

class State {
  int oreRobots;
  int clayRobots;
  int obsidianRobots;
  int geodeRobots;

  int ore;
  int clay;
  int obsidian;
  int geode;

  State({this.oreRobots = 1, this.clayRobots = 0, this.obsidianRobots = 0, this.geodeRobots = 0, this.ore = 0, this.clay = 0, this.obsidian = 0, this.geode = 0});

  State copy() => State(oreRobots: oreRobots, clayRobots: clayRobots, obsidianRobots: obsidianRobots, geodeRobots: geodeRobots, ore: ore, clay: clay, obsidian: obsidian, geode: geode);

  void applyRounds(int rounds) {
    ore += oreRobots * rounds;
    clay += clayRobots * rounds;
    obsidian += obsidianRobots * rounds;
    geode += geodeRobots * rounds;
  }

  void applyCost(Cost cost) {
    ore -= cost.ore;
    clay -= cost.clay;
    obsidian -= cost.obsidian;
  }

  int nbRoundsFor(Cost cost) {
    if ((cost.clay > 0 && clayRobots == 0) || (cost.obsidian > 0 && obsidianRobots == 0)) return 100000000000;
    
    final oreRounds = cost.ore == 0 ? 0 : ((cost.ore - ore + oreRobots) / oreRobots).ceil() - 1;
    final clayRounds = cost.clay == 0 ? 0 : ((cost.clay - clay + clayRobots) / clayRobots).ceil() - 1;
    final obsidianRounds = cost.obsidian == 0 ? 0 : ((cost.obsidian - obsidian + obsidianRobots) / obsidianRobots).ceil() - 1;

    return max(max(max(oreRounds, clayRounds), obsidianRounds), 0);
  }
}

class Blooprint {
  final Cost ore;
  final Cost clay;
  final Cost obsidian;
  final Cost geode;

  Blooprint(this.ore, this.clay, this.obsidian, this.geode);
}

class Cost {
  final int ore;
  final int clay;
  final int obsidian;

  Cost({this.ore = 0, this.clay = 0, this.obsidian = 0});
}