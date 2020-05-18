import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_info.dart';
import 'package:sine/models/tracker.dart';

class TrackerCard extends StatelessWidget {
  static const double radius = 8.0;

  final Tracker tracker;

  const TrackerCard(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: InkWell - onTap to open info page
    // TODO: move to own widget
    // TODO: hide bubble when no new eps
    // TODO: hide next when no period
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 12,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius)),
                color: Theme.of(context).primaryColor,
              ),
              margin: const EdgeInsets.only(right: 8),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                // alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tracker.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${tracker.current} / ${tracker.max} episodes',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Next: ${tracker.next ?? 'N/A'}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${tracker.remaining}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
