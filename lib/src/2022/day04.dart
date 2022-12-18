import '../utils/utils.dart';

class Day04 extends GenericDay {
  Day04() : super(2022, 4);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  solvePart1() {
    final lines = parseInput();
    
    int contained = 0;
  
    final pairs = lines.map((l) => l.split(',').map((r) {
    final range = r.split('-').map((b) => int.parse(b));
      return Range.fromList(range);
    }));

    for (var pair in pairs) {
      final r1 = pair.elementAt(0);
      final r2 = pair.elementAt(1);

      if (r1.contains(r2) || r2.contains(r1)) contained++;
    }

    return contained; // 530
  }

  @override
  solvePart2() {
    final lines = parseInput();
    
    int overlaps = 0;
    
    final pairs = lines.map((l) => l.split(',').map((r) {
      final range = r.split('-').map((b) => int.parse(b));
      return Range.fromList(range);
    }));

    for (var pair in pairs) {
      final r1 = pair.elementAt(0);
      final r2 = pair.elementAt(1);

      if (r1.overlapWith(r2)) overlaps++;
    }

    return overlaps; // 903
  }
}
