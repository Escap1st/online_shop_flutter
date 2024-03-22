extension IterableExtension<T> on Iterable<T> {
  Iterable<T> separate(T separator) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return;
    }
    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }

  Iterable<T> indexedSeparate(T Function(int index) separatorBuilder) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return;
    }
    yield iterator.current;
    var index = 0;
    while (iterator.moveNext()) {
      yield separatorBuilder(index++);
      yield iterator.current;
    }
  }
}
