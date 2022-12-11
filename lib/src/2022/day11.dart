import '../utils/utils.dart';

import 'package:collection/collection.dart';

class Day11 extends GenericDay {
  Day11() : super(2022, 11);

  @override
  List<Monkey> parseInput() {
    final lines = input.getPerLine().toList();
    final list = <Monkey>[];
    for (var i = 0; i < lines.length; i+=7) {
      final items = lines[i+1].split(' ').skip(4).map((e) => int.parse(e.replaceAll(',', ''))).toList();
      
      final inspectSplits = lines[i+2].split(' ').skip(5).toList();
      final inspectNbLeft = int.tryParse(inspectSplits[0]);
      final inspectNbRight = int.tryParse(inspectSplits[2]);
      final inpectOperation = inspectSplits[1] == '+' ? (int item) => (inspectNbLeft ?? item) + (inspectNbRight ?? item) : (int item) => (inspectNbLeft ?? item) * (inspectNbRight ?? item);

      final testNb = int.parse(lines[i+3].split(' ').last);
      final test = (num item) => (item % testNb) == 0;

      final ifTrue = int.parse(lines[i+4].split(' ').last);
      final ifFalse = int.parse(lines[i+5].split(' ').last);

      list.add(Monkey(items, inpectOperation, test, ifTrue, ifFalse, testNb));
    }
    return list;
  }

  @override
  int solvePart1() {
    final monkeys = parseInput();
    int round = 0;
    while (round < 20) {

      monkeys.forEach((monkey) {
        for (var item in monkey.items) {
          final inpectedItem = monkey.inspectOperation(item);
          final passedItem = (inpectedItem / 3).floor();
          final newMonkeyIndex = monkey.doTest(passedItem);

          monkeys[newMonkeyIndex].items.add(passedItem);

          monkey.inspectedItems++;

        }
        monkey.items = [];
      });

      round++;
    }

    final mostActiveMonkeys = monkeys.sortedBy((element) => element.inspectedItems as num).reversed.take(2).toList();
    return mostActiveMonkeys[0].inspectedItems * mostActiveMonkeys[1].inspectedItems; // 56350
  }

  @override
  int solvePart2() {
    final monkeys = parseInput();
    int round = 0;
    final gcd = monkeys.fold(1, (previousValue, element) => previousValue * element.divisionFactor);
    print(gcd);
    while (round < 10000) {
      
      monkeys.forEach((monkey) {
        for (var item in monkey.items) {
          final inpectedItem = monkey.inspectOperation(item);
          final passedItem = inpectedItem % gcd;
          final newMonkeyIndex = monkey.doTest(passedItem);

          monkeys[newMonkeyIndex].items.add(passedItem);

          monkey.inspectedItems++;

        }
        monkey.items = [];
      });

      round++;
    }

    final mostActiveMonkeys = monkeys.sortedBy((element) => element.inspectedItems as num).reversed.take(2).toList();

    // print(mostActiveMonkeys[0].inspectedItems);
    // print(mostActiveMonkeys[1].inspectedItems);
    return mostActiveMonkeys[0].inspectedItems * mostActiveMonkeys[1].inspectedItems; // 56350
  }
}

class Monkey {
  List<int> items;
  final int Function(int) inspectOperation;
  final bool Function(int item) test;
  final int ifTrueThrowIndex;
  final int ifFalseThrowIndex;

  int divisionFactor;

  int inspectedItems = 0;

  Monkey(this.items, this.inspectOperation, this.test, this.ifTrueThrowIndex, this.ifFalseThrowIndex, this.divisionFactor);

  int doTest(int item) {
    return test(item) ? ifTrueThrowIndex : ifFalseThrowIndex;
  }

}