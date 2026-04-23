import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class MacSquirclePanel extends StatelessWidget {
  const MacSquirclePanel({
    required this.child,
    this.padding,
    this.color,
    this.border,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderSide? border;

  static final SmoothBorderRadius _radius = SmoothBorderRadius(
    cornerRadius: 32,
    cornerSmoothing: 0.6,
  );

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: ShapeBorderClipper(
        shape: SmoothRectangleBorder(borderRadius: _radius),
      ),
      color: color ?? Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: ShapeDecoration(
          color: color ?? Colors.white,
          shape: SmoothRectangleBorder(
            borderRadius: _radius,
            side: border ?? const BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
