// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals, type_annotate_public_apis, implicit_dynamic_parameter

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Period _$PeriodFromJson(Map<String, dynamic> json) {
  return Period(
    days: json['days'] as int,
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
  );
}

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
      'days': instance.days,
      'start': instance.start?.toIso8601String(),
    };
