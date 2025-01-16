import 'package:flutter/material.dart';
import 'package:image_listing_app/features/listing/presentation/widgets/image_viewer.dart';

import '../../features/listing/presentation/pages/image_listing_page.dart';
import '../../features/splash/presentation/pages/splash.dart';
import 'routes.dart';

class RouteManager {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    Routes.splashPage: (BuildContext context) => const SplashPage(),
    Routes.listingPage: (BuildContext context) => const ListingPage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.viewImagePage:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ViewImage(imageUrl: args),
        );
      default:
        return null;
    }
  }
}
