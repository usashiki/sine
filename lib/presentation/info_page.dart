import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          for (int i = 0; i < tracker.links.length; i++)
            _LinkTile(tracker.links[i]),
          if (tracker.notes != null && tracker.notes.isNotEmpty)
            _NotesTile(tracker.notes),
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

class _LinkTile extends StatelessWidget {
  final String link;

  const _LinkTile(this.link, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.link),
      title: Text(
        link,
        style: TextStyle(decoration: TextDecoration.underline),
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
      onTap: () => launch(link),
      onLongPress: () {
        print('copying $link to clipboard');
        Clipboard.setData(ClipboardData(text: link));
        Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text('Copied to clipboard.'),
          duration: Duration(seconds: 1),
        ));
      },
    );
  }
}

class _NotesTile extends StatelessWidget {
  final String notes;

  const _NotesTile(this.notes, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Notes'),
      subtitle: Text(notes),
    );
  }
}
