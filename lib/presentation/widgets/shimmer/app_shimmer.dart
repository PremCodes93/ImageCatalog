import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/extensions/app_theme_extension.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appThemeData.appShimmerStyle.baseColor,
      highlightColor: context.appThemeData.appShimmerStyle.hgColor,
      period: Duration(milliseconds: context.appThemeData.appShimmerStyle.duration),
      child: Container(
        decoration: BoxDecoration(
          color: context.appThemeData.appShimmerStyle.boxColor,
          borderRadius: BorderRadius.circular(context.appThemeData.appShimmerStyle.borderRadius),
        ),
      ),
    );
  }
}
