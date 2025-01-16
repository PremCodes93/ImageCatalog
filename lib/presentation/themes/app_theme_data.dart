import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_listing_app/presentation/widgets/shimmer/app_shimmer_style.dart';
import 'package:image_listing_app/presentation/widgets/splash/splash_style.dart';

import '../widgets/image/app_image_style.dart';
import '../widgets/loading/app_loading_widget_style.dart';

part 'app_theme_data.freezed.dart';

@freezed
class AppThemeData with _$AppThemeData {
  const factory AppThemeData({
    required AppLoadingWidgetStyle loadingWidgetStyle,
    required ImageViewerStyle imageViewerStyle,
    required ImageGridStyle imageGridStyle,
    required AppShimmerStyle appShimmerStyle,
    required SplashStyle splashStyle,
  }) = _AppThemeData;
}
