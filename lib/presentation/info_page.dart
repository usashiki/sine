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
  final VoidCallback deleteCallback;

  const InfoPage({
    this.tracker,
    this.editCurrentCallback,
    this.editOffsetCallback,
    this.deleteCallback,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tracker.title),
        backgroundColor: tracker.color,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Tracker',
            onPressed: () {
              deleteCallback();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(MdiIcons.abTesting),
            title: Column(
              children: <Widget>[
                _EpisodeCounter(
                  actual: tracker.current,
                  editCallback: editCurrentCallback,
                  color: tracker.color,
                ),
                Divider(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  thickness: 2,
                ),
                _EpisodeCounter(
                  actual: tracker.offset,
                  displayed: tracker.max,
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
        child: const Icon(Icons.edit),
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
      leading: const Icon(MdiIcons.reload),
      title: Text('New episode every ${period.days} days'),
      subtitle:
          Text('Previous: ${period.previousStr}\nNext: ${period.nextStr}'),
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
      leading: const Icon(MdiIcons.text),
      title: Linkify(
        onOpen: (link) => launch(link.url),
        linkStyle: TextStyle(
          color: linkColor,
          decoration: TextDecoration.underline,
        ),
        options: LinkifyOptions(humanize: false),
        text: text,
      ),
    );
  }
}

class _EpisodeCounter extends StatelessWidget {
  final int actual, displayed;
  final Function(int) editCallback;
  final Color color;

  const _EpisodeCounter({
    @required this.actual,
    this.displayed,
    @required this.editCallback,
    @required this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IntrinsicWidth(
          child: IconButton(
            icon: Icon(Icons.remove, color: color),
            onPressed: () => editCallback(actual - 1),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '${displayed ?? actual}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        IntrinsicWidth(
          child: IconButton(
            icon: Icon(Icons.add, color: color),
            onPressed: () => editCallback(actual + 1),
          ),
        ),
        const Text('episodes'),
      ],
    );
  }
}
