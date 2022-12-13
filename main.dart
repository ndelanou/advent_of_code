import 'package:advent_of_code/src/2022/2022.dart';
import 'package:advent_of_code/src/utils/generic_day.dart';


/// List holding all the solution classes.
final days = <GenericDay>[
  Day01(),
  // Day02(),
  // Day03(),
  // Day04(),
  Day05(),
  // Day06(),
  // Day07(),
  Day08(),
  Day09(),
  Day10(),
  Day11(),
  Day12(),
  Day13(),
];

void main(List<String?> args) {
  bool onlyShowLast = true;

  if (args.length == 1 && args[0].isHelperArgument()) {
    printHelper();
    return;
  }

  if (args.length == 1 && args[0].isAllArgument()) {
    onlyShowLast = false;
  }

  onlyShowLast
      ? days.last.printSolutions()
      : days.forEach((day) => day.printSolutions());
}

void printHelper() {
  print(
    '''
Usage: dart main.dart <command>
Global Options:
  -h, --help    Show this help message
  -a, --all     Show all solutions
''',
  );
}

extension ArgsMatcher on String? {
  bool isHelperArgument() {
    return this == '-h' || this == '--help';
  }

  bool isAllArgument() {
    return this == '-a' || this == '--all';
  }
}