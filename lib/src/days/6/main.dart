import 'dart:io';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final input = await file.readAsString();
  
  // Part 1
  print(findMessageKeyIndex(input, 4)); // 1804

  // Part 2
  print(findMessageKeyIndex(input, 14)); // 2508
}

int findMessageKeyIndex(String input, int keyLength) {
  for (var i = keyLength; i < input.length; i++) {
    final sub = input.substring(i - keyLength, i);

    if (isMessageKey(sub)) return i;
  }
  return -1;
}

bool isMessageKey(String input) {
  for (var j = 0; j < input.length; j++) {
    final char = input[j];
    if (input.indexOf(char) != input.lastIndexOf(char)) return false;
  }

  return true;
}