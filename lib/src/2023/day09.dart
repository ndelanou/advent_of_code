import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day09 extends GenericDay {
  Day09() : super(2023, 9);

  @override
  List<List<int>> parseInput() {
    return input.getPerLine().map((l) => l.split(' ').map(int.parse).toList()).toList();
  }

  @override
  int solvePart1() {
    final lines = parseInput();
    final predicredValues = <int>[];

    for (final line in lines) {
      final encodedLines = encodeAll(line);
      final decodedLines = decodeAll(encodedLines);

      predicredValues.add(decodedLines.last.last);
    }

    return predicredValues.sum;
  }

  List<int> encode(List<int> line) {
    return [for (var i = 1; i < line.length; i++) line[i] - line[i - 1]];
  }

  List<List<int>> encodeAll(List<int> line) {
    final encodedLines = <List<int>>[line];
    do {
      encodedLines.add(encode(encodedLines.last));
    } while (encodedLines.last.any((element) => element != 0));
    return encodedLines;
  }

  List<List<int>> decodeAll(List<List<int>> encodedLines) {
    final decodedLines = <List<int>>[
      [...encodedLines.last, 0]
    ];
    for (final encodedLine in encodedLines.reversed.skip(1)) {
      decodedLines.add([...encodedLine, encodedLine.last + decodedLines.last.last]);
    }
    return decodedLines;
  }

  List<List<int>> decodeAllP2(List<List<int>> encodedLines) {
    final decodedLines = <List<int>>[
      [0, ...encodedLines.last]
    ];
    for (final encodedLine in encodedLines.reversed.skip(1)) {
      decodedLines.add([encodedLine.first - decodedLines.last.first, ...encodedLine]);
    }
    return decodedLines;
  }

  @override
  int solvePart2() {
    final lines = parseInput();
    final predicredValues = <int>[];

    for (final line in lines) {
      final encodedLines = encodeAll(line);
      final decodedLines = decodeAllP2(encodedLines);

      predicredValues.add(decodedLines.last.first);
    }

    return predicredValues.sum;
  }
}

void main() {
  Day09().printSolutions();
}
