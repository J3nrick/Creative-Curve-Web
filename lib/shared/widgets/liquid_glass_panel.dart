import 'dart:ui';

import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Frosted liquid-glass surface with specular edge, inner highlight,
/// and optional hover morph (scale + red accent glow).
class LiquidGlassPanel extends StatefulWidget {
  const LiquidGlassPanel({
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.blurSigma = 22,
    this.enableHover = true,
    this.hoverScale = 1.02,
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
    final BorderRadius radius = BorderRadius.circular(widget.borderRadius);

    final Color fill = dark
        ? AppColors.surfaceDark.withValues(alpha: 0.55)
        : Colors.white.withValues(alpha: 0.52);

    final Color edgeTop = dark
        ? Colors.white.withValues(alpha: 0.28)
        : Colors.white.withValues(alpha: 0.85);
    final Color edgeRed = AppColors.curveRed.withValues(alpha: _hovered ? 0.55 : 0.22);
    final Color edgeFade = dark
        ? Colors.white.withValues(alpha: 0.04)
        : Colors.white.withValues(alpha: 0.08);

    final List<BoxShadow> shadows = <BoxShadow>[
      BoxShadow(
        color: AppColors.curveRed.withValues(alpha: _hovered ? 0.18 : 0.08),
        blurRadius: _hovered ? 28 : 18,
        offset: Offset(0, _hovered ? 14 : 10),
        spreadRadius: _hovered ? 1 : 0,
      ),
      BoxShadow(
        color: (dark ? Colors.black : const Color(0xFF1A1A1F))
            .withValues(alpha: dark ? 0.35 : 0.08),
        blurRadius: 24,
        offset: const Offset(0, 12),
      ),
    ];

    Widget panel = AnimatedScale(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      scale: widget.enableHover && _hovered ? widget.hoverScale : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: shadows,
        ),
        child: ClipRRect(
          borderRadius: radius,
          clipBehavior: widget.clipBehavior,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma,
              sigmaY: widget.blurSigma,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: fill,
                borderRadius: radius,
                border: Border.all(
                  width: 1.2,
                  color: Colors.transparent,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    edgeTop.withValues(alpha: dark ? 0.14 : 0.35),
                    fill,
                    AppColors.curveRed.withValues(alpha: dark ? 0.06 : 0.04),
                  ],
                  stops: const <double>[0, 0.45, 1],
                ),
              ),
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  // Specular stroke ring (multi-stop feel via layered borders).
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          border: Border(
                            top: BorderSide(color: edgeTop, width: 1.1),
                            left: BorderSide(
                              color: edgeTop.withValues(alpha: 0.55),
                              width: 1,
                            ),
                            right: BorderSide(color: edgeFade, width: 1),
                            bottom: BorderSide(color: edgeRed, width: _hovered ? 1.4 : 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Inner highlight wash (top-left refraction).
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
                              Colors.white.withValues(alpha: dark ? 0.35 : 0.7),
                              Colors.white.withValues(alpha: 0),
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
  static const double md = 16;
  static const double lg = 24;
}
