import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SafeCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const SafeCachedImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _buildPlaceholder();
    }

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      progressIndicatorBuilder: (_, __, progress) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: CircularProgressIndicator(
            value: progress.progress,
            strokeWidth: 2,
            color: Colors.grey.shade400,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => _buildPlaceholder(),
      errorListener: (error) {},
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _buildPlaceholder() {
    final iconSize = (width < height ? width : height) * 0.35;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: iconSize.clamp(20.0, 60.0),
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}