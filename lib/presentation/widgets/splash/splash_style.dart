
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_style.freezed.dart';

@freezed
class SplashStyle with _$SplashStyle {
  const factory SplashStyle({
    required TextStyle splashTextStyle,
    required Color bgColor,
    required int controllerDuration,
    required int animDuration,
  }) = _SplashStyle;
}
