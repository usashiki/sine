// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals, type_annotate_public_apis, implicit_dynamic_parameter

part of 'tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracker _$TrackerFromJson(Map<String, dynamic> json) {
  return Tracker(
    title: json['title'] as String,
    current: json['current'] as int,
    offset: json['offset'] as int,
    period: json['period'] == null
        ? null
        : Period.fromJson(json['period'] as Map<String, dynamic>),
    links: (json['links'] as List)?.map((e) => e as String)?.toList(),
    notes: json['notes'] as String,
  );
}

Map<String, dynamic> _$TrackerToJson(Tracker instance) => <String, dynamic>{
      'title': instance.title,
      'current': instance.current,
      'offset': instance.offset,
      'period': instance.period?.toJson(),
      'links': instance.links,
      'notes': instance.notes,
    };
