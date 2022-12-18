import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day07 extends GenericDay {
  Day07() : super(2022, 7);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  final filesSizeMap = <String, int>{};
  final totalSizeMap = <String, int>{};

  @override
  solvePart1() {
    final lines = parseInput();
    

    String currentPath = '/';
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.startsWith('\$ ')){
        final cmd = line.substring(2);

        if (cmd.startsWith('ls')) continue;

        final cd = cmd.substring(2).trim();
        if(cd == '..') {
          final last = currentPath.lastIndexOf('/');
          currentPath = currentPath.substring(0, last);
        } else if (cd == '/') {
          currentPath = '/';
        } else {
          currentPath = currentPath + cd + '/';
        }
      } else {
        final splits = line.split(' ');
        if (splits[0] != 'dir') {
          filesSizeMap[currentPath] = (filesSizeMap[currentPath] ?? 0) + int.parse(splits[0]);
        } else {
          filesSizeMap[currentPath] ??= 0;
        } 
      }
    }

    int sumUnder100k = 0;
    totalSizeMap.forEach((key, value) {
      if (value <= 100000) sumUnder100k += value;
    });

    return sumUnder100k;
  }

  @override
  solvePart2() {
    final usedSpace = getDirSize('/');

    final totalSpace = 70000000;
    final availableSpace = totalSpace - usedSpace;
    final neededSpace = 30000000 - availableSpace;
    
    final minFileSize = totalSizeMap.values.where((element) => element > neededSpace).toList().min;
    return minFileSize;
  }

  int getDirSize(String path) {
    final subs = filesSizeMap.keys.where((k) => k.startsWith(path) && (path.split('/').length == k.split('/').length - 1));
    if (subs.length == 0) {
      totalSizeMap[path] = filesSizeMap[path]!;
    } else {
      totalSizeMap[path] = subs.fold(0, (acc, element) => acc += getDirSize(element)) + (filesSizeMap[path] ?? 0);
    }
    return totalSizeMap[path]!;
  }
}
