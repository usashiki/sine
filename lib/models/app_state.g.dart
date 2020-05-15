// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals, type_annotate_public_apis, implicit_dynamic_parameter

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    trackers: (json['trackers'] as List)
        ?.map((e) =>
            e == null ? null : Tracker.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'trackers': instance.trackers?.map((e) => e?.toJson())?.toList(),
    };
