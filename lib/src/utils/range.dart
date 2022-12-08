import 'dart:math';

class Range<T extends num> {
  final T from, to;

  late T lower = min(from, to);
  late T upper = max(from, to);

  Range(this.from, this.to);

  factory Range.fromList(Iterable<T> list) {
    assert(list.length == 2, 'List length must be equal to 2');
    return Range(list.elementAt(0), list.elementAt(1));
  }

  bool contains(Range other) {
    return other.lower >= lower && other.upper <= upper;
  }

  bool overlapWith(Range other) {
    return !(upper < other.lower || lower > other.upper);
  }

  Range copyWith({T? from, T? to}) {
    return Range(from ?? this.from, to ?? this.to);
  }
}

extension IntRange on Range<int> {
  Iterable<int> get iterable {
    int inc = from < to ? 1 : -1;
    return [for(var i=from; i!=(to + inc); i += inc) i];
  }
}