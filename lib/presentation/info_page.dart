import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sine/containers/tracker_edit.dart';
import 'package:sine/models/period.dart';
import 'package:sine/models/tracker.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  final Tracker tracker;
  final Function(int) editCurrentCallback;
  final Function(int) editOffsetCallback;

  const InfoPage({
    this.tracker,
    this.editCurrentCallback,
    this.editOffsetCallback,
    Key key,
  }) : super(key: key);

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
            leading: Icon(MdiIcons.abTesting),
            title: Column(
              children: <Widget>[
                _EpisodeCounter(
                  value: tracker.current,
                  editCallback: editCurrentCallback,
                  color: tracker.color,
                ),
                Divider(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  thickness: 2,
                ),
                _EpisodeCounter(
                  value: tracker.max,
                  editCallback: editOffsetCallback,
                  color: tracker.color,
                ),
              ],
            ),
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
      leading: Icon(MdiIcons.text),
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

class _EpisodeCounter extends StatelessWidget {
  final int value;
  final Function(int) editCallback;
  final Color color;

  const _EpisodeCounter({
    this.value,
    this.editCallback,
    this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IntrinsicWidth(
          child: IconButton(
            icon: Icon(Icons.remove, color: color),
            onPressed: () => editCallback(value - 1),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '$value',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        IntrinsicWidth(
          child: IconButton(
            icon: Icon(Icons.add, color: color),
            onPressed: () => editCallback(value + 1),
          ),
        ),
        const Text('episodes'),
      ],
    );
  }
}
