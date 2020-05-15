import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_edit.dart';
import 'package:sine/models/tracker.dart';

class InfoPage extends StatelessWidget {
  final Tracker tracker;

  const InfoPage(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
