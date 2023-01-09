
import 'package:collection/collection.dart';

import '../utils/utils.dart';

class Day16 extends GenericDay {
  Day16() : super(2021, 16);

  @override
  Packet parseInput() {
    final chars = input.asString.trim().split('');
    final binStr = chars.map((c) => int.parse(c, radix: 16).toRadixString(2).padLeft(4, '0')).join();
    final data = binStr.split('').map((c) => c == '0' ? 0 : 1).toList();

    final parsed = Packet.parse(data, 0);
    return parsed.$0;
  }

  @override
  solvePart1() {
    final rootPacket = parseInput();
    return rootPacket.versionSum;
  }

  @override
  solvePart2() {
    final rootPacket = parseInput();
    return rootPacket.result;
  }
}

void main(List<String> args) {
  Day16().printSolutions();
}

class Packet {
  final int version;
  final int type;
  final dynamic value;

  Packet(this.version, this.type, this.value);

  static (Packet, int) parse(List<int> data, start) {
    final headers = getHeaders(data.sublist(start, start + 6));
    int offset = 6;

    if (headers.$1 == 4) { // literal value
      final parsed = parseLiteralValue(data, start + offset);
      offset += parsed.$1;
      return (Packet(headers.$0, headers.$1, parsed.$0), offset);
      
    } else { // operator packet
      final parsed = parseOperatorPacket(data, start + offset);
      offset += parsed.$1;
      return (Packet(headers.$0, headers.$1, parsed.$0), offset);
    }
  }

  static (int, int) getHeaders(List<int> headerData) {
    return (int.parse(headerData.sublist(0, 3).join(), radix: 2), int.parse(headerData.sublist(3, 6).join(), radix: 2));
  }

  static (int, int) parseLiteralValue(List<int> data, int start) {
    final List<int> parsedValue = [];
    int offset = 0;
    while (true) {
      final r = data.sublist(start + offset, start + offset + 5);
      offset += 5;
      parsedValue.addAll(r.sublist(1, 5));
      if (r.first == 0) {
        return (int.parse(parsedValue.join(), radix: 2), offset);
      }
    }
  }

  static (List<Packet>, int) parseOperatorPacket(List<int> data, int start) {
    final List<Packet> parsedValue = [];
    int offset = 0;
    final ltID = data[start + offset++];
    if (ltID == 0) {
      final length = int.parse(data.sublist(start + offset, start + offset + 15).join(), radix: 2);
      offset += 15;
      int startParseOffset = offset;
      while (offset <startParseOffset + length) {
        final parsed = Packet.parse(data, start + offset);
        offset += parsed.$1;
        parsedValue.add(parsed.$0);
      }
    } else {
      final length = int.parse(data.sublist(start + offset, start + offset + 11).join(), radix: 2);
      offset += 11;
      for (var i = 0; i < length; i++) {
        final parsed = Packet.parse(data, start + offset);
        offset += parsed.$1;
        parsedValue.add(parsed.$0);
      }
    }

    return (parsedValue, offset);
  }

  int get versionSum {
    if (value is List<Packet>) {
      return (value as List<Packet>).map((e) => e.versionSum).sum + version;
    } else {
      return version;
    }
  }

  int get result {
    if (value is List<Packet>) {
      switch (type) {
        case 0:
          return (value as List<Packet>).map((e) => e.result).sum;
        case 1:
          return (value as List<Packet>).map((e) => e.result).fold(1, (acc, element) => acc * element);
        case 2:
          return (value as List<Packet>).map((e) => e.result).min;
        case 3:
          return (value as List<Packet>).map((e) => e.result).max;
        case 5:
          return (value as List<Packet>).first.result > (value as List<Packet>).last.result ? 1 : 0;
        case 6:
          return (value as List<Packet>).first.result < (value as List<Packet>).last.result ? 1 : 0;
        case 7:
          return (value as List<Packet>).first.result == (value as List<Packet>).last.result ? 1 : 0;
        default:
          throw 'Should not happend';
      }
    } else {
      return value as int;
    }
  }
}