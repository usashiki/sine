import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

@JsonSerializable()
class AppSettings {
  /// The theme of the app.
  final int themeColorInt;

  const AppSettings({
    this.themeColorInt = 0xFF2196F3,
  });

  Color get themeColor => Color(themeColorInt);

  AppSettings copyWith({int themeColorInt}) => AppSettings(
        themeColorInt: themeColorInt ?? this.themeColorInt,
      );

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}
