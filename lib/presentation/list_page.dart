import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:package_info/package_info.dart';
import 'package:sine/containers/tracker_add.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/summary_card.dart';
import 'package:supercharged/supercharged.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: <Widget>[
          // TODO: make this a dropdown with options for Import, Export, and About
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'App Info',
            onPressed: () async => showAboutDialog(
              context: context,
              applicationIcon: Image.asset('assets/icon/icon.png', width: 48),
              applicationVersion: (await PackageInfo.fromPlatform()).version,
              children: <Widget>[
                Linkify(
                  onOpen: (link) => launch(link.url),
                  linkStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  options: LinkifyOptions(humanize: false),
                  text: 'https://github.com/usashiki/sine',
                ),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          for (Tracker t in sorted)
            SummaryCard(
              tracker: t,
              onLongPress: () => editCurrentCallback(t.id, t.current + 1),
            ),
          const SizedBox(height: 80), // "overscroll" for fab
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<PageRoute>(
          context,
          MaterialPageRoute(builder: (_) => const TrackerAdd()),
        ),
        tooltip: 'Add Tracker',
        child: const Icon(Icons.add),
      ),
    );
  }
}
