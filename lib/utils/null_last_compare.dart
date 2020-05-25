extension NullLastCompare on Comparable {
  int compareAscendingNullsLast(Comparable other) {
    if (this == null && other == null) return 0;
    if (this == null) return 1;
    if (other == null) return -1;
    return compareTo(other);
  }

  int compareDescendingNullsLast(Comparable other) {
    if (this == null && other == null) return 0;
    if (this == null) return 1;
    if (other == null) return -1;
    return -1 * compareTo(other);
  }
}
