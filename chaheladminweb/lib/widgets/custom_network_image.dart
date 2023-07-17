import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.borderRadius,
      this.fit,
      this.shimmerRadius});
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final double? shimmerRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CustomShimmer(
          radius: shimmerRadius,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: fit,
      ),
    );
  }
}
