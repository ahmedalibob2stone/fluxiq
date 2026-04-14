import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final String imageAsset;
  const PageBackground({required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imageAsset,
          alignment: const Alignment(0.0, -0.2),
          fit: BoxFit.cover,
          cacheWidth: 1080,
          errorBuilder: (_, __, ___) => const Center(
            child: Icon(Icons.broken_image, color: Colors.white, size: 50),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.transparent,
                Colors.transparent,
                Colors.black87,
              ],
              stops: [0.0, 0.2, 0.7, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
