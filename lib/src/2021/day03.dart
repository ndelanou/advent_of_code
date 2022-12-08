import 'dart:io';
import 'dart:math';

const filename = 'input.txt';
void main(List<String> args) async {
  final file = File('${Platform.script.path.replaceAll('main.dart', filename)}');
  final lines = (await file.readAsString()).split('\n');
  print('lines: ${lines.length}');

  var mostCommons = <int>[];
  var leastCommons = <int>[];

  for (var i = 0; i < lines.first.length; i++) {
    mostCommons.add(mostCommonAtIndex(lines, i));
    leastCommons.add(mostCommonAtIndex(lines, i) == 0 ? 1 : 0);
  }



  final mostCommonNb = intFromBinArray(mostCommons);
  final leastCommonNb = intFromBinArray(leastCommons);

  print(mostCommonNb*leastCommonNb); // 2595824

  List<int>? o2;
  List<int>? co2;

  var tmp1 = lines.toList();
  var tmp2 = lines.toList();
  for (var i = 0; i < lines.first.length; i++) {
    
    if (tmp1.length > 1) {
      final criteria = mostCommonAtIndex(tmp1, i) == 0 ? '0' : '1';
      tmp1 = sublistFromCreteria(tmp1, i, criteria);

      if (tmp1.length == 1) o2 = tmp1.first.split('').map((e) => int.parse(e)).toList();
    }

    if (tmp2.length > 1) {
      final criteria = mostCommonAtIndex(tmp2, i) == 0 ? '1' : '0';
      tmp2 = sublistFromCreteria(tmp2, i, criteria);

      if (tmp2.length == 1) co2 = tmp2.first.split('').map((e) => int.parse(e)).toList();
    }

    print('${tmp1.length} || ${tmp2.length}');

  }

  final o2Nb = intFromBinArray(o2!);
  final co2Nb = intFromBinArray(co2!);
  print(o2);
  print(co2);
  print(o2Nb * co2Nb); // 2135254

}

int mostCommonAtIndex(List<String> input, int index) {
  var count = 0;
  for (var line in input) {
    if (line[index] == '1') count++;
  }
  return count >= (input.length / 2) ? 1 : 0;
}

int intFromBinArray(List<int> input) {
  int acc = 0;
  for (var i = 0; i < input.length; i++) {
    if (input[i] == 1) acc += pow(2, input.length - i - 1).toInt();
  }

  return acc;
}

List<String> sublistFromCreteria(List<String> input, int index, String criteria) {
  return input.where((l) => l[index] == criteria).toList();
}