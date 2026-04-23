import 'package:flutter/material.dart';

/// Shared CTA button with consistent interactive motion behavior.
class CurveButton extends StatefulWidget {
  /// Creates a CTA button used across sections and feature modules.
  const CurveButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  /// Button label shown to users.
  final String label;

  /// Callback executed when the button is activated.
  final VoidCallback? onPressed;

  @override
  State<CurveButton> createState() => _CurveButtonState();
}

class _CurveButtonState extends State<CurveButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 160),
        scale: _isHovered ? 1.02 : 1,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Text(widget.label),
        ),
      ),
    );
  }
}
