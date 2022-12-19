import 'input_parser.dart';

/// Provides the [InputUtil] for given day and a [printSolution] method to show
/// the puzzle solutions for given day.
abstract class GenericDay {
  final int year;
  final int day;
  final InputParser input;

  GenericDay(this.year, this.day)
      : input = InputParser(year, day);

  dynamic parseInput();
  dynamic solvePart1();
  dynamic solvePart2();

  void printSolutions() {
    // input warmup
    parseInput();
    
    print("-------------------------");
    print("         Day $day        ");
    final stopwatch = Stopwatch()..start();
    print("Solution for puzzle one: ${solvePart1()}");
    print(">>> ${stopwatch.elapsed}");
    stopwatch.reset();
    print("Solution for puzzle two: ${solvePart2()}");
    print(">>> ${stopwatch.elapsed}");
    print("\n");
  }
}