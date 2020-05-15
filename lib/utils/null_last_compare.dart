extension NullLastCompare on Comparable {
  int compareNullsLast(Comparable other) {
    if (this == null && other == null) return 0;
    if (this == null) return 1;
    if (other == null) return -1;
    return compareTo(other);
  }
}
