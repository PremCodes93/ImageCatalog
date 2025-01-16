import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_listing_app/presentation/extensions/app_theme_extension.dart';
import 'package:image_listing_app/presentation/widgets/shimmer/app_shimmer.dart';

class ViewImage extends StatelessWidget {
  final String imageUrl;

  const ViewImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appThemeData.imageViewerStyle.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: context.appThemeData.imageViewerStyle.elevation,
        iconTheme: IconThemeData(color: context.appThemeData.imageViewerStyle.backIconColor),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: InteractiveViewer(
            panEnabled: true, // Allow panning
            minScale: context.appThemeData.imageViewerStyle.minScale,
            maxScale: context.appThemeData.imageViewerStyle.maxScale,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: context.appThemeData.imageViewerStyle.imageFit,
              placeholder: (context, url) => AppShimmer(),
            ),
          ),
        ),
      ),
    );
  }
}
