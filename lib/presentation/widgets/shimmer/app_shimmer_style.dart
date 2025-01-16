import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_shimmer_style.freezed.dart';

@freezed
class AppShimmerStyle with _$AppShimmerStyle {
  const factory AppShimmerStyle({
    required Color baseColor,
    required Color hgColor,
    required Color boxColor,
    required int duration,
    required double borderRadius,
  }) = _AppShimmerStyle;
}
