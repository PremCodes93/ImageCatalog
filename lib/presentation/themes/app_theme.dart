import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/widgets/image/app_image_style.dart';
import 'package:image_listing_app/presentation/widgets/splash/splash_style.dart';

import '../widgets/loading/app_loading_widget_style.dart';
import '../widgets/shimmer/app_shimmer_style.dart';
import 'app_colors.dart';
import 'app_theme_data.dart';

class AppTheme {
  static AppThemeData appThemeDataLight() => AppThemeData(
        loadingWidgetStyle: _loadingWidgetStyle,
        imageViewerStyle: _imageViewerStyle,
        imageGridStyle: _imageGridStyle,
        appShimmerStyle: _appShimmerStyle,
        splashStyle: _splashStyle,
      );

  /// Styles for widgets
  static const _loadingWidgetStyle = AppLoadingWidgetStyle(activeColor: AppColors.bgMildDarkGrey);
  static const _imageViewerStyle = ImageViewerStyle(
    minScale: 0.5,
    maxScale: 4.0,
    elevation: 0.0,
    bgColor: AppColors.bgDarkGrey,
    backIconColor: AppColors.bgWhite,
    imageFit: BoxFit.contain,
  );
  static const _appShimmerStyle = AppShimmerStyle(
    baseColor: AppColors.shimmerBaseColor,
    hgColor: AppColors.shimmerHgColor,
    boxColor: AppColors.shimmerShadowColor,
    duration: 850,
    borderRadius: 8.0,
  );
  static const _splashStyle = SplashStyle(
    splashTextStyle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.bgDarkGrey,
    ),
    bgColor: AppColors.bgWhite,
    controllerDuration: 2,
    animDuration: 1,
  );

  static const _imageGridStyle = ImageGridStyle(
      crossAxisCount: 1,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      width: 0.8,
      height: 0.7,
      shadowBlurRadius: 10.0,
      shadowOffset: Offset(0, 5),
      outerBorder: 16.0,
      innerBorder: 8.0,
      bgColor: AppColors.bgMildDarkGrey,
      borderColor: AppColors.bgLightGrey,
      shadowColor: AppColors.bgMildDarkGrey,
      imageFit: BoxFit.cover,
      alignment: Alignment.center);

  /// app level theming
  static ThemeData themeDataLight() => _themeDataCommon().copyWith(
          colorScheme: ColorScheme.light(
        primary: AppColors.bgDarkGrey,
        onPrimary: AppColors.bgMildDarkGrey,
        onSurface: AppColors.bgLightGrey,
        onSecondary: AppColors.bgLightGrey,
      ).copyWith(surface: AppColors.bgLightGrey));

  /// Common theme to disable default splash/ripple/ink effect on Widgets
  static ThemeData _themeDataCommon() => ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bgBlue),
        useMaterial3: true,
      );
}
