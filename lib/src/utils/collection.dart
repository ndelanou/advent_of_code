extension IterableExtensions<T> on Iterable<T> {

  int quantify(bool Function(T) test) => where(test).length;

  // TODO: test against `sublist`
  Iterable<Iterable<T>> partition(int size) sync* {
    if (length <= size) {
      yield this;
    } else {
      final Iterator<T> iter = iterator;
      List<T> current = <T>[];
      int count = 0;
      while (iter.moveNext()) {
        current.add(iter.current);
        count++;
        if (count == size) {
          yield current;
          current = <T>[];
          count = 0;
        }
      }
      if (current.isNotEmpty) {
        yield current;
      }
    }
  }

}