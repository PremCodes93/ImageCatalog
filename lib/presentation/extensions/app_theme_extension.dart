import 'package:flutter/material.dart' show BuildContext, Theme, ThemeData;

import '../themes/app_theme.dart';
import '../themes/app_theme_data.dart';

/// Extension on BuildContext for retrieving theme data
extension AppThemeDataExtension on BuildContext {
  /// Retrieve material design theme data
  ThemeData get themeData => Theme.of(this);

  /// Retrieve application theme data
  AppThemeData get appThemeData => AppTheme.appThemeDataLight();
}
