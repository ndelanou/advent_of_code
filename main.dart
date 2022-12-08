import 'package:advent_of_code/src/2022/day08.dart';
import 'package:advent_of_code/src/utils/generic_day.dart';


/// List holding all the solution classes.
final days = <GenericDay>[
  Day08(),
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