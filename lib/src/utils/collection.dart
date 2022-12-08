// TODO:
Iterable<int> range(int startOrEnd, [int? end, int step = 1]) sync* {
  int value = (end != null) ? startOrEnd : 0;
  end ??= startOrEnd;
  if (end > value) {
    while (value < end) {
      yield value;
      value += step;
    }
  } else {
    while (value > end) {
      yield value;
      value -= step;
    }
  }
}