import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sine/presentation/add_edit_page.dart';
import 'package:sine/redux/actions.dart';
import 'package:uuid/uuid.dart';

class TrackerEdit extends StatelessWidget {
  final Tracker tracker;

  const TrackerEdit(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => AddEditPage(
        tracker: tracker,
        onSaveCallback: vm.onSaveCallback,
        deleteCallback: vm.deleteCallback,
      ),
    );
  }
}

class _ViewModel {
  final Function(Tracker) onSaveCallback;
  final Function(String) deleteCallback;

  _ViewModel({
    @required this.onSaveCallback,
    @required this.deleteCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        onSaveCallback: (Tracker editedTracker) {
          store.dispatch(EditTrackerAction(editedTracker));
        },
        deleteCallback: (String id) {
          store.dispatch(DeleteTrackerAction(id));
        },
      );
}
