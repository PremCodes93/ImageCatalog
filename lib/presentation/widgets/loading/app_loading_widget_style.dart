import 'dart:core';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'app_loading_widget_style.freezed.dart';

@freezed
class AppLoadingWidgetStyle with _$AppLoadingWidgetStyle {
  const factory AppLoadingWidgetStyle({
     EdgeInsets? padding,
     Color? activeColor,
     Color? inactiveColor,
  }) = _AppLoadingWidgetStyle;
}
