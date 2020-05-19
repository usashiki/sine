import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sine/containers/tracker_edit.dart';
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
          ListTile(
            title: Text('Period: ${tracker.period ?? 'N/A'}'),
            subtitle: Text('Next: ${tracker.next ?? 'N/A'}'),
          ),
          ListTile(title: Text('Color: ${tracker.color}')),
          for (int i = 0; i < tracker.links.length; i++)
            ListTile(
              title: Text('Link ${i + 1}'),
              subtitle: Text(
                tracker.links[i],
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () => launch(tracker.links[i]),
              onLongPress: () {
                print('copying ${tracker.links[i]} to clipboard');
                Clipboard.setData(ClipboardData(text: tracker.links[i]));
                Scaffold.of(context).showSnackBar(const SnackBar(
                  content: Text('Copied to clipboard.'),
                  duration: Duration(seconds: 1),
                ));
              },
            ),
          ListTile(
            title: const Text('Notes'),
            subtitle: Text(tracker.notes == null || tracker.notes.isEmpty
                ? 'N/A'
                : tracker.notes),
          ),
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
