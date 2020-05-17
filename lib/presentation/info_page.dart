import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_edit.dart';
import 'package:sine/models/tracker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supercharged/supercharged.dart';

class InfoPage extends StatelessWidget {
  final Tracker tracker;

  const InfoPage(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final links = <Widget>[];
    if (tracker.links == null || tracker.links.isEmpty) {
      links.add(const ListTile(title: Text('Links'), subtitle: Text('N/A')));
    } else {
      tracker.links.forEachIndexed(
        (i, l) => links.add(ListTile(
          title: Text('Link ${i + 1}'),
          subtitle: Text(l),
          onTap: () => launch(l),
        )),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(tracker.title)),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Current: ${tracker.current}'),
          ),
          ListTile(
            title: Text('Max: ${tracker.max}'),
            subtitle: Text(
                '${tracker.period?.elapsed ?? 0} elapsed + ${tracker.offset} offset'),
          ),
          ListTile(
            title: Text('Period: ${tracker.period ?? 'N/A'}'),
            subtitle: Text('Next: ${tracker.next ?? 'N/A'}'),
          ),
          for (Widget w in links) w,
          ListTile(
            title: const Text('Notes'),
            subtitle: Text(tracker.notes == null || tracker.notes.isEmpty
                ? 'N/A'
                : tracker.notes),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push<PageRoute>(
          context,
          MaterialPageRoute(builder: (_) => TrackerEdit(tracker)),
        ),
        tooltip: 'Edit Tracker',
        child: Icon(Icons.edit),
      ),
    );
  }
}
