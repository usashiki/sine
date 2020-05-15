import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/list_page.dart';

class TrackerList extends StatelessWidget {
  const TrackerList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Tracker>>(
      converter: (store) => store.state.trackers,
      builder: (_, trackers) => ListPage(trackers),
    );
  }
}
