// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals, type_annotate_public_apis, implicit_dynamic_parameter

part of 'tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracker _$TrackerFromJson(Map<String, dynamic> json) {
  return Tracker(
    id: json['id'] as String,
    title: json['title'] as String,
    current: json['current'] as int,
    offset: json['offset'] as int,
    colorInt: json['colorInt'] as int,
    period: json['period'] == null
        ? null
        : Period.fromJson(json['period'] as Map<String, dynamic>),
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$TrackerToJson(Tracker instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'current': instance.current,
      'offset': instance.offset,
      'colorInt': instance.colorInt,
      'period': instance.period?.toJson(),
      'notes': instance.notes,
    };
