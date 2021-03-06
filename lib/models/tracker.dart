import 'dart:ui' show Color;

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sine/models/period.dart';
import 'package:sine/utils/null_last_compare.dart';
import 'package:uuid/uuid.dart';

part 'tracker.g.dart';

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

  /// The color of the tracker.
  final int colorInt;

  /// If not null, how often this tracker will auto-increment.
  final Period period;

  /// A miscellaneous text field.
  final String notes;

  /// Model for a tracker, which represents one piece of episodic content.
  /// Optionally auto-increments if provided a [Period].
  Tracker({
    String id,
    @required this.title,
    @required this.current,
    @required this.offset,
    @required this.colorInt,
    this.period,
    this.notes = '',
  })  : id = id ?? Uuid().v4(),
        assert(current > -1);

  Tracker copyWith({
    String id,
    String title,
    int current,
    int offset,
    int colorInt,
    Period period,
    String notes,
  }) =>
      Tracker(
        id: id ?? this.id,
        title: title ?? this.title,
        current: current ?? this.current,
        offset: offset ?? this.offset,
        colorInt: colorInt ?? this.colorInt,
        period: period ?? this.period,
        notes: notes ?? this.notes,
      );

  /// The max episode count.
  int get max => offset + (period?.elapsed ?? 0);

  /// The remaining number of episodes (i.e. max - current).
  int get remaining => max - current;

  /// Whether [remaining] is greater than 0.
  bool get hasRemaining => remaining > 0;

  Color get color => Color(colorInt);

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
  int compareNext(Tracker other) => next.compareAscendingNullsLast(other.next);

  /// Compares [previous] to another Tracker's previous in a null-safe way with
  /// nulls last.
  int comparePrevious(Tracker other) =>
      previous.compareDescendingNullsLast(other.previous);

  @override
  String toString() =>
      'Tracker(title: $title, current: $current, offset: $offset, period: $period)';

  factory Tracker.fromJson(Map<String, dynamic> json) =>
      _$TrackerFromJson(json);
  Map<String, dynamic> toJson() => _$TrackerToJson(this);
}
