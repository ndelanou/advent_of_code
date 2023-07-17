import 'dart:io';

/// Automatically reads reads the contents of the input file for given [day]. \
/// Note that file name and location must align.
class InputParser {
  final String _inputAsString;
  final List<String> _inputAsList;

  InputParser(int year, int day)
      : _inputAsString = _readInputDay(year, day),
        _inputAsList = _readInputDayAsList(year, day);

  static String _createInputPath(int year, int day) {
    String dayString = day.toString().padLeft(2, '0');
    return './input/$year/day$dayString.txt';
  }

  static String _readInputDay(int year, int day) {
    return _readInput(_createInputPath(year, day));
  }

  static String _readInput(String input) {
    return File(input).readAsStringSync();
  }

  static List<String> _readInputDayAsList(int year, int day) {
    return _readInputAsList(_createInputPath(year, day));
  }

  static List<String> _readInputAsList(String input) {
    return File(input).readAsLinesSync();
  }

  /// Returns input as one String.
  String get asString => _inputAsString;

  /// Reads the entire input contents as lines of text.
  List<String> getPerLine() => _inputAsList;

  /// Splits the input String by `whitespace` and `newline`.
  List<String> getPerWhitespace() {
    return _inputAsString.split(RegExp(r'\s\n'));
  }

  /// Splits the input String by given pattern.
  List<String> getBy(Pattern pattern) {
    return _inputAsString.split(pattern);
  }
}
