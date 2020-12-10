# Sine

Sine is an episode tracking app for Android, designed for keeping track of your progress on episodic content, including content which updates periodically.

## Screenshots

| List page                                   | Info page                                   | Edit page                                   |
| ------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| <img src="images/list.png" width="300px" /> | <img src="images/info.png" width="300px" /> | <img src="images/edit.png" width="300px" /> |

In Sine, you create trackers to track your progress on some episodic content.
Progress on a trackers is represented by a current and maximum number of episodes.
For auto-incrementing content, the maximum episode count is calculated based on the period (defined by a start date and frequency of updates) plus an offset.
In addition to current and max, trackers can also have custom colors and notes.

## Installation

Download the APK file from the [latest release](https://github.com/usashiki/sine/releases/latest).
Alternatively, clone the repo and build the APK with `flutter build apk`.

### Data import/export

App data is stored in the app's external storage directory, typically `/sdcard/Android/data/com.usashiki.sine/files/state.json` (this may not be accessible on devices running Android 11 or above).
Data import and export can be performed via the three dot menu on the list page.

## Development

Sine is written in [Dart](https://dart.dev/) using [Flutter](https://flutter.dev/).
To install Dart/Flutter, follow Flutter's [official documentation](https://flutter.dev/docs/get-started/install).

### Architecture

Sine uses [`flutter_redux`](https://pub.dev/packages/flutter_redux) for state management with [`redux_persist`](https://pub.dev/packages/redux_persist) for persistence.
The state is stored in `AppState`, which is serialized to JSON and persisted on disk.

The directory structure of `lib/` is as follows:

- `containers/` - the container components, eg widgets that subscribe to state provided by Redux and typically wrap a presentation widget which presents state data (unrelated to [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html))
- `models/` - the underlying data models, all of which are JSON-serializable
- `presentation/` - the presentation components, eg widgets that render state data, typically provided by a container widget
- `redux/` - the Redux constructs, eg actions and reducers

There are no tests.

### Releases

This repo is set up to create new versioned releases with a built APK using GitHub Actions.
To create a new versioned release, do the following:

- [ ] Increment the `version` field in `pubspec.yaml`, eg `0.0.1`
- [ ] Create a new entry in the [changelog](CHANGELOG.md), and also update this readme if necessary
- [ ] Commit and push your changes
- [ ] Tag the commit, eg `git tag v0.0.1` (the `v` is required)
- [ ] Push the tag: `git push origin v0.0.1`

(For reference: `git tag -d v0.0.1` to delete tag locally, `git push --delete origin v0.0.1` to delete tag on remote.)

### Logo

The [app icon](assets/icon/icon.png) and splash screen were created using [this image](https://commons.wikimedia.org/wiki/File:Simple_sine_wave.svg) by Omegatron [with modifications](assets/icon/sine.svg) and [Roman Nurik's](https://github.com/romannurik) [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/index.html).

## Meta

Written by fc ([@usashiki7](https://twitter.com/usashiki7)).
For any questions or comments, please [open an issue](https://github.com/usashiki/sine/issues/new) or contact me on Twitter (DMs open).
