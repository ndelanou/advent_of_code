class Range {
  final num lower, upper;

  const Range(this.lower, this.upper) : assert(lower <= upper);

  factory Range.fromList(Iterable<num> list) {
    assert(list.length == 2, 'List length must be equal to 2');
    return Range(list.elementAt(0), list.elementAt(1));
  }

  bool contains(Range other) {
    return other.lower >= lower && other.lower <= upper && other.upper >= lower && other.upper <= upper;
  }

  bool overlapWith(Range other) {
    return !(upper < other.lower || lower > other.upper);
  }

  Range copyWith({num? lower, num? upper}) {
    return Range(lower ?? this.lower, upper ?? this.upper);
  }
}