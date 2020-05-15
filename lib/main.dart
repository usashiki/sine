import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:sine/containers/tracker_list.dart';
import 'package:sine/models/app_state.dart';
import 'package:sine/redux/reducers.dart';

const String trackerBoxName = 'trackers';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
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

  runApp(SineApp(store: store));
}

class SineApp extends StatelessWidget {
  final Store<AppState> store;

  const SineApp({
    @required this.store,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Sine',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const TrackerList(),
      ),
    );
  }
}
