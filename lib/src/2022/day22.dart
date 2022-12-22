import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

typedef _Face = Tuple2<Position, Position>;

class Day22 extends GenericDay {
  Day22() : super(2022, 22);

  @override
  Tuple2<Grid<String>, List> parseInput() {
    final lines = input.getPerLine();
    final grid = Grid(lines.take(lines.length - 2).map((e) => e.split('').toList()).toList());
    final instructions = [];
    String tmp = '';
    for (var char in lines.last.codeUnits) {
      if (char > _a && char < _z) {
        if (tmp.isNotEmpty) {
          instructions.add(int.parse(tmp));
          tmp = '';
        }
        instructions.add(String.fromCharCode(char));
      } else {
        tmp += String.fromCharCode(char);
      }
    }
    if (tmp.isNotEmpty) {
      instructions.add(int.parse(tmp));
    }
    return Tuple2(grid, instructions);
  }

  final _a = 'A'.codeUnits.first;
  final _z = 'Z'.codeUnits.first;

  final facings = [Position(1, 0), Position(0, 1), Position(-1, 0), Position(0, -1)];

  @override
  int solvePart1() {
    final inputResult = parseInput();
    final grid = inputResult.item1;
    final instructions = inputResult.item2;

    Position currentPosition = Position(grid.rows.first.toList().indexOf('.'), 0);
    int facingIndex = 0;
    for (final instr in instructions) {
      if (['L', 'R'].contains(instr)) {
        facingIndex = (instr == 'R' ? facingIndex + 1 : facingIndex - 1) % facings.length;
      } else {
        for (var i = 0; i < (instr as int); i++) {
          final facing = facings[facingIndex];
          Position targetPosition = currentPosition.moved(facing.x, facing.y);
          String targetValue = grid.isOnGrid(targetPosition) ? grid.getValueAtPosition(targetPosition) : ' ';
          if (targetValue == ' ') {
            targetPosition = wrap(grid, currentPosition, facing);
            targetValue = grid.getValueAtPosition(targetPosition);
          }

          if (targetValue == '.') {
            currentPosition = targetPosition;
          } else if (targetValue == '#') {
            break;
          }
        }
      }
    }
    
    return 1000 * (currentPosition.y + 1) + 4 * (currentPosition.x + 1) + facingIndex;
  }

  Position wrap(Grid grid, Position currentPosition, Position facing) {
    final opositeFacing = Position(-facing.x, -facing.y);
    Position wrapPosition = currentPosition.moved(opositeFacing.x, opositeFacing.y);
    while(grid.isOnGrid(wrapPosition) && grid.getValueAtPosition(wrapPosition) != ' ') {
      wrapPosition = wrapPosition.moved(opositeFacing.x, opositeFacing.y);
    }
    return wrapPosition.moved(facing.x, facing.y);
  }

  @override
  int solvePart2() {
    final inputResult = parseInput();
    final grid = inputResult.item1;
    final instructions = inputResult.item2;

    final cubeFaces = getCubeFaces(grid);

    Position currentPosition = Position(grid.rows.first.toList().indexOf('.'), 0);
    int facingIndex = 0;
    for (final instr in instructions) {
      int targetFacing = facingIndex;
      if (['L', 'R'].contains(instr)) {
        facingIndex = (instr == 'R' ? facingIndex + 1 : facingIndex - 1) % facings.length;
      } else {
        for (var i = 0; i < (instr as int); i++) {
          final facing = facings[facingIndex];
          Position targetPosition = currentPosition.moved(facing.x, facing.y);
          String targetValue = grid.isOnGrid(targetPosition) ? grid.getValueAtPosition(targetPosition) : ' ';
          if (targetValue == ' ') {
            final wrapResult = wrapCube(currentPosition, facingIndex, cubeFaces);
            targetPosition = wrapResult.item1;
            targetFacing = wrapResult.item2;
            targetValue = grid.getValueAtPosition(targetPosition);
          }

          if (targetValue == '.') {
            currentPosition = targetPosition;
            facingIndex = targetFacing;
          } else if (targetValue == '#') {
            break;
          }
        }
      }
    }
    
    return 1000 * (currentPosition.y + 1) + 4 * (currentPosition.x + 1) + facingIndex; // ??? | 171035
  }

  List<_Face> getCubeFaces(Grid grid) {
    final tmp = <_Face>[];
    final faceSize = grid.height == 200 ? 50 : 4;
    for (var y = 0; y < grid.height; y+=faceSize) {
      for (var x = 0; x < grid.width; x+=faceSize) {
        final pos = Position(x, y);
        if (grid.getValueAtPosition(pos) != ' ') {
          tmp.add(Tuple2(pos, Position(pos.x + faceSize - 1, pos.y + faceSize - 1)));
        }
      }
    }

    return tmp;
  }


  Tuple2<Position, int> wrapCube(Position currentPosition, int facingIndex, List<_Face> faces) {
    final startingFaceIndex = faces.indexWhere((c) => c.item1.x <= currentPosition.x && c.item1.y <= currentPosition.y && c.item2.x >= currentPosition.x && c.item2.y >= currentPosition.y);
    final startingFace = faces[startingFaceIndex];

    final adjFace =  hardCodedFacesInput[startingFaceIndex]![facingIndex];
    final relativePos = Position(currentPosition.x - startingFace.item1.x, currentPosition.y - startingFace.item1.y);
    final newFacing = adjFace.item2;
    final newFacingIndex = facings.indexOf(newFacing);
    final newFace = faces[adjFace.item1];

    final faceSize = newFace.item2.x - newFace.item1.x;
    int i; 
    if (facingIndex == 0) {
      if (newFacingIndex == 1 || newFacingIndex == 2) {
        i = faceSize - relativePos.y;
      } else if (newFacingIndex == 3 || newFacingIndex == 0) {
        i = relativePos.y;
      } else {
        throw 'Should not happend';
      }
    } else if (facingIndex == 1) {
      if (newFacingIndex == 0 || newFacingIndex == 3) {
        i = faceSize - relativePos.x;
      } else if (newFacingIndex == 2 || newFacingIndex == 1) {
        i = relativePos.x;
      } else {
        throw 'Should not happend';
      }
    } else if (facingIndex == 2) {
      if (newFacingIndex == 1 || newFacingIndex == 2) {
        i = relativePos.y;
      } else if (newFacingIndex == 3 || newFacingIndex == 0) {
        i = faceSize - relativePos.y;
      } else {
        throw 'Should not happend';
      }
    } else if (facingIndex == 3) {
      if (newFacingIndex == 0 || newFacingIndex == 3) {
        i = relativePos.x;
      } else if (newFacingIndex == 2 || newFacingIndex == 1) {
        i = faceSize - relativePos.x;
      } else {
        throw 'Should not happend';
      }
    } else {
      throw 'Should not happend';
    }

    final newX = [0, i, faceSize, i][newFacingIndex];
    final newY = [i, 0, i, faceSize][newFacingIndex];
    return Tuple2(Position(newFace.item1.x + newX, newFace.item1.y + newY), newFacingIndex);
  }

  final hardCodedFacesExample = {
    0: [
      Tuple2(5, Position(-1, 0)),
      Tuple2(3, Position(0, 1)),
      Tuple2(2, Position(0, 1)),
      Tuple2(1, Position(0, 1)),
    ],
    1: [
      Tuple2(2, Position(1, 0)),
      Tuple2(4, Position(0, -1)),
      Tuple2(5, Position(0, -1)),
      Tuple2(0, Position(0, 1)),
    ],
    2: [
      Tuple2(3, Position(1, 0)),
      Tuple2(4, Position(1, 0)),
      Tuple2(1, Position(-1, 0)),
      Tuple2(0, Position(1, 0)),
    ],
    3: [
      Tuple2(5, Position(0, 1)),
      Tuple2(4, Position(0, 1)),
      Tuple2(2, Position(-1, 0)),
      Tuple2(0, Position(0, -1)),
    ],
    4: [
      Tuple2(5, Position(1, 0)),
      Tuple2(1, Position(0, -1)),
      Tuple2(2, Position(0, -1)),
      Tuple2(3, Position(0, -1)),
    ],
    5: [
      Tuple2(0, Position(-1, 0)),
      Tuple2(1, Position(1, 0)),
      Tuple2(4, Position(-1, 0)),
      Tuple2(3, Position(-1, 0)),
    ],
  };

  final hardCodedFacesInput = {
    0: [
      Tuple2(1, Position(1, 0)),
      Tuple2(2, Position(0, 1)),
      Tuple2(3, Position(1, 0)),
      Tuple2(5, Position(1, 0)),
    ],
    1: [
      Tuple2(4, Position(-1, 0)),
      Tuple2(2, Position(-1, 0)),
      Tuple2(0, Position(-1, 0)),
      Tuple2(5, Position(0, -1)),
    ],
    2: [
      Tuple2(1, Position(0, -1)),
      Tuple2(4, Position(0, 1)),
      Tuple2(3, Position(0, 1)),
      Tuple2(0, Position(0, -1)),
    ],
    3: [
      Tuple2(4, Position(1, 0)),
      Tuple2(5, Position(0, 1)),
      Tuple2(0, Position(1, 0)),
      Tuple2(2, Position(1, 0)),
    ],
    4: [
      Tuple2(1, Position(-1, 0)),
      Tuple2(5, Position(-1, 0)),
      Tuple2(3, Position(-1, 0)),
      Tuple2(2, Position(0, -1)),
    ],
    5: [
      Tuple2(4, Position(0, -1)),
      Tuple2(1, Position(0, 1)),
      Tuple2(0, Position(0, 1)),
      Tuple2(3, Position(0, -1)),
    ],
  };

}

