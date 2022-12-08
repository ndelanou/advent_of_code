class Range {
  final num from, to;

  const Range(this.from, this.to) : assert(from <= to);

  factory Range.fromList(Iterable<num> list) {
    assert(list.length == 2, 'List length must be equal to 2');
    return Range(list.elementAt(0), list.elementAt(1));
  }

  bool contains(Range other) {
    return other.from >= from && other.to <= to;
  }

  bool overlapWith(Range other) {
    return !(to < other.from || from > other.to);
  }

  Range copyWith({num? lower, num? upper}) {
    return Range(lower ?? this.from, upper ?? this.to);
  }
}