// import 'package:quiver/iterables.dart';
import 'dart:math';

import 'package:tuple/tuple.dart';

typedef Position = Tuple2<int, int>;

extension PositionExtension on Position {
  Position moved(int dx, int dy) => Position(this.x + dx, this.y + dy);

  Position operator +(Object? other) {
    assert(other is Position);
    return Position((other as Position).x + x, other.y + y);
  }
}

typedef VoidGridCallback = void Function(int x, int y);

/// A helper class for easier work with 2D data.
class Grid<T> {
  Grid(List<List<T>> grid)
      : assert(grid.length > 0),
        assert(grid[0].length > 0),
        // creates a deep copy by value from given grid to prevent unwarranted overrides
        grid = List<List<T>>.generate(
          grid.length,
          (y) => List<T>.generate(grid[0].length, (x) => grid[y][x]),
        ),
        height = grid.length,
        width = grid[0].length;

  final List<List<T>> grid;
  int height;
  int width;

  /// Returns the value at the given position.
  T getValueAtPosition(Position position) => grid[position.y][position.x];

  /// Returns the value at the given coordinates.
  T getValueAt(int x, int y) => getValueAtPosition(Position(x, y));

  /// Sets the value at the given Position.
  setValueAtPosition(Position position, T value) => grid[position.y][position.x] = value;

  /// Sets the value at the given coordinates.
  setValueAt(int x, int y, T value) => setValueAtPosition(Position(x, y), value);

  /// Returns whether the given position is inside of this grid.
  bool isOnGrid(Position position) => position.x >= 0 && position.y >= 0 && position.x < width && position.y < height;

  /// Returns the whole row with given row index.
  Iterable<T> getRow(int row) => grid[row];

  /// Returns the whole column with given column index.
  Iterable<T> getColumn(int column) => grid.map((row) => row[column]);

  Iterable<Iterable<T>> get rows => grid;

  Iterable<Iterable<T>> get columns sync* {
    for (var i = 0; i < rows.first.length; i++) {
      yield grid.map((r) => r[i]);
    }
  }

  /// Executes the given callback for every position on this grid.
  forEach(VoidGridCallback callback) {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        callback(x, y);
      }
    }
  }

  /// Returns the number of occurances of given object in this grid.
  int count(T searched) => grid.expand((element) => element).fold<int>(0, (acc, elem) => elem == searched ? acc + 1 : acc);

  /// Executes the given callback for all given positions.
  forPositions(
    Iterable<Position> positions,
    VoidGridCallback callback,
  ) {
    positions.forEach((position) => callback(position.x, position.y));
  }

  /// Returns all adjacent cells to the given position. This does `NOT` include
  /// diagonal neighbours.
  Iterable<Position> adjacent(int x, int y) {
    return <Position>{
      Position(x, y - 1),
      Position(x, y + 1),
      Position(x - 1, y),
      Position(x + 1, y),
    }..removeWhere((pos) => pos.x < 0 || pos.y < 0 || pos.x >= width || pos.y >= height);
  }

  /// Returns all positional neighbours of a point. This includes the adjacent
  /// `AND` diagonal neighbours.
  Iterable<Position> neighbours(int x, int y) {
    return <Position>{
      // positions are added in a circle, starting at the top middle
      Position(x, y - 1),
      Position(x + 1, y - 1),
      Position(x + 1, y),
      Position(x + 1, y + 1),
      Position(x, y + 1),
      Position(x - 1, y + 1),
      Position(x - 1, y),
      Position(x - 1, y - 1),
    }..removeWhere((pos) => pos.x < 0 || pos.y < 0 || pos.x >= width || pos.y >= height);
  }

  /// Returns a deep copy by value of this [Grid].
  Grid<T> copy() {
    final newGrid = List<List<T>>.generate(
      height,
      (y) => List<T>.generate(width, (x) => grid[y][x]),
    );
    return Grid<T>(newGrid);
  }

  @override
  String toString() {
    String result = '';
    for (final row in grid) {
      for (final elem in row) {
        result += elem.toString();
      }
      result += '\n';
    }
    return result;
  }
}

/// Extension for [Grid]s where [T] is of type [num].
extension NumberGrid<T extends num> on Grid<T> {
  /// Returns the minimum value in this grid.
  T get minValue => grid.expand((element) => element).reduce(min);

  /// Returns the maximum value in this grid.
  T get maxValue => grid.expand((element) => element).reduce(max);
}

/// Extension for [Grid]s where [T] is of type [int].
extension IntegerGrid on Grid<int> {
  /// Increments the values of Position `x` `y`.
  increment(int x, int y) => this.setValueAt(x, y, this.getValueAt(x, y) + 1);

  /// Convenience method to create a Field from a single String, where the
  /// String is a "block" of integers.
  static Grid<int> fromString(String string, {String characterSeparator = ''}) {
    final lines = string.split('\n').map((line) => line.trim().split(characterSeparator).map(int.parse).toList()).toList();
    return Grid(lines);
  }
}

extension CoordinateLocator on Position {
  int get x => item1;
  int get y => item2;
}
