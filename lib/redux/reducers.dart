import 'package:redux/redux.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) =>
    AppState(trackers: _trackersReducer(state.trackers, action));

final _trackersReducer = combineReducers<List<Tracker>>([
  TypedReducer<List<Tracker>, AddTrackerAction>(_addTracker),
  TypedReducer<List<Tracker>, EditTrackerAction>(_editTracker),
  TypedReducer<List<Tracker>, DeleteTrackerAction>(_deleteTracker),
]);

List<Tracker> _addTracker(List<Tracker> trackers, AddTrackerAction action) =>
    List.from(trackers)..add(action.tracker);

List<Tracker> _editTracker(List<Tracker> trackers, EditTrackerAction action) =>
    trackers
        .map((tracker) =>
            tracker.id == action.tracker.id ? action.tracker : tracker)
        .toList();

List<Tracker> _deleteTracker(
        List<Tracker> trackers, DeleteTrackerAction action) =>
    List.from(trackers)..removeWhere((tracker) => tracker.id == action.id);
