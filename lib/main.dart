import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:sine/containers/sine_app.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/redux/reducers.dart';
import 'package:path_provider/path_provider.dart';

const String trackerBoxName = 'trackers';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // using getExternalStorageDirectory so accessible without root
  final persistor = Persistor<AppState>(
    storage: FileStorage(
        File('${(await getExternalStorageDirectory()).path}/state.json')),
    serializer: JsonSerializer<AppState>(AppState.fromJsonDynamic),
  );

  AppState initialState;
  try {
    initialState = await persistor.load();
  } catch (e) {
    initialState = null;
  }

  final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? const AppState(),
    middleware: [persistor.createMiddleware()],
  );

  runApp(Sine(store: store));
}

class Sine extends StatelessWidget {
  final Store<AppState> store;

  const Sine({
    @required this.store,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: const SineApp(),
    );
  }
}
