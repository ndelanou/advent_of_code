import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();

  for (var i = 3; i < input.length; i++) {
    final c1 = input[i-3];
    final c2 = input[i-2];
    final c3 = input[i-1];
    final c4 = input[i];

    if (c1 != c2 && c1 != c3 && c1 != c4 && c2 != c3 && c2 != c4 && c3 != c4) {
      print(i + 1); // 1804
      break;
    }
  }

  for (var i = 14; i < input.length; i++) {
    final sub = input.substring(i-14, i);

    var unique = true;

    for (var j = 0; j < sub.length; j++) {
      final char = sub[j];

      final first = sub.indexOf(char);
      final last = sub.lastIndexOf(char);

      if (first != last) {
        unique = false;
        break;
      }
    }

    if (unique) {
      print(i); // 2508
      break;
    }

  }
  
}