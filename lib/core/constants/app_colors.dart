import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color backgroundDark = Color(0xFF0A0A0A);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color textDark = Color(0xFFF5F5F7);
  static const Color mutedTextDark = Color(0xFFB2B2B8);
  static const Color strokeDark = Color(0xFF323236);

  static const Color backgroundLight = Color(0xFFF6F6F8);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF101114);
  static const Color mutedTextLight = Color(0xFF5C6470);
  static const Color strokeLight = Color(0xFFD9DDE3);

  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF1C1C1E);
  static const Color charcoal = Color(0xFFF5F5F7);
  static const Color curveRed = Color(0xFFFF3B30);
  static const Color mutedText = Color(0xFFB2B2B8);
  static const Color stroke = Color(0xFF323236);

  // Temporary aliases while legacy modules are still being migrated.
  static const Color electricBlue = Color(0xFF4C6FFF);
  static const Color offWhite = Color(0xFFF5F5F7);
  static const Color muted = Color(0xFF8F8F98);

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color backgroundFor(BuildContext context) {
    return isDark(context) ? backgroundDark : backgroundLight;
  }

  static Color surfaceFor(BuildContext context) {
    return isDark(context) ? surfaceDark : surfaceLight;
  }

  static Color textFor(BuildContext context) {
    return isDark(context) ? textDark : textLight;
  }

  static Color mutedFor(BuildContext context) {
    return isDark(context) ? mutedTextDark : mutedTextLight;
  }

  static Color strokeFor(BuildContext context) {
    return isDark(context) ? strokeDark : strokeLight;
  }

  static Color elevatedSurfaceFor(BuildContext context) {
    return isDark(context) ? const Color(0xFF232326) : const Color(0xFFFDFDFE);
  }
}
