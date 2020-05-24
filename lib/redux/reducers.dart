import 'package:redux/redux.dart';
import 'package:sine/models/app_settings.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/models/tracker.dart';
import 'package:sine/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
      trackers: _trackersReducer(state.trackers, action),
      settings: _settingsReducer(state.settings, action),
    );

final _trackersReducer = combineReducers<List<Tracker>>([
  TypedReducer<List<Tracker>, AddTrackerAction>(_addTracker),
  TypedReducer<List<Tracker>, EditTrackerAction>(_editTracker),
  TypedReducer<List<Tracker>, DeleteTrackerAction>(_deleteTracker),
  TypedReducer<List<Tracker>, EditTrackerCurrentAction>(_editTrackerCurrent),
  TypedReducer<List<Tracker>, EditTrackerOffsetAction>(_editTrackerOffset),
]);

final _settingsReducer = combineReducers<AppSettings>([
  TypedReducer<AppSettings, EditSettingsAction>(_editSettings),
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

List<Tracker> _editTrackerCurrent(
        List<Tracker> trackers, EditTrackerCurrentAction action) =>
    trackers
        .map((tracker) => tracker.id == action.id
            ? tracker.copyWith(current: action.newCurrent)
            : tracker)
        .toList();

List<Tracker> _editTrackerOffset(
        List<Tracker> trackers, EditTrackerOffsetAction action) =>
    trackers
        .map((tracker) => tracker.id == action.id
            ? tracker.copyWith(offset: action.newOffset)
            : tracker)
        .toList();

AppSettings _editSettings(AppSettings settings, EditSettingsAction action) =>
    action.newSettings;
