import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/extensions/app_theme_extension.dart';
import 'package:image_listing_app/presentation/widgets/shimmer/app_shimmer.dart';

import '../../../../presentation/routes/routes.dart';

class ImageGridBuilder extends StatelessWidget {
  const ImageGridBuilder({required this.urlList, required this.controller, super.key});

  final List<String> urlList;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appThemeData.imageGridStyle.bgColor,
      child: Align(
        alignment: context.appThemeData.imageGridStyle.alignment,
        child: Container(
          width: MediaQuery.of(context).size.width * context.appThemeData.imageGridStyle.width,
          height: MediaQuery.of(context).size.height * context.appThemeData.imageGridStyle.height,
          decoration: BoxDecoration(
            color: context.appThemeData.imageGridStyle.borderColor,
            borderRadius: BorderRadius.circular(context.appThemeData.imageGridStyle.outerBorder),
            boxShadow: [
              BoxShadow(
                color: context.appThemeData.imageGridStyle.borderColor,
                blurRadius: context.appThemeData.imageGridStyle.shadowBlurRadius,
                offset: context.appThemeData.imageGridStyle.shadowOffset,
              ),
            ],
          ),
          child: GridView.builder(
            controller: controller,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.appThemeData.imageGridStyle.crossAxisCount,
              crossAxisSpacing: context.appThemeData.imageGridStyle.crossAxisSpacing,
              mainAxisSpacing: context.appThemeData.imageGridStyle.mainAxisSpacing,
            ),
            itemCount: urlList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.viewImagePage, arguments: urlList[index]);
                },
                child: Hero(
                  tag: urlList[index],
                  child: CachedNetworkImage(
                    /// Using the URL as a unique cache key to manage cache more precisely and avoid conflicts
                    cacheKey: urlList[index],
                    imageUrl: urlList[index],
                    placeholder: (context, url) {
                      return AppShimmer();
                    },
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: context.appThemeData.imageGridStyle.imageFit,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.appThemeData.imageGridStyle.innerBorder),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: context.appThemeData.imageGridStyle.imageFit,
                        ),
                      ),
                    ),
                    // fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
