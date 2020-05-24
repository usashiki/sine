import 'package:sine/models/app_settings.dart';
import 'package:sine/models/tracker.dart';

class AddTrackerAction {
  final Tracker tracker;

  const AddTrackerAction(this.tracker);

  @override
  String toString() => 'AddTrackerAction($tracker)';
}

class EditTrackerAction {
  final Tracker tracker;

  const EditTrackerAction(this.tracker);

  @override
  String toString() => 'EditTrackerAction($tracker)';
}

class DeleteTrackerAction {
  final String id;

  const DeleteTrackerAction(this.id);

  @override
  String toString() => 'DeleteTrackerAction($id)';
}

class EditTrackerCurrentAction {
  final String id;
  final int newCurrent;

  const EditTrackerCurrentAction(this.id, this.newCurrent);

  @override
  String toString() => 'IncrementTrackerCurrentAction($id, $newCurrent)';
}

class EditTrackerOffsetAction {
  final String id;
  final int newOffset;

  const EditTrackerOffsetAction(this.id, this.newOffset);

  @override
  String toString() => 'IncrementTrackerOffsetAction($id, $newOffset)';
}

class EditSettingsAction {
  final AppSettings newSettings;

  const EditSettingsAction(this.newSettings);

  @override
  String toString() => 'EditSettingsAction{$newSettings}';
}
