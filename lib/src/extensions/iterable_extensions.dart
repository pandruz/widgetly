extension IterableExtension<T> on Iterable<T>? {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    if ((this ?? []).isEmpty) {
      return null;
    }
    for (var element in this!) {
      if (test(element)) return element;
    }
    return null;
  }

  /// The first element whose value and index satisfies [test].
  ///
  /// Returns `null` if there are no element and index satisfying [test].
  T? firstWhereIndexedOrNull(bool Function(int index, T element) test) {
    if ((this ?? []).isEmpty) {
      return null;
    }
    var index = 0;
    for (var element in this!) {
      if (test(index++, element)) return element;
    }
    return null;
  }

  /// The first element, or `null` if the iterable is empty.
  T? get firstOrNull {
    if ((this ?? []).isEmpty) {
      return null;
    }
    var iterator = this!.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }

  /// Filters the elements based on the provided [condition] function,
  /// but returns `null` if the iterable itself is `null`.
  Iterable<T>? whereOrNull(bool Function(T element) condition) {
    return this?.where(condition);
  }

  /// Returns `true` if the iterable is `null` or empty.
  bool get isNullOrEmpty {
    if ((this ?? []).isEmpty) {
      return true;
    }
    return false;
  }

  /// Returns `false` if the iterable is `null` or empty.
  bool get isNullOrNotEmpty {
    if ((this ?? []).isEmpty) {
      return false;
    }
    return true;
  }
}
