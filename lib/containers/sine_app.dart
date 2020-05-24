import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sine/containers/tracker_list.dart';
import 'package:sine/models/app_settings.dart';
import 'package:sine/models/app_state.dart';

class SineApp extends StatelessWidget {
  const SineApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppSettings>(
      converter: (store) => store.state.settings,
      builder: (_, settings) => MaterialApp(
        title: 'Sine',
        theme: ThemeData(
          primaryColor: settings.themeColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const TrackerList(),
      ),
    );
  }
}
