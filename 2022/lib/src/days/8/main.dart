import 'dart:io';
import 'dart:math' as math;

import 'package:collection/collection.dart';

const filename = 'input.txt';

void main() async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  final trees = lines.map((l) => l.split('').map((s) => int.parse(s)).toList()).toList();

  // Part 1 - 1
  int sum = 0;

  final List<Pair> seenTrees = [];

  int max;

  for (var i = 0; i < trees.length; i++) {
    final y = i;
    
    max = -1;
    for (var j = 0; j < trees[i].length; j++) {

      final x = j;

      final tree = trees[x][y];
      if (tree > max) {
        if (!seenTrees.contains(Pair(x,y))) {
          sum++;
          seenTrees.add(Pair(x,y));
        }
        max = tree;
      } 
    }

    max = -1;
    for (var j = 0; j < trees[i].length; j++) {

      final x = trees[i].length - 1 - j;

      final tree = trees[x][y];
      if (tree > max) {
        if (!seenTrees.contains(Pair(x,y))) {
          sum++;
          seenTrees.add(Pair(x,y));
        }
        max = tree;
      }
    }

  }

  for (var i = 0; i < trees.first.length; i++) {
    final x = i;
    
    max = -1;
    for (var j = 0; j < trees[i].length; j++) {

      final y = j;

      final tree = trees[x][y];
      if (tree > max) {
        if (!seenTrees.contains(Pair(x,y))) {
          sum++;
          seenTrees.add(Pair(x,y));
        }
        max = tree;
      }
    }

    max = -1;
    for (var j = 0; j < trees[i].length; j++) {

      final y = trees.length - 1 - j;

      final tree = trees[x][y];
      if (tree > max) {
        if (!seenTrees.contains(Pair(x,y))) {
          sum++;
          seenTrees.add(Pair(x,y));
        }
        max = tree;
      }
    }

  }

  // Part 1 - 2
  int sum2 = 0;
  for (var i = 0; i < trees.length; i++) {
    for (var j = 0; j < trees[i].length; j++) {
      final tree = trees[i][j];
      if (i == 0 || i == trees.length - 1 || j == 0 || j == trees[i].length - 1) {
        sum2++;
        continue;
      }
      final clearL = trees[i].sublist(0,j).every((s) => tree > s);
      final clearR = trees[i].sublist(j+1,trees[i].length).every((s) => tree > s);

      final clearT = trees.map((r) => r[j]).toList().sublist(0,i).every((s) => tree > s);
      final clearB = trees.map((r) => r[j]).toList().sublist(i+1, trees.length).every((s) => tree > s);
      
      if (clearL || clearR || clearT || clearB) {
        sum2++;
      }
    } 
  }

  print(sum); // 1854
  print(sum2); // 1854

  // Part 2
  int maxScore = 0;
  for (var i = 0; i < trees.length; i++) {
    for (var j = 0; j < trees[i].length; j++) {
      final tree = trees[i][j];
      
      final left = trees[i].sublist(0,j).reversed.toList();
      final right = trees[i].sublist(j+1,trees[i].length);
      final top = trees.map((r) => r[j]).toList().sublist(0,i).reversed.toList();
      final bottom = trees.map((r) => r[j]).toList().sublist(i+1, trees.length);

      int leftScore = nbUnderSize(left, tree);
      int rightScore = nbUnderSize(right, tree);
      int topScore = nbUnderSize(top, tree);
      int bottomScore = nbUnderSize(bottom, tree);

      int score = safeFromZero(leftScore) * safeFromZero(rightScore) * safeFromZero(topScore) * safeFromZero(bottomScore);

      maxScore = math.max(maxScore, score);
    } 
  }

  print(maxScore); // 527340

}

nbUnderSize(List<int> list, int size) {
  if (list.length == 0) return 1;
  final index = list.indexWhere((t) => t >= size);
  if (index == -1) return list.length;
  if (index == 0) return 1;
  return index + 1;
}

int safeFromZero(int input) {
  if (input == 0) return 1;
  else return input;
}

class Pair {
  const Pair(this.x, this.y);
  
  final int x;
  final int y;

  @override
  bool operator ==(other) => (other as Pair).x == x && (other as Pair).y == y;
}
