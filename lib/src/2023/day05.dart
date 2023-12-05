import 'dart:math';

import '../utils/utils.dart';

typedef Input = ({List<int> seeds, Map<Converter, List<ConverteData>> converters});
typedef Converter = ({String from, String to});
typedef ConverteData = ({int destination, int source, int range});

class Day05 extends GenericDay {
  Day05() : super(2023, 5);

  @override
  Input parseInput() {
    final lines = input.getPerLine();
    final seeds = lines.first.split(' ').skip(1).map(int.parse).toList();

    final rawConverters = input.getBy('\n\n').skip(1).toList();

    final convertersEntries = rawConverters.map((data) {
      final lines = data.split('\n');

      final typeStr = lines.first.split(' ').first.split('-');
      final type = (from: typeStr.first, to: typeStr.last);

      final values = lines.skip(1).map((line) {
        final parts = line.split(' ').map(int.parse).toList();
        return (destination: parts[0], source: parts[1], range: parts[2]);
      }).toList();

      return MapEntry(type, values);
    }).toList();

    return (seeds: seeds, converters: Map.fromEntries(convertersEntries));
  }

  @override
  int solvePart1() {
    final input = parseInput();

    final locations = input.seeds.map((seed) => getSeedLocation(seed, converters: input.converters)).toList();

    final minLocation = locations.reduce(min);

    return minLocation;
  }

  int getSeedLocation(int seed, {required Map<Converter, List<ConverteData>> converters}) {
    final destinations = ['soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location'];

    int currentValue = seed;
    String currentType = 'seed';
    for (final destination in destinations) {
      currentValue = mapSourceToDestination(currentValue, currentType, destination, converters: converters);
      currentType = destination;
    }

    return currentValue;
  }

  int mapSourceToDestination(int value, String sourceType, String destinationType, {required Map<Converter, List<ConverteData>> converters}) {
    final converterValues = converters[(from: sourceType, to: destinationType)]!;

    for (final converter in converterValues) {
      if (converter.source <= value && value <= converter.source + converter.range) {
        return converter.destination + (value - converter.source);
      }
    }

    return value; // 165788812
  }

  @override
  int solvePart2() {
    final input = parseInput();

    final Set<SeedRange> seedRanges = {};
    for (var i = 0; i < input.seeds.length / 2; i++) {
      final offset = input.seeds[i * 2];
      final count = input.seeds[i * 2 + 1];
      seedRanges.add((from: offset, to: offset + count - 1));
    }

    final locations = seedRanges.map((seedRange) {
      int lowestLoc = 1000000000000000;
      for (var seed = seedRange.from; seed <= seedRange.to; seed++) {
        final loc = getSeedLocation(seed, converters: input.converters);
        lowestLoc = min(lowestLoc, loc);
      }
      print('$seedRange -> $lowestLoc');
      return lowestLoc;
    }).toList();

    final minLocation = locations.reduce(min);

    return minLocation;

    // final Set<SeedRange> seedRanges = {};
    // for (var i = 0; i < input.seeds.length / 2; i++) {
    //   final offset = input.seeds[i * 2];
    //   final count = input.seeds[i * 2 + 1];
    //   seedRanges.add((from: offset, to: offset + count - 1));
    // }

    // final locationRanges = seedRanges.map((seedRange) => getSeedRangeLocations(seedRange, converters: input.converters)).toList();

    // final minLocation = locationRanges.map((e) => e.map((e) => e.from).reduce(min)).reduce(min);

    // return minLocation;
  }

  Set<SeedRange> getSeedRangeLocations(SeedRange seedRanges, {required Map<Converter, List<ConverteData>> converters}) {
    final destinations = ['soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location'];

    print('=====================');

    Set<SeedRange> currentValue = {seedRanges};
    String currentType = 'seed';
    for (final destination in destinations) {
      print(currentValue);
      currentValue = mapSourceToDestinationRanges(currentValue, currentType, destination, converters: converters);
      currentType = destination;
    }

    return currentValue;
  }

  Set<SeedRange> mapSourceToDestinationRanges(Set<SeedRange> value, String sourceType, String destinationType, {required Map<Converter, List<ConverteData>> converters}) {
    final converterValues = converters[(from: sourceType, to: destinationType)]!;

    var newRanges = <SeedRange>{};

    for (final converter in converterValues) {
      final converterRange = (from: converter.source, to: converter.source + converter.range - 1);
      final converted = value.convertRange(converterRange, offset: converter.destination - converter.source);
      newRanges.addAll(converted);
    }

    return newRanges;
  }
}

extension SetIntersectExt on Set<SeedRange> {
  Set<SeedRange> convertRange(SeedRange convRange, {required int offset}) {
    final newSet = <SeedRange>{};

    for (final it in this) {
      // None
      if (it.from > convRange.to || it.to < convRange.from) {
        newSet.add(it);
        continue;
      }

      // All
      if (convRange.from <= it.from && convRange.to >= it.to) {
        newSet.add((from: it.from + offset, to: it.to + offset));
        continue;
      }

      // Lower
      if (convRange.from <= it.from && convRange.to < it.to) {
        newSet.add((from: it.from + offset, to: convRange.to + offset));
        newSet.add((from: convRange.to + 1, to: it.to));
        continue;
      }

      // Upper
      if (convRange.from > it.from && convRange.to >= it.to) {
        newSet.add((from: it.from, to: convRange.from - 1));
        newSet.add((from: convRange.from + offset, to: it.to + offset));
        continue;
      }

      // Inner
      if (convRange.from > it.from && convRange.to < it.to) {
        newSet.add((from: it.from, to: convRange.from - 1));
        newSet.add((from: convRange.from + offset, to: convRange.to + offset));
        newSet.add((from: convRange.to + 1, to: it.to));
        continue;
      }
    }

    return newSet;
  }
}

void main(List<String> args) {
  Day05().printSolutions();
}

typedef SeedRange = ({int from, int to});
