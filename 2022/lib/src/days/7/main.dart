import 'dart:io';

const filename = 'input.txt';
void main() async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();

  final lines = input.split('\n');
  print('lines: ${lines.length}');

  final sizeMap = <String, int>{};

  String currentPath = '/';
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    // print(line);

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
        sizeMap[currentPath] = (sizeMap[currentPath] ?? 0) + int.parse(splits[0]);
      } else {
        if (!sizeMap.containsKey(currentPath)) {
          sizeMap[currentPath] = 0;
        }
      }
      
    }
  }

  print(lines.where((element) => element.startsWith('dir ')).length);
  print(sizeMap.length);


  final totalSizeMap = <String, int>{};

  int getDirSize(String path) {
    final regExp = RegExp('\/');
    final subs = sizeMap.keys.where((k) => k.startsWith(path) && (regExp.allMatches(path).length == (regExp.allMatches(k).length - 1)));
    print(path);
    print(subs);
    print('=====');
    if (subs.length == 0) {
      totalSizeMap[path] = sizeMap[path] ?? 0;
    } else {
      // print('$path $subs');
      totalSizeMap[path] = subs.fold(0, (acc, element) => acc += getDirSize(element)) + (sizeMap[path] ?? 0);
    }
    return totalSizeMap[path]!;
  }

  final total = getDirSize('/');

  print(total);
  print(totalSizeMap['/']);

  int sumUnder100k = 0;
  totalSizeMap.forEach((key, value) {
    if (value <= 100000) sumUnder100k += value;
  });

  print(sumUnder100k); // 1992920704, 1659984, 1149061, 1360669, 1756112,
  
}
  

