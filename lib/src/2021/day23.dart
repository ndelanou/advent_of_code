import '../utils/utils.dart';

enum Amphipod {
  A(1),
  B(10),
  C(100),
  D(1000);

  final int costPerStep;
  const Amphipod(this.costPerStep);

  static Amphipod parse(String value) {
    return switch (value) {
      'A' => Amphipod.A,
      'B' => Amphipod.B,
      'C' => Amphipod.C,
      'D' => Amphipod.D,
      _ => throw Exception('Invalid amphipod: $value'),
    };
  }
}

typedef Room = (Amphipod type, {Amphipod? front, Amphipod? back});

class Day23 extends GenericDay {
  Day23() : super(2021, 23);

  @override
  List<Room> parseInput() {
    final lines = input.getPerLine();
    final frontLine = lines[2];
    final backLine = lines[3];
    final rooms = <Room>[];
    final lineMapping = [
      (3, Amphipod.A),
      (5, Amphipod.B),
      (7, Amphipod.C),
      (9, Amphipod.D),
    ];
    for (final (columnIndex, type) in lineMapping) {
      final front = Amphipod.parse(frontLine[columnIndex]);
      final back = Amphipod.parse(backLine[columnIndex]);

      rooms.add((type, front: front, back: back));
    }
    return rooms;
  }

  @override
  int solvePart1() {
    final state = parseInput();

    print(state);

    return 0;
  }

  @override
  int solvePart2() {
    final state = parseInput();

    return state.length;
  }
}

void main(List<String> args) {
  final day = Day23();
  day.printSolutions();
}
