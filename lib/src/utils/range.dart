import 'dart:math';

typedef Range<T> = ({T from, T to});

extension NumExt<T> on Range<T> {
  Range<T> fromList(Iterable<T> list) {
    assert(list.length == 2, 'List length must be equal to 2');
    return (from: list.first, to: list.last);
  }

  Range copyWith({T? from, T? to}) {
    return (
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}

extension NumRangeExt<T extends num> on Range<T> {
  T get lower => min(from, to);
  T get upper => max(from, to);

  bool contains(Range<T> other) {
    return other.lower >= lower && other.upper <= upper;
  }

  bool overlapWith(Range<T> other) {
    return !(upper < other.lower || lower > other.upper);
  }
}

extension IntRangeExt on Range<int> {
  Iterable<int> get iterable sync* {
    int inc = from < to ? 1 : -1;
    final limit = (to + inc);
    for (var i = from; i != limit; i += inc) yield i;
  }
}

extension IntListRangeExt on Iterable<Range<int>> {
  Iterable<Range<int>> simplify() {
    if (length < 2) return this;

    var currentList = this;

    var modified = true;
    while (modified) {
      modified = false;
      final sorted = currentList.toList()
        ..sort((a, b) {
          if (a.from == b.from) return a.to.compareTo(b.to);
          return a.from.compareTo(b.from);
        });

      for (var i = 0; i < sorted.length - 1; i++) {
        final current = sorted[i];
        final next = sorted[i + 1];

        if (current.overlapWith(next)) {
          final newRange = (from: min(current.lower, next.lower), to: max(current.upper, next.upper));
          currentList = sorted
            ..remove(current)
            ..remove(next)
            ..add(newRange);

          modified = true;
          break;
        }
      }
    }
    return currentList;
  }
}

void main(List<String> args) {
  final input = [(from: 5, to: 11), (from: 2, to: 7), (from: 50, to: 56), (from: 2, to: 4)];
  print(input.simplify().toList());
}
