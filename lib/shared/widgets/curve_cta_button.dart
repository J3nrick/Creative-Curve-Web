import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:creative_curve_web/shared/interactions/cursor_magnet_scope.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class CurveCtaButton extends StatefulWidget {
  const CurveCtaButton({
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.icon,
    this.enableMagnet = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final IconData? icon;
  final bool enableMagnet;

  @override
  State<CurveCtaButton> createState() => _CurveCtaButtonState();
}

class _CurveCtaButtonState extends State<CurveCtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColors.isDark(context);

    final Widget buttonContent;
    if (widget.outlined) {
      buttonContent = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: ShapeDecoration(
            color: _isHovered
                ? AppColors.textFor(context).withValues(alpha: 0.08)
                : Colors.transparent,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 14,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: _isHovered
                    ? AppColors.textFor(context).withValues(alpha: 0.4)
                    : AppColors.strokeFor(context),
                width: 1.2,
              ),
            ),
          ),
          child: TextButton.icon(
            onPressed: widget.onPressed,
            icon: widget.icon != null
                ? Icon(widget.icon, size: 16)
                : const SizedBox.shrink(),
            label: Text(widget.label),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textFor(context),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      );
    } else {
      buttonContent = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translateByDouble(0.0, _isHovered ? -2.0 : 0.0, 0.0, 1.0),
          decoration: ShapeDecoration(
            color: _isHovered ? AppColors.curveRedHover : AppColors.curveRed,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 14,
                cornerSmoothing: 0.6,
              ),
              side: BorderSide(
                color: Colors.white.withValues(alpha: isDark ? 0.25 : 0.4),
                width: 1.0,
              ),
            ),
            shadows: [
              BoxShadow(
                color:
                    AppColors.curveRed.withValues(alpha: _isHovered ? 0.35 : 0.18),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: FilledButton.icon(
            onPressed: widget.onPressed,
            icon: widget.icon != null
                ? Icon(widget.icon, size: 16)
                : const SizedBox.shrink(),
            label: Text(widget.label),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      );
    }

    if (!widget.enableMagnet) {
      return buttonContent;
    }

    return CursorMagnetScope(
      maxDistance: 8.0,
      strength: 0.26,
      child: buttonContent,
    );
  }
}
