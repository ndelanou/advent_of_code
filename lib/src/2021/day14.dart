import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day14 extends GenericDay {
  Day14() : super(2021, 14);

  @override
  (String template, Map<(int, int), int>) parseInput() {
    final halfs = input.getPerWhitespace();
    final mapping = Map.fromEntries(halfs.last.split('\n').map((l) {
      final lineSplits = l.split(' -> ');
      final keyCodeUnits = lineSplits.first.codeUnits;
      return MapEntry((keyCodeUnits.first, keyCodeUnits.last), lineSplits.last.codeUnits.first);
    }));
    return (halfs.first, mapping);
  }

  @override
  solvePart1() {
    final data = parseInput();
    final template = data.$0;
    final mapping = data.$1;

    List<int> polymer = template.codeUnits;
    for (var i = 0; i < 10; i++) {
      polymer = processPolymer(polymer, mapping).toList();
    }

    final occurrenceMap = polymer.fold<Map<int, int>>({}, (acc, codeUnit) => acc..update(codeUnit, (value) => value + 1, ifAbsent: () => 1));
    final occurrences = occurrenceMap.values.sorted((a, b) => a.compareTo(b));
    return occurrences.last - occurrences.first;
  }

  Iterable<int> processPolymer(List<int> polymer, Map<(int, int), int> mapping) sync* {
    yield polymer.first;
    for (var i = 1; i < polymer.length; i++) {
      final mappingKey = (polymer[i-1], polymer[i]);
      final inserted = mapping[mappingKey]!;
      yield* [inserted, mappingKey.$1];
    }
  }
  
  Map<(int, int), int> processPolymerV2(Map<(int, int), int> pairs, Map<(int, int), int> mapping) {
    final Map<(int, int), int> tmp = {};
    pairs.forEach((pair, count) {
      final inserted = mapping[pair]!;
      final left = (pair.$0, inserted);
      final right = (inserted, pair.$1);
      tmp.update(left, (value) => value + count, ifAbsent: () => count);
      tmp.update(right, (value) => value + count, ifAbsent: () => count);
    });
    
    return tmp;
  }

  Map<(int, int), int> polymerToPairs(List<int> polymer) {
    final tmp = <(int, int), int>{};
    for (var i = 1; i < polymer.length; i++) {
      tmp.update((polymer[i-1], polymer[i]), (value) => value + 1, ifAbsent: () => 1);
    }
    return tmp;
  }

  @override
  solvePart2() {
    final data = parseInput();
    final template = data.$0;
    final mapping = data.$1;

    final basePolymer = template.codeUnits;
    Map<(int, int), int> pairs = polymerToPairs(basePolymer);

    for (var i = 0; i < 40; i++) {
      pairs = processPolymerV2(pairs, mapping);
    }

    final occurrences = occurencesPerLetter(pairs, basePolymer).values.sorted((a, b) => a.compareTo(b));
    return occurrences.last - occurrences.first;
  }

  Map<int, int> occurencesPerLetter(Map<(int, int), int> pairs, List<int> basePolymer) {
    final tmp = <int, int>{};
    pairs.forEach((key, value) {
      tmp.update(key.$0, (prev) => prev + value, ifAbsent: () => value);
    });
    tmp.update(basePolymer.last, (value) => value + 1, ifAbsent: () => 1);
    return tmp;
  }
}

void main(List<String> args) {
  Day14().printSolutions();
}
