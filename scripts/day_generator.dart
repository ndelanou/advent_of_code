import 'dart:async';
import 'dart:io';

/// Small Program to be used to generate files and boilerplate for a given day.\
/// Call with `dart run day_generator.dart <day>`
void main(List<String?> args) async {
  String year = '2023';

  if (args.length > 1) {
    print('Please call with: <dayNumber>');
    exit(1);
  }

  String dayNumber;

  // input through terminal
  if (args.length == 0) {
    print('Please enter a day for which to generate files');
    final input = stdin.readLineSync();
    if (input == null) {
      print('No input given, exiting');
      exit(1);
    }
    // pad day number to have 2 digits
    dayNumber = int.parse(input).toString().padLeft(2, '0');
    // input from CLI call
  } else {
    dayNumber = int.parse(args[0]!).toString().padLeft(2, '0');
  }

  await createDay(
    dayNumber: dayNumber,
    year: year,
  );

  exit(0);
}

Future<void> createDay({required String dayNumber, required String year}) async {
  // inform user
  print('Creating day: $dayNumber');

  // Create lib file
  final dayFileName = 'day$dayNumber.dart';
  unawaited(
    File('lib/src/$year/$dayFileName').writeAsString(dayTemplate(year, dayNumber)),
  );

  final exportFile = File('lib/src/$year/$year.dart');
  final lines = exportFile.readAsLinesSync();
  String content = "export \'$dayFileName\';\n";

  // check if line already exists
  bool found = lines.any((line) => line.contains(dayFileName));

  // export new day in index file if not present
  if (!found) {
    exportFile.writeAsString(
      content,
      mode: FileMode.append,
    );
  }

  // Create input file
  print('Loading input from adventofcode.com...');
  try {
    final request = await HttpClient().getUrl(Uri.parse('https://adventofcode.com/2023/leaderboard/private/view/425912.json'));
    final session = Platform.environment['AOC_SESSION']!;
    request.cookies.add(Cookie("session", session));
    final response = await request.close();
    final dataPath = 'input/$year/day$dayNumber.txt';
    response.pipe(File(dataPath).openWrite());
  } on Error catch (e) {
    print('Error loading file: $e');
  }

  print('All set, Good luck!');
}

String dayTemplate(String year, String dayNumber) {
  return '''
import '../utils/utils.dart';

class Day$dayNumber extends GenericDay {
  Day$dayNumber() : super($year, ${int.parse(dayNumber)});

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final lines = parseInput();
    return lines.length;
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    return lines.length;
  }
}

''';
}
