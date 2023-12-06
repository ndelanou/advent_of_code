import '../utils/utils.dart';

typedef Race = ({int time, int distance});

class Day06 extends GenericDay {
  Day06() : super(2023, 6);

  @override
  List<Race> parseInput() {
    final lines = input.getPerLine();
    final times = lines[0].split(RegExp(r'(\s)+')).skip(1).map(int.parse).toList();
    final dist = lines[1].split(RegExp(r'(\s)+')).skip(1).map(int.parse).toList();

    final races = <Race>[];

    for (var i = 0; i < times.length; i++) {
      races.add((time: times[i], distance: dist[i]));
    }

    return races;
  }

  @override
  int solvePart1() {
    final races = parseInput();

    final potentialRecords = races.map(getNumberOfPotentialRecords).toList();

    final score = potentialRecords.fold(1, (previousValue, element) => previousValue * element);

    return score;
  }

  int getNumberOfPotentialRecords(Race race) {
    int count = 0;
    for (var i = 0; i <= race.time; i++) {
      if ((race.time - i) * i > race.distance) count++;
    }

    return count;
  }

  @override
  int solvePart2() {
    final races = parseInput();

    final time = int.parse(races.map((e) => e.time).join());
    final distance = int.parse(races.map((e) => e.distance).join());
    final race = (time: time, distance: distance);

    final potentialRecords = getNumberOfPotentialRecords(race);

    return potentialRecords;
  }
}

void main(List<String> args) {
  Day06().printSolutions();
}
