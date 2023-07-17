import 'package:collection/collection.dart';

import '../utils/utils.dart';

typedef Pos3D = (int x, int y, int z);

class Day19 extends GenericDay {
  Day19() : super(2021, 19);

  @override
  List<Set<Pos3D>> parseInput() {
    final scanners = input.getBy('\n\n');

    final data = scanners
        .map(
          (scanner) => scanner.split('\n').skip(1).where((element) => element.isNotEmpty).map((beacon) {
            final splits = beacon.split(',').map(int.parse).toList();
            return (splits[0], splits[1], splits[2]);
          }).toSet(),
        )
        .toList();
    return data;
  }

  (Set<Pos3D> beacons, Set<Pos3D> scanners) solve(List<Set<Pos3D>> scannersData) {
    final beacons = {...scannersData[0]};
    var remainingScanners = [...scannersData.skip(1)];
    var scanners = {(0, 0, 0)};

    print('>>> starting with ${remainingScanners.length} scanners');

    do {
      for (var scannerBeacons in remainingScanners.toList()) {
        final allOrientations = scannerBeacons.map((e) => e.allCubePoints.toList()).toList();
        final inverted = <List<Pos3D>>[];
        for (var i = 0; i < allOrientations.first.length; i++) {
          inverted.add([for (var j = 0; j < allOrientations.length; j++) allOrientations[j][i]]);
        }
        for (var orientedBeacons in inverted) {
          final matchingOffset = match(beacons, orientedBeacons);
          if (matchingOffset != null) {
            final offsetedBeacons = orientedBeacons.map((beacon) => beacon + matchingOffset).toList();
            beacons.addAll(offsetedBeacons);
            scanners.add(matchingOffset);
            remainingScanners = remainingScanners.whereNot((s) => s == scannerBeacons).toList();
            continue;
          }
        }
      }

      print('>>> remaining: ${remainingScanners.length}');
    } while (remainingScanners.isNotEmpty);

    return (beacons, scanners);
  }

  static const MIN_COMMON_BEACONS = 12;
  Pos3D? match(Iterable<Pos3D> left, Iterable<Pos3D> right) {
    final offsets = <Pos3D, int>{};
    for (var leftBeacon in left) {
      for (var rightBeacon in right) {
        final offset = leftBeacon - rightBeacon;
        offsets.update(offset, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    final matchingOffset = offsets.entries.firstWhereOrNull((e) => e.value >= MIN_COMMON_BEACONS)?.key;

    return matchingOffset;
  }

  late final (Set<Pos3D> beacons, Set<Pos3D> scanners) part1Result;

  @override
  int solvePart1() {
    final lines = parseInput();

    part1Result = solve(lines);
    final (beacons, _) = part1Result;

    return beacons.length;
  }

  @override
  int solvePart2() {
    final (_, scanners) = part1Result;
    final maxDistance = [
      for (final s1 in scanners) scanners.map((s2) => s1.manhattanDistance(s2)).max,
    ].max;
    return maxDistance;
  }
}

extension on Pos3D {
  Pos3D operator -(Pos3D other) {
    return (
      this.$1 - other.$1,
      this.$2 - other.$2,
      this.$3 - other.$3,
    );
  }

  Pos3D operator +(Pos3D other) {
    return (
      this.$1 + other.$1,
      this.$2 + other.$2,
      this.$3 + other.$3,
    );
  }

  Set<Pos3D> get allCubePoints => {
        //
        (this.$1, this.$2, this.$3),
        (this.$1, -this.$3, this.$2),
        (this.$1, -this.$2, -this.$3),
        (this.$1, this.$3, -this.$2),
        //
        (-this.$2, this.$1, this.$3),
        (this.$3, this.$1, this.$2),
        (this.$2, this.$1, -this.$3),
        (-this.$3, this.$1, -this.$2),
        //
        (-this.$1, -this.$2, this.$3),
        (-this.$1, -this.$3, -this.$2),
        (-this.$1, this.$2, -this.$3),
        (-this.$1, this.$3, this.$2),
        //
        (this.$2, -this.$1, this.$3),
        (this.$3, -this.$1, -this.$2),
        (-this.$2, -this.$1, -this.$3),
        (-this.$3, -this.$1, this.$2),
        //
        (-this.$3, this.$2, this.$1),
        (this.$2, this.$3, this.$1),
        (this.$3, -this.$2, this.$1),
        (-this.$2, -this.$3, this.$1),
        //
        (-this.$3, -this.$2, -this.$1),
        (-this.$2, this.$3, -this.$1),
        (this.$3, this.$2, -this.$1),
        (this.$2, -this.$3, -this.$1),
      };

  int manhattanDistance(Pos3D other) {
    return (this.$1 - other.$1).abs() + (this.$2 - other.$2).abs() + (this.$3 - other.$3).abs();
  }
}
