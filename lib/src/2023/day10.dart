import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

enum _Pipe {
  start('S', 'S'),
  none('.', ' '),
  horizontal('-', '─'),
  vertical('|', '|'),
  topLeft('J', '┘'),
  topRight('L', '└'),
  bottomLeft('7', '┐'),
  bottomRight('F', '┌');

  const _Pipe(this.char, this.displayChar);

  final String char;
  final String displayChar;

  static _Pipe fromChar(String char) {
    return _Pipe.values.firstWhere((e) => e.char == char);
  }

  String toString() => displayChar;
}

enum _Direction { top, bottom, left, right }

class Day10 extends GenericDay {
  Day10() : super(2023, 10);

  @override
  Grid<_Pipe> parseInput() {
    return Grid(
      input
          .getPerLine()
          .map(
            (line) => line.split('').map(_Pipe.fromChar).toList(),
          )
          .toList(),
    );
  }

  @override
  int solvePart1() {
    final grid = parseInput();

    final positions = getLoopPath(grid);

    return (positions.length - 1) ~/ 2;
  }

  List<Position> getLoopPath(Grid<_Pipe> grid) {
    final start = grid.getStartPosition();

    var positions = [start];
    var direction = _Direction.bottom;
    do {
      direction = grid.nextDirection(positions.last, previousDirection: direction);
      positions.add(grid.nextPosition(positions.last, direction: direction));
    } while (grid.getValueAtPosition(positions.last) != _Pipe.start);

    return positions;
  }

  @override
  int solvePart2() {
    final grid = parseInput();

    final positions = getLoopPath(grid);

    final columnLength = grid.columns.first.length;
    int innerTileCount = 0;

    for (var y = 0; y < columnLength; y++) {
      bool inLoop = false;
      _Direction? hold = null;
      for (var x = 0; x < grid.rows.first.length; x++) {
        final pos = Position(x, y);
        final tile = grid.getValueAtPosition(pos);

        final isPartOfPath = positions.contains(pos);
        if (isPartOfPath) {
          if (tile == _Pipe.vertical) {
            inLoop = !inLoop;
            continue;
          }

          if (hold == null) {
            hold = (tile == _Pipe.topRight) ? _Direction.top : _Direction.bottom;
            continue;
          }

          if ((hold == _Direction.top && tile == _Pipe.bottomLeft) || (hold == _Direction.bottom && tile == _Pipe.topLeft)) {
            inLoop = !inLoop;
            hold = null;
            continue;
          }

          if ((hold == _Direction.top && tile == _Pipe.topLeft) || (hold == _Direction.bottom && tile == _Pipe.bottomLeft)) {
            hold = null;
            continue;
          }
        } else {
          if (inLoop) {
            innerTileCount++;
          }
        }
      }
    }

    return innerTileCount;
  }
}

void main() {
  Day10().printSolutions();
}

extension _PipeGridExt on Grid<_Pipe> {
  Position getStartPosition() {
    final columnLength = columns.first.length;
    for (var x = 0; x < rows.first.length; x++) {
      for (var y = 0; y < columnLength; y++) {
        if (getValueAt(x, y) == _Pipe.start) {
          return Position(x, y);
        }
      }
    }
    throw Exception('No start position found');
  }

  _Direction nextDirection(Position current, {required _Direction previousDirection}) {
    final pipe = this.getValueAtPosition(current);
    return switch (pipe) {
      _Pipe.vertical => previousDirection,
      _Pipe.horizontal => previousDirection,
      _Pipe.topLeft when previousDirection == _Direction.bottom => _Direction.left,
      _Pipe.topLeft when previousDirection == _Direction.right => _Direction.top,
      _Pipe.topRight when previousDirection == _Direction.bottom => _Direction.right,
      _Pipe.topRight when previousDirection == _Direction.left => _Direction.top,
      _Pipe.bottomLeft when previousDirection == _Direction.top => _Direction.left,
      _Pipe.bottomLeft when previousDirection == _Direction.right => _Direction.bottom,
      _Pipe.bottomRight when previousDirection == _Direction.top => _Direction.right,
      _Pipe.bottomRight when previousDirection == _Direction.left => _Direction.bottom,
      _Pipe.start => previousDirection,
      _ => throw Exception('Impossible'),
    };
  }

  Position nextPosition(Position current, {required _Direction direction}) {
    return switch (direction) {
      _Direction.left => Tuple2(current.x - 1, current.y),
      _Direction.right => Tuple2(current.x + 1, current.y),
      _Direction.top => Tuple2(current.x, current.y - 1),
      _Direction.bottom => Tuple2(current.x, current.y + 1),
    };
  }
}
