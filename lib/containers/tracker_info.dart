import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/info_page.dart';

class TrackerInfo extends StatelessWidget {
  final String id;

  const TrackerInfo(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Tracker>(
      converter: (store) =>
          store.state.trackers.firstWhere((tracker) => tracker.id == id),
      builder: (_, tracker) => InfoPage(tracker),
    );
  }
}
