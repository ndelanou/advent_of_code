import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Pos {
  final int x, y;

  Pos(this.x, this.y);

  bool operator ==(Object? other) =>
      other is Pos && x == other.x && y == other.y;

  int get hashCode => Object.hash(x, y);

  Pos operator+(Pos other) {
    return Pos(x + other.x, y + other.y);
  }
}

class Day23 extends GenericDay {
  Day23() : super(2022, 23);

  @override
  List<_Elf> parseInput() {
    return input.getPerLine().mapIndexed((y, line) => line.split('').mapIndexed((x, c) => c == '#' ? _Elf(Pos(x, y)) : null).whereNotNull()).expand((e) => e).toList();
  }

  Iterable<ScanDirection> scanDirectionsFromOffset(int fromIndex) sync* {
    for (var i = 0; i < ScanDirection.values.length; i++) {
      yield ScanDirection.values[(i + fromIndex) % ScanDirection.values.length];
    }
  }

  List<Pos> adjacentOnDirection(ScanDirection direction) {
    switch (direction) {
      case ScanDirection.north:
        return [
          Pos(0 , -1),
          Pos(1 , -1),
          Pos(-1, -1),
        ];
      case ScanDirection.south:
        return [
          Pos(0 , 1),
          Pos(1 , 1),
          Pos(-1, 1),
        ];
      case ScanDirection.west:
        return [
          Pos(-1, 0 ),
          Pos(-1, -1),
          Pos(-1, 1 ),
        ];
      case ScanDirection.east:
        return [
          Pos(1,  0),
          Pos(1,  1),
          Pos(1, -1),
        ];
    }
  }

  processGeneration(List<_Elf> elfs, int index) {
    final scanDirectionIndex = index % ScanDirection.values.length;
    final scanDirections = scanDirectionsFromOffset(scanDirectionIndex);

    final scanOffsets = scanDirections.map((dir) => adjacentOnDirection(dir)).toList();
    final occupiedPositions = elfs.map((e) => e.pos).toSet();

    // Compute proposed direction for each elf
    elfs.forEach((elf) {
      elf.evaluateDirection(occupiedPositions, scanOffsets);
    });

    elfs.forEach((elf) {
      if (elf.proposedPosition != null && elfs.where((e) => e.proposedPosition == elf.proposedPosition).length <= 1) {
        elf.pos = elf.proposedPosition!;
      }
    });
  }

  @override
  int solvePart1() {
    final elfs = parseInput();
    
    for (var i = 0; i < 10; i++) {
      processGeneration(elfs, i);

      // Print elf grid
      // print('======== ${i + 1}');
      // for (var x = 0; x < input.getPerLine().length; x++) {
      //   print(Range(0, 14).iterable.map((y) => elfs.firstWhereOrNull((e) => e.pos == Pos(x, y))?.toString() ?? '.').join());
      // }
    }
    
    final allX = elfs.map((e) => e.pos.x);
    final allY = elfs.map((e) => e.pos.y);

    int minX = allX.min, maxX = allX.max;
    int minY = allY.min, maxY = allY.max;

    final elfsPositions = elfs.map((e) => e.pos).toSet();
    int count = 0;
    for (var x = minX; x <= maxX; x++) {
      for (var y = minY; y <= maxY; y++) {
        if (!elfsPositions.contains(Pos(x, y))) count++;
      } 
    }

    return count; // 3996
  }

  @override
  int solvePart2() {
    final elfs = parseInput();

    for (var i = 0; i < 10000; i++) {
      processGeneration(elfs, i);

      if (elfs.every((e) => e.proposedPosition == null)) {
        return i + 1;
      }
    }

    throw 'Should not happend';
  }
}

class _Elf {

  Pos pos;
  Pos? proposedPosition;

  _Elf(this.pos);

  evaluateDirection(Set<Pos> occupiedPositions, List<List<Pos>> scanOffsets) {
    final moves = scanOffsets.map((dirs) => dirs.map((p) => p + pos));
    final moveDirection = moves.where((m) => m.every((p) => !occupiedPositions.contains(p)));

    // No possible move or all possible moves
    if (moveDirection.isEmpty || moveDirection.length == moves.length) {
      proposedPosition = null;
    } else {
      proposedPosition = moveDirection.first.first;
    }
  }

  @override
  String toString() => '#';
}

enum ScanDirection { north, south, west, east }

void main(List<String> args) {
  Day23().printSolutions();
}