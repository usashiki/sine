import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_add.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/tracker_card.dart';

class ListPage extends StatelessWidget {
  final List<Tracker> trackers;

  const ListPage(this.trackers, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cur = 0;
    int max = 0;
    for (final t in trackers) {
      cur += t.current;
      max += t.max;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sine: $cur / $max (${cur - max})'),
      ),
      body: ListView.builder(
        itemCount: trackers.length,
        itemBuilder: (_, final i) => TrackerCard(trackers[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<PageRoute>(
          context,
          MaterialPageRoute(builder: (_) => const TrackerAdd()),
        ),
        tooltip: 'New Tracker',
        child: Icon(Icons.add),
      ),
    );
  }
}
