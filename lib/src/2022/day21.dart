import '../utils/utils.dart';

class Day21 extends GenericDay {
  Day21() : super(2022, 21);

  @override
  List<Monkey21> parseInput() {
    return input.getPerLine().map((l) {
      final splits = l.split(' ');
      final name = splits[0].substring(0, 4);
      if (splits.length == 2) {
        final number = int.parse(splits[1]);
        return Monkey21(name, number, null, null, null);
      } else {
        return Monkey21(name, null, splits[1], splits[3], splits[2]);
      }
    }).toList();
  }

  @override
  num solvePart1() {
    final monkeys = parseInput();
    
    while (monkeys.firstWhere((m) => m.name == 'root').number == null) {
      for (var m in monkeys) {
        if (m.number == null) {
          final dep1M = monkeys.firstWhere((d) => d.name == m.dep1);
          final dep2M = monkeys.firstWhere((d) => d.name == m.dep2);
          if (dep1M.number != null && dep2M.number != null) {
            m.number = m.execOp(dep1M.number!, dep2M.number!);
          }
        }
      }
    }

    final rootMonkey = monkeys.firstWhere((m) => m.name == 'root');
    return rootMonkey.number!;
  }

  @override
  int solvePart2() {;
    int? result;

    int prevStart = -1;
    num prevDiff = 0;

    int start = 0;
    while (result == null) {
      final diff = rootMonkeyDiff(start, parseInput());

      if (diff == 0) result = start;

      final slope = (diff - prevDiff) / (start - prevStart);
      final newStart = (start - diff / slope).round();

      prevStart = start;
      start = newStart;
      prevDiff = diff;
    }

    return result;
  }

  num rootMonkeyDiff(int humanYelledNumber, List<Monkey21> monkeys) {
      final root = monkeys.firstWhere((m) => m.name == 'root');
      root.operation = '=';
      monkeys.firstWhere((m) => m.name == 'humn').number = humanYelledNumber;

      while (monkeys.firstWhere((m) => m.name == 'root').number == null) {
        for (var m in monkeys) {
          if (m.number == null) {
            final dep1M = monkeys.firstWhere((d) => d.name == m.dep1);
            final dep2M = monkeys.firstWhere((d) => d.name == m.dep2);
            if (dep1M.number != null && dep2M.number != null) {
              m.number = m.execOp(dep1M.number!, dep2M.number!);
            }
          }
        }
      }

      final dep1M = monkeys.firstWhere((d) => d.name == root.dep1);
      final dep2M = monkeys.firstWhere((d) => d.name == root.dep2);
      return dep1M.number! - dep2M.number!;
  }
}

class Monkey21 {
  final String name;
  num? number;
  final String? dep1;
  final String? dep2;
  String? operation;
  
  Monkey21(this.name, this.number, this.dep1, this.dep2, this.operation);

  num execOp(num num1, num num2) {
    if (operation == '+') return num1 + num2;
    if (operation == '-') return num1 - num2;
    if (operation == '*') return num1 * num2;
    if (operation == '/') return num1 / num2;
    if (operation == '=') return num1 == num2 ? 1 : 0;
    throw 'Unsupported operation';
  }
}