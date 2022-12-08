import 'dart:io';

import 'package:collection/collection.dart';

const filename = 'input.txt';

void main() async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  final filesSizeMap = <String, int>{};

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

  final totalSizeMap = <String, int>{};

  int getDirSize(String path) {
    final subs = filesSizeMap.keys.where((k) => k.startsWith(path) && (path.split('/').length == k.split('/').length - 1));
    if (subs.length == 0) {
      totalSizeMap[path] = filesSizeMap[path]!;
    } else {
      totalSizeMap[path] = subs.fold(0, (acc, element) => acc += getDirSize(element)) + (filesSizeMap[path] ?? 0);
    }
    return totalSizeMap[path]!;
  }

  final usedSpace = getDirSize('/');

  int sumUnder100k = 0;
  totalSizeMap.forEach((key, value) {
    if (value <= 100000) sumUnder100k += value;
  });

  print(sumUnder100k); // 1667443

  // Part 2
  final totalSpace = 70000000;
  final availableSpace = totalSpace - usedSpace;
  final neededSpace = 30000000 - availableSpace;
  
  final minFileSize = totalSizeMap.values.where((element) => element > neededSpace).toList().min;
  print(minFileSize); // 8998590

}
