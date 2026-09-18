import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

/// Ultra-refined architectural frosted glass surface with subtle specular edge,
/// calibrated optical blur, and elegant hover micro-interactions.
class LiquidGlassPanel extends StatefulWidget {
  const LiquidGlassPanel({
    required this.child,
    this.padding,
    this.borderRadius = 22,
    this.blurSigma = 20,
    this.enableHover = true,
    this.hoverScale = 1.01,
    this.onTap,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurSigma;
  final bool enableHover;
  final double hoverScale;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Clip clipBehavior;

  @override
  State<LiquidGlassPanel> createState() => _LiquidGlassPanelState();
}

class _LiquidGlassPanelState extends State<LiquidGlassPanel> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool dark = AppColors.isDark(context);
    final SmoothBorderRadius radius = SmoothBorderRadius(
      cornerRadius: widget.borderRadius,
      cornerSmoothing: 0.6,
    );

    final Color fill = dark
        ? const Color(0xFF141418).withValues(alpha: 0.72)
        : Colors.white.withValues(alpha: 0.78);

    final Color edgeSpecular = dark
        ? Colors.white.withValues(alpha: _hovered ? 0.22 : 0.12)
        : Colors.black.withValues(alpha: _hovered ? 0.12 : 0.06);

    final List<BoxShadow> shadows = <BoxShadow>[
      BoxShadow(
        color: (dark ? Colors.black : const Color(0xFF101216))
            .withValues(alpha: dark ? (_hovered ? 0.35 : 0.2) : (_hovered ? 0.08 : 0.04)),
        blurRadius: _hovered ? 24 : 14,
        offset: Offset(0, _hovered ? 10 : 6),
      ),
      if (_hovered)
        BoxShadow(
          color: AppColors.curveRed.withValues(alpha: dark ? 0.08 : 0.04),
          blurRadius: 28,
          offset: const Offset(0, 8),
        ),
    ];

    Widget panel = AnimatedScale(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      scale: widget.enableHover && _hovered ? widget.hoverScale : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        width: widget.width,
        height: widget.height,
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: radius,
            side: BorderSide(
              color: _hovered
                  ? AppColors.curveRed.withValues(alpha: dark ? 0.5 : 0.35)
                  : AppColors.strokeFor(context),
              width: 1.0,
            ),
          ),
          shadows: shadows,
        ),
        child: ClipSmoothRect(
          radius: radius,
          clipBehavior: widget.clipBehavior,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma,
              sigmaY: widget.blurSigma,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: fill,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    dark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.white.withValues(alpha: 0.9),
                    fill,
                    dark
                        ? Colors.black.withValues(alpha: 0.1)
                        : const Color(0xFFF6F8FA).withValues(alpha: 0.4),
                  ],
                  stops: const <double>[0, 0.5, 1],
                ),
              ),
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  // Specular top highlight line
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 1,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              edgeSpecular,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: widget.padding ?? const EdgeInsets.all(ResponsiveGlassInsets.md),
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.enableHover || widget.onTap != null) {
      panel = MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) {
          if (!widget.enableHover) return;
          setState(() => _hovered = true);
        },
        onExit: (_) {
          if (!widget.enableHover) return;
          setState(() => _hovered = false);
        },
        child: widget.onTap != null
            ? GestureDetector(onTap: widget.onTap, child: panel)
            : panel,
      );
    }

    return panel;
  }
}

abstract final class ResponsiveGlassInsets {
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 24;
}
