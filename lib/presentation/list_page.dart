import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_add.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/tracker_card.dart';
import 'package:supercharged/supercharged.dart';

class ListPage extends StatelessWidget {
  final List<Tracker> trackers;

  const ListPage(this.trackers, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cur = trackers.sumBy((t) => t.current);
    final max = trackers.sumBy((t) => t.max);

    final groups = trackers
        .groupBy<String, Tracker>((t) => t.hasRemaining ? 'with' : 'without');
    final sorted = groups['with']
        .sortedBy((one, two) => one.comparePrevious(two))
        .followedBy(
            groups['without'].sortedBy((one, two) => one.compareNext(two)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Sine: $cur / $max (${max - cur})'),
      ),
      body: ListView(
        children: <Widget>[for (Tracker t in sorted) TrackerCard(t)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<PageRoute>(
          context,
          MaterialPageRoute(builder: (_) => const TrackerAdd()),
        ),
        tooltip: 'Add Tracker',
        child: Icon(Icons.add),
      ),
    );
  }
}
