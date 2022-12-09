import '../utils/utils.dart';

class Day09 extends GenericDay {
  Day09() : super(2022, 9);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final instructions = parseInput();
    final Set<Position> tailPositionsHistory = {Position(0, 0)};
    Position head = Position(0, 0);
    Position tail = Position(0, 0);

    for (var instruction in instructions) {
      final iSplits = instruction.split(' ');
      final headMoveDirection = iSplits[0];
      final headMoveAmount = int.parse(iSplits[1]);

      // Move head
      for (var i = 0; i < headMoveAmount; i++) {
        final headMove = move(headMoveDirection, 1);
        head = addPos(head, headMove);

        final xDiff = (head.x - tail.x);
        final yDiff = (head.y - tail.y);

        if (xDiff.abs() > 1 || yDiff.abs() > 1) {
          tail = computeTailPosition(xDiff, yDiff, head);
          tailPositionsHistory.add(tail);
        }
      }
    }

    return tailPositionsHistory.length; // 6081
  }

  Position move(String moveLetter, int amount) {
    if (moveLetter == 'L') return Position(-amount, 0);
    if (moveLetter == 'R') return Position(amount, 0);
    if (moveLetter == 'U') return Position(0, amount);
    if (moveLetter == 'D') return Position(0, -amount);
    throw 'illegla move';
  }

  Position computeTailPosition(int xDiff, int yDiff, Position head) {
    int x;
    int y;

    if (xDiff.abs() <= 1) {
      x = head.x;
    } else {
      x = head.x - xDiff.sign;
    }

    if (yDiff.abs() <= 1) {
      y = head.y;
    } else {
      y = head.y - yDiff.sign;
    }

    return Position(x, y);
  }

  addPos(Position a, Position b) {
    return Position(a.x + b.x, a.y + b.y);
  }

  @override
  int solvePart2() {
    final instructions = parseInput();
    final Set<Position> tailPositionsHistory = {Position(0, 0)};
    Position masterHead = Position(0, 0);
    List<Position> tails = List.generate(9, (index) => Position(0, 0));

    for (var instruction in instructions) {
      final iSplits = instruction.split(' ');
      final headMoveDirection = iSplits[0];
      final headMoveAmount = int.parse(iSplits[1]);

      for (var i = 0; i < headMoveAmount; i++) {
        // Move head
        final headMove = move(headMoveDirection, 1);
        masterHead = addPos(masterHead, headMove);

        for (var j = 0; j < tails.length; j++) {
          final head = j == 0 ? masterHead : tails[j - 1];
          final tail = tails[j];
          final xDiff = (head.x - tail.x);
          final yDiff = (head.y - tail.y);

          if (xDiff.abs() > 1 || yDiff.abs() > 1) {
            final newTail = computeTailPosition(xDiff, yDiff, head);
            tails[j] = newTail;

            if (j == tails.length - 1) {
              tailPositionsHistory.add(newTail);
            }
          }
        }
      }
    }

    return tailPositionsHistory.length; // 2487
  }
}
