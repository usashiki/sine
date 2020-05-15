import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_info.dart';
import 'package:sine/models/tracker.dart';

class TrackerCard extends StatelessWidget {
  final Tracker tracker;

  const TrackerCard(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${tracker.title}: ${tracker.current} / ${tracker.max}'),
        subtitle: tracker.period != null ? Text('Next: ${tracker.next}') : null,
        onTap: () => Navigator.push<PageRoute>(
          context,
          MaterialPageRoute(builder: (_) => TrackerInfo(tracker.id)),
        ),
      ),
    );
  }
}
