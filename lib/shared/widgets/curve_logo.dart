import 'package:creative_curve_web/core/constants/app_assets.dart';
import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum CurveLogoVariant {
  red,
  white,
}

class CurveLogo extends StatelessWidget {
  const CurveLogo({
    required this.height,
    super.key,
    this.variant,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.semanticLabel,
  });

  final double height;
  final CurveLogoVariant? variant;
  final Color? backgroundColor;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final CurveLogoVariant resolved = variant ??
        _resolveVariant(
            backgroundColor ?? Theme.of(context).scaffoldBackgroundColor);

    return ExcludeSemantics(
      excluding: semanticLabel == null,
      child: Image.asset(
        resolved == CurveLogoVariant.white
            ? AppAssets.logoWhite
            : AppAssets.logoRed,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return SizedBox(
            height: height,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'curve',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: resolved == CurveLogoVariant.white
                          ? Colors.white
                          : AppColors.curveRed,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  CurveLogoVariant _resolveVariant(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? CurveLogoVariant.white
        : CurveLogoVariant.red;
  }
}
