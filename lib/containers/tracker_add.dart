import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sine/presentation/add_edit_page.dart';
import 'package:sine/redux/actions.dart';

class TrackerAdd extends StatelessWidget {
  const TrackerAdd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(Tracker)>(
      converter: (store) => (Tracker newTracker) {
        store.dispatch(AddTrackerAction(newTracker));
      },
      builder: (context, callback) => AddEditPage(onSaveCallback: callback),
    );
  }
}
