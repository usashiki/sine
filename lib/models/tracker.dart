import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sine/models/period.dart';
import 'package:sine/utils/null_last_compare.dart';
import 'package:uuid/uuid.dart';

part 'tracker.g.dart';

/// A tracker which optionally auto-increments based on [period].
@JsonSerializable()
class Tracker {
  /// Identifier for this tracker. A UUID is generated by default.
  final String id;

  /// The title of the tracker.
  final String title;

  /// The current episode count.
  final int current;

  /// Offsets the maximum episode count as calcuated by [period].
  final int offset;

  /// If not null, how often this tracker will auto-increment.
  final Period period;

  Tracker({
    String uuid,
    @required this.title,
    this.current = 0,
    this.offset = 0,
    this.period,
  }) : id = uuid ?? Uuid().v4();

  /// The max episode count.
  int get max => offset + (period?.elapsed ?? 0);

  /// The remaining number of episodes (i.e. max - current).
  int get remaining => max - current;

  /// Whether [remaining] is greater than 0.
  bool get hasRemaining => remaining > 0;

  /// Whether this Tracker has a [period] (and therefore auto-increments).
  bool get hasPeriod => period != null;

  /// The next time this tracker will auto-increment, returning null if [period]
  /// is null.
  DateTime get next => period?.next;

  /// The last time this tracker auto-incremented, returning null if [period] is
  /// null.
  DateTime get previous => period?.previous;

  /// Compares [next] to another Tracker's next in a null-safe way with nulls
  /// last.
  int compareNext(Tracker other) => next.compareNullsLast(other.next);

  /// Compares [previous] to another Tracker's previous in a null-safe way with
  /// nulls last.
  int comparePrevious(Tracker other) =>
      previous.compareNullsLast(other.previous);

  @override
  String toString() {
    return 'Tracker $title: $current / $max (updates $period)';
  }

  factory Tracker.fromJson(Map<String, dynamic> json) =>
      _$TrackerFromJson(json);
  Map<String, dynamic> toJson() => _$TrackerToJson(this);
}
