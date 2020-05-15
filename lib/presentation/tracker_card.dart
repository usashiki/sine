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
        leading: Icon(Icons.radio),
        title: Text(tracker.title),
        subtitle: Text('${tracker.current} / ${tracker.max} episodes'),
        trailing: tracker.remaining > 0
            ? Container(
                constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${tracker.remaining}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : null,
        onTap: () => Navigator.push<PageRoute>(
          context,
          MaterialPageRoute(builder: (_) => TrackerInfo(tracker.id)),
        ),
      ),
    );
  }
}
