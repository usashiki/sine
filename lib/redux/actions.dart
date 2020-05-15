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
