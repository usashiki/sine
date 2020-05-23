import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:sine/containers/tracker_edit.dart';
import 'package:sine/models/period.dart';
import 'package:sine/models/tracker.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  final Tracker tracker;

  const InfoPage(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tracker.title),
        backgroundColor: tracker.color,
      ),
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
          if (tracker.period != null) _PeriodTile(tracker.period),
          if (tracker.notes != null && tracker.notes.isNotEmpty)
            _NotesTile(text: tracker.notes, linkColor: tracker.color),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tracker.color,
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

class _PeriodTile extends StatelessWidget {
  final Period period;

  const _PeriodTile(this.period, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.repeat),
      title: Text('Every ${period.days} days starting on ${period.startStr}'),
      subtitle: Text('Next: ${period.nextStr}'),
    );
  }
}

class _NotesTile extends StatelessWidget {
  final String text;
  final Color linkColor;

  const _NotesTile({this.text, this.linkColor, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.subject),
      title: Linkify(
        onOpen: (link) => launch(link.url),
        linkStyle: TextStyle(
          color: linkColor,
          decoration: TextDecoration.underline,
        ),
        text: text,
      ),
    );
  }
}
