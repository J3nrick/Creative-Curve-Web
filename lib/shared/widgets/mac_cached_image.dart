import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_curve_web/shared/effects/mac_shimmer_loader.dart';
import 'package:creative_curve_web/shared/widgets/mac_squircle_panel.dart';
import 'package:flutter/material.dart';

class MacCachedImage extends StatelessWidget {
  const MacCachedImage({
    required this.imageUrl,
    required this.height,
    required this.width,
    super.key,
  });

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MacSquirclePanel(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (BuildContext context, String _) {
            return const MacShimmerLoader(
              child: ColoredBox(color: Color(0xFFE5E7EB)),
            );
          },
          errorWidget: (BuildContext context, String _, Object __) {
            return const ColoredBox(
              color: Color(0xFFF5F5F7),
              child: Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Color(0xFF9CA3AF),
                  size: 40,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
