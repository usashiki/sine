import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/presentation/list_page.dart';
import 'package:sine/redux/actions.dart';

class TrackerList extends StatelessWidget {
  const TrackerList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (_, vm) => ListPage(
        trackers: vm.trackers,
        incrementCallback: vm.incrementCallback,
      ),
    );
  }
}

class _ViewModel {
  final List<Tracker> trackers;
  final Function(String, int) incrementCallback;

  _ViewModel({
    @required this.trackers,
    @required this.incrementCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        trackers: store.state.trackers,
        incrementCallback: (String id, int increment) {
          store.dispatch(IncrementTrackerCurrentAction(id, increment));
        },
      );
}
