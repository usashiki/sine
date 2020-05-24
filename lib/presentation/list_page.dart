import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_add.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/summary_card.dart';
import 'package:supercharged/supercharged.dart';

class ListPage extends StatelessWidget {
  final List<Tracker> trackers;
  final Function(String, int) editCurrentCallback;

  const ListPage({
    this.trackers,
    this.editCurrentCallback,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cur = trackers.sumBy((t) => t.current);
    final max = trackers.sumBy((t) => t.max);

    Iterable<Tracker> sorted = [];

    final groups = trackers
        .groupBy<String, Tracker>((t) => t.hasRemaining ? 'with' : 'without');

    final withs = groups['with'];
    if (withs != null && withs.isNotEmpty) {
      sorted = sorted
          .followedBy(withs.sortedBy((one, two) => one.comparePrevious(two)));
    }

    final withouts = groups['without'];
    if (withouts != null && withouts.isNotEmpty) {
      sorted = sorted
          .followedBy(withouts.sortedBy((one, two) => one.compareNext(two)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sine: $cur / $max (${max - cur})'),
      ),
      body: ListView(
        children: <Widget>[
          for (Tracker t in sorted)
            SummaryCard(
              tracker: t,
              onLongPress: () => editCurrentCallback(t.id, t.current + 1),
            ),
        ],
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
