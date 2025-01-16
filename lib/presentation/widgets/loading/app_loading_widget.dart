import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/extensions/app_theme_extension.dart';


class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height,
      child: Center(child: CircularProgressIndicator(color: context.appThemeData.loadingWidgetStyle?.activeColor)),
    );
  }
}


