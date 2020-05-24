import 'package:json_annotation/json_annotation.dart';
import 'package:sine/models/app_settings.dart';
import 'package:sine/models/tracker.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final List<Tracker> trackers;

  final AppSettings settings;

  const AppState({
    this.settings = const AppSettings(),
    this.trackers = const [],
  });

  /// For redux_persist [Persistor]
  static AppState fromJsonDynamic(dynamic json) =>
      json == null ? null : AppState.fromJson(json as Map<String, dynamic>);

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
