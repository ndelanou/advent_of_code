import '../utils/utils.dart';

class Day06 extends GenericDay {
  Day06() : super(2021, 6);

  @override
  List<int> parseInput() {
    return input.getBy(',').map((e) => int.parse(e.trim())).toList();
  }

  int computeFishPopulation(List<int> initial, int days) {
    Map<int, int> fishes = initial.fold({}, (previousValue, element) {
      previousValue[element] = (previousValue[element] ?? 0) + 1;
      return previousValue;
    });
    fishes[9] = 0;

    for (var i = 0; i < days; i++) {
      final newFishes = fishes[0] ?? 0;
      for (var key in Range(0, 8).iterable.toList()) {
        if (key == 0) continue;
        fishes[key - 1] = fishes[key] ?? 0;
      }

      fishes[6] = (fishes[6] ?? 0) + newFishes;
      fishes[8] = newFishes;
    }

    return fishes.values.fold(0, (previousValue, element) => previousValue + element);
  }

  @override
  int solvePart1() {
    final initialFishes = parseInput();
    return computeFishPopulation(initialFishes, 80);
  }

  @override
  int solvePart2() {
    final initialFishes = parseInput();
    return computeFishPopulation(initialFishes, 256);
  }
}

