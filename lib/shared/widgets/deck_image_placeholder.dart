import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class DeckImagePlaceholder extends StatelessWidget {
  const DeckImagePlaceholder({
    required this.label,
    required this.height,
    super.key,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.surface,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 32,
            cornerSmoothing: 0.84,
          ),
          side: const BorderSide(color: AppColors.stroke),
        ),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.mutedText,
                letterSpacing: 0.3,
              ),
        ),
      ),
    );
  }
}
