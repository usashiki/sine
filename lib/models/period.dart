import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'period.g.dart';

/// The period at which a [Tracker] auto-increments.
@JsonSerializable()
class Period {
  /// The number of days per period.
  final int days;

  /// The date this interval starts.
  final DateTime start;

  const Period({
    @required this.days,
    @required this.start,
  }) : assert(days > 0);

  /// The number of periods since [start].
  int get elapsed => start.isAfter(DateTime.now()) ? 0 : _periods;

  /// The next time this period will occur.
  DateTime get next => start.isAfter(DateTime.now())
      ? start
      : start.add(Duration(days: _periods * days));

  /// The previous time this period occurred.
  DateTime get previous => next.subtract(Duration(days: days));

  /// The number of days since [start].
  int get _diff => DateTime.now().difference(start).inDays;
  int get _periods => ((_diff + 1) / days).ceil();

  @override
  String toString() => 'every $days days starting at $start';

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodToJson(this);
}
