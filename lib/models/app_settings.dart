import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

@JsonSerializable()
class AppSettings {
  /// The theme color of the app. Also serves as the default [Tracker] color.
  /// Defaults to [Colors.blue].
  final int themeColorInt;

  /// Model for app settings. Currently unused.
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
