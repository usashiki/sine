import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sine/containers/tracker_info.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/info_card.dart';

class TrackerCard extends StatelessWidget {
  static final DateFormat _nextFormat = DateFormat('MMM d (EEE) HH:mm');
  final Tracker tracker;

  const TrackerCard(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      barColor: tracker.color,
      title: tracker.title,
      subtitle1: '${tracker.current} / ${tracker.max} episodes',
      subtitle2: tracker.next != null
          ? 'Next: ${_nextFormat.format(tracker.next)}'
          : null,
      trailingCounter: tracker.remaining,
      onTap: () => Navigator.push<PageRoute>(
        context,
        MaterialPageRoute(builder: (_) => TrackerInfo(tracker.id)),
      ),
    );
  }
}
