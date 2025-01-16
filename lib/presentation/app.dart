import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/themes/app_theme.dart';

import 'data/presentation_constants.dart';
import 'routes/routes_barrel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: PresentationConstants.appTitle,
      routes: RouteManager.routes,
      onGenerateRoute: RouteManager.generateRoute,
      initialRoute: Routes.splashPage,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeDataLight(),
    );
  }
}