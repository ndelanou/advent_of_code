import 'package:collection/collection.dart';

import '../utils/utils.dart';

typedef _Input = ({List<bool?> springs, List<int> groups});

class Day12 extends GenericDay {
  Day12() : super(2023, 12);

  @override
  List<_Input> parseInput() {
    return input.getPerLine().map((line) {
      final parts = line.split(' ');
      final springs = parts.first
          .split('')
          .map((c) => switch (c) {
                '.' => true,
                '#' => false,
                _ => null,
              })
          .toList();

      final groups = parts.last.split(',').map(int.parse).toList();
      return (springs: springs, groups: groups);
    }).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput();

    final sum = lines.map((line) {
      final allArrengments = getAllArrengments(line.springs).toList();
      final expectedGroups = line.groups.join(',');

      final validOptions = allArrengments.where((arrengment) => getGroups(arrengment).join(',') == expectedGroups).toList();

      return validOptions.length;
    }).sum;

    return sum;
  }

  Iterable<List<bool>> getAllArrengments(List<bool?> springs) sync* {
    final firstNull = springs.indexOf(null);
    if (firstNull == -1) {
      yield springs.cast<bool>().toList();
    } else {
      yield* getAllArrengments(springs.toList()..[firstNull] = true);
      yield* getAllArrengments(springs.toList()..[firstNull] = false);
    }
  }

  List<int> getGroups(List<bool> springs) {
    int count = 0;
    final groups = <int>[];
    for (var i = 0; i < springs.length; i++) {
      if (!springs[i]) {
        count++;
      } else {
        if (count > 0) {
          groups.add(count);
          count = 0;
        }
      }
    }
    if (count > 0) {
      groups.add(count);
    }
    return groups;
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    return lines.length;
  }
}

void main() {
  Day12().printSolutions();
}
