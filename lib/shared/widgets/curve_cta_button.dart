import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CurveCtaButton extends StatefulWidget {
  const CurveCtaButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  State<CurveCtaButton> createState() => _CurveCtaButtonState();
}

class _CurveCtaButtonState extends State<CurveCtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: _isHovered
                ? const [AppColors.electricBlue, AppColors.curveRed]
                : const [AppColors.curveRed, AppColors.electricBlue],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.curveRed.withValues(alpha: _isHovered ? 0.45 : 0.25),
              blurRadius: _isHovered ? 26 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: AppColors.offWhite,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
