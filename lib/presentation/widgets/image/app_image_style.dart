import 'dart:core';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_image_style.freezed.dart';

@freezed
class ImageViewerStyle with _$ImageViewerStyle {
  const factory ImageViewerStyle({
    required double minScale,
    required double maxScale,
    required double elevation,
    required Color bgColor,
    required Color backIconColor,
    required BoxFit imageFit,
  }) = _ImageViewerStyle;
}

@freezed
class ImageGridStyle with _$ImageGridStyle {
  const factory ImageGridStyle({
    required int crossAxisCount,
    required double crossAxisSpacing,
    required double mainAxisSpacing,
    required double width,
    required double height,
    required double shadowBlurRadius,
    required Offset shadowOffset,
    required double outerBorder,
    required double innerBorder,
    required Color bgColor,
    required Color borderColor,
    required Color shadowColor,
    required BoxFit imageFit,
    required Alignment alignment,
  }) = _ImageGridStyle;
}
