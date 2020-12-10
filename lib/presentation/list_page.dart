import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sine/containers/tracker_add.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/summary_card.dart';
import 'package:supercharged/supercharged.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPage extends StatelessWidget {
  final List<Tracker> trackers;
  final Function(String, int) editCurrentCallback;
  final Function(List<Tracker>) importTrackersCallback;

  const ListPage({
    this.trackers,
    this.editCurrentCallback,
    this.importTrackersCallback,
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
          PopupMenuButton<PopupMenuOptions>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: PopupMenuOptions.about,
                child: Text('About'),
              ),
              const PopupMenuItem(
                value: PopupMenuOptions.import,
                child: Text('Import'),
              ),
              const PopupMenuItem(
                value: PopupMenuOptions.export,
                child: Text('Export'),
              ),
            ],
            onSelected: (PopupMenuOptions result) async {
              switch (result) {
                case PopupMenuOptions.about:
                  _about(context);
                  break;
                case PopupMenuOptions.import:
                  _import();
                  break;
                case PopupMenuOptions.export:
                  _export();
                  break;
              }
            },
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

  /// Show app about dialog.
  void _about(BuildContext context) async {
    showAboutDialog(
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
    );
  }

  /// Import trackers from an [AppState] JSON file from storage.
  void _import() async {
    // ask for a file to import
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      final newStateJson = File(result.files.single.path).readAsStringSync();

      // attempt to parse file contents
      AppState newState;
      try {
        newState = AppState.fromJsonDynamic(newStateJson.parseJSON());
      } catch (e) {
        newState = null;
      }

      if (newState != null) {
        importTrackersCallback(newState.trackers);
      }
    }
  }

  /// Export existing JSON state to storage.
  void _export() async {
    if (await Permission.storage.request().isGranted) {
      // ask for a directory to export to
      final path = await FilePicker.platform.getDirectoryPath();
      // if directory selected, fetch current state and copy to that directory
      if (path != null) {
        final stateFile =
            File('${(await getExternalStorageDirectory()).path}/state.json');
        stateFile.copy('$path/state.json');
      }
    }
  }
}

enum PopupMenuOptions { about, import, export }
