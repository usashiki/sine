# todos

- [ ] [improvement] remove deletion hack (pop before load?)
- [ ] [bug] color is not set on selected fields: set theme color upon entering tracker?
- [ ] [feature] local notifications: https://pub.dev/packages/flutter_local_notifications
- [ ] [feature] tracker/period limit (eg stop auto-incrementing after date/number of eps)
- [ ] [feature] archiving trackers (as opposed to deleting them)
- [ ] [feature] timezone selection on period
- [ ] [feature] theming
  - [ ] dark theme
  - [ ] theme color/default tracker color selection
- [ ] [feature] reordering trackers/custom sorting
- [ ] [feature] calendar view
- [ ] [improvement] try `async_redux`? https://pub.dev/packages/async_redux
- [ ] [feature] custom page transitions
- [ ] [feature] remove fabs?
- [ ] [feature] ios support

## wip

- [ ] [feature] formal data export/import
  - [x] import: works
  - [ ] export: it worked initially but not anymore? it's something with the permissions but can't figure it out
    - for now just using api 29 with `requestLegacyExternalStorage` but not a long-term solution
  - [ ] cannot build release apk due to issues with [`file_picker`](https://github.com/miguelpruivo/flutter_file_picker) and androidx, specifically the [`DefaultLifecycleObserver` issue described in the wiki](https://github.com/miguelpruivo/flutter_file_picker/wiki/Troubleshooting#-issue-5) as well as many issues - nothing seemed to work
    - https://github.com/miguelpruivo/flutter_file_picker/issues?q=DefaultLifecycleObserver
    - https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html
    - https://developer.android.com/studio/releases/gradle-plugin#updating-gradle
    - for now just using the debug build
