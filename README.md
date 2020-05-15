# Sine

Sine is a periodic episode tracker app, written in [Flutter](https://flutter.dev/).

Sine is designed for keeping track of your progress on episodic content, especially content that periodically progresses, for example a TV show in which a new episode airs every week.

## Features

TODO

## Architecture

Sine uses [`flutter_redux`](https://pub.dev/packages/flutter_redux) for state management with [`redux_persist_flutter`](https://pub.dev/packages/redux_persist_flutter) for persistence.

The structure of `lib/` is as follows:

- `containers/` - the container components, eg widgets that subscribe to state provided by Redux and typically wrap a presentation widget which presents state data
- `models/` - the underlying data models
- `presentation/` - the presentation components, eg widgets that render state data, typically provided by a container widget
- `redux/` - the Redux constructs, eg actions and reducers

## TODOs

- [x] complete EditPage ui: use Form/FormFields
- [x] test out ui for major bugs: doesnt need to be perfect
- [x] integrate with [flutter_redux](https://pub.dev/packages/flutter_redux) for state management
  - https://github.com/brianegan/flutter_architecture_samples/tree/master/redux
  - https://github.com/xqwzts/flutter-redux-todo-list
- [x] integrate with [redux_persist](https://pub.dev/packages/redux_persist) for persistance
- [x] organize code
- [x] delete trackers
- [x] sorting: latest ep -> upcoming ep
- [ ] polish the ui
- [ ] edit on view page
- [ ] reordering trackers
- [ ] add timezone selection
- [ ] notes, links fields
- [ ] categories
- [ ] dark theme
- [ ] setting page: theme selection, dark theme, etc
- [ ] local notifications? https://pub.dev/packages/flutter_local_notifications
