import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/info_page.dart';
import 'package:sine/redux/actions.dart';

class TrackerInfo extends StatelessWidget {
  final String id;

  const TrackerInfo(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, id),
      builder: (_, vm) => InfoPage(
        tracker: vm.tracker,
        editCurrentCallback: vm.editCurrentCallback,
        editOffsetCallback: vm.editOffsetCallback,
      ),
    );
  }
}

class _ViewModel {
  final Tracker tracker;
  final Function(int) editCurrentCallback;
  final Function(int) editOffsetCallback;

  _ViewModel({
    @required this.tracker,
    @required this.editCurrentCallback,
    @required this.editOffsetCallback,
  });

  static _ViewModel fromStore(Store<AppState> store, String id) => _ViewModel(
        tracker: store.state.trackers.firstWhere((tracker) => tracker.id == id),
        editCurrentCallback: (int newCurrent) =>
            store.dispatch(EditTrackerCurrentAction(id, newCurrent)),
        editOffsetCallback: (int newOffset) =>
            store.dispatch(EditTrackerOffsetAction(id, newOffset)),
      );
}
