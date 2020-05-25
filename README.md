# Sine

Sine is a periodic episode tracker app, written in [Flutter](https://flutter.dev/).

Sine is designed for keeping track of your progress on episodic content, especially content that periodically progresses, for example a TV show in which a new episode airs every week.

## Features

TODO

## Architecture

Sine uses [`flutter_redux`](https://pub.dev/packages/flutter_redux) for state management with [`redux_persist_flutter`](https://pub.dev/packages/redux_persist_flutter) for persistence.

The structure of `lib/` is as follows:

- `containers/` - the container components, eg widgets that subscribe to state provided by Redux and typically wrap a presentation widget which presents state data (unrelated to [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html))
- `models/` - the underlying data models
- `presentation/` - the presentation components, eg widgets that render state data, typically provided by a container widget
- `redux/` - the Redux constructs, eg actions and reducers

## Icon

The [app icon](assets/icon/icon.png) was created using [this image](https://commons.wikimedia.org/wiki/File:Simple_sine_wave.svg) by Omegatron [with modifications](assets/icon/sine.svg) and [Roman Nurik's](https://github.com/romannurik) [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/index.html).

## Roadmap

### v0

- [x] complete EditPage ui: use Form/FormFields
- [x] test out ui for major bugs: doesnt need to be perfect
- [x] integrate with [flutter_redux](https://pub.dev/packages/flutter_redux) for state management
  - https://github.com/brianegan/flutter_architecture_samples/tree/master/redux
  - https://github.com/xqwzts/flutter-redux-todo-list
- [x] integrate with [redux_persist](https://pub.dev/packages/redux_persist) for persistance
- [x] organize code
- [x] delete trackers
- [x] sorting: latest ep -> upcoming ep
- [x] notes, links fields
- [x] polish list ui cards
- [x] tracker color customization: https://pub.dev/packages/flutter_colorpicker
- [x] remove links field for https://pub.dev/packages/flutter_linkify
- [x] list cards: enable +1 on long press (create new action?)
- [x] polish details ui: add icons, allow +/- cur/max
- [x] polish edit ui: add icons, match details page
- [x] app icon, splash
- [x] container and presentation widget naming convention
- [ ] readme, comments

### later

- [ ] delete hack (pop before load?)
- [ ] themeing
  - [ ] dark theme
  - [ ] theme color/default tracker color selection
- [ ] replace fabs?
- [ ] custom page transition
- [ ] [bug] color is not set on selected fields: set theme color upon entering tracker?
- [ ] local notifications: https://pub.dev/packages/flutter_local_notifications
- [ ] calendar view
- [ ] period timezone selection
- [ ] reordering trackers
- [ ] try `async_redux`? https://pub.dev/packages/async_redux
