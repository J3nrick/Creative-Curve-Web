import 'package:flutter/material.dart';

abstract final class AppColors {
  // --- DARK THEME TOKENS ---
  static const Color backgroundDark = Color(0xFF09090B);
  static const Color surfaceDark = Color(0xFF141417);
  static const Color elevatedDark = Color(0xFF1B1B20);
  static const Color textDark = Color(0xFFF4F4F6);
  static const Color mutedTextDark = Color(0xFF9898A4);
  static const Color subtleTextDark = Color(0xFF636370);
  static const Color strokeDark = Color(0xFF242429);
  static const Color specularDark = Color(0x33FFFFFF);

  // --- LIGHT THEME TOKENS ---
  static const Color backgroundLight = Color(0xFFF7F8FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color elevatedLight = Color(0xFFFDFCFC);
  static const Color textLight = Color(0xFF0F1013);
  static const Color mutedTextLight = Color(0xFF5E6572);
  static const Color subtleTextLight = Color(0xFF8E95A2);
  static const Color strokeLight = Color(0xFFE2E4E9);
  static const Color specularLight = Color(0xCCFFFFFF);

  // --- BRAND ACCENT TOKENS ---
  static const Color curveRed = Color(0xFFFF3B30);
  static const Color curveRedHover = Color(0xFFFF5449);
  static const Color curveRedGlow = Color(0x28FF3B30);

  // --- LEGACY ALIASES (Routed to brand tokens) ---
  static const Color background = backgroundDark;
  static const Color surface = surfaceDark;
  static const Color charcoal = textDark;
  static const Color mutedText = mutedTextDark;
  static const Color stroke = strokeDark;
  static const Color offWhite = textDark;
  static const Color muted = mutedTextDark;
  static const Color electricBlue = curveRed;

  // --- CONTEXT HELPERS ---
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color backgroundFor(BuildContext context) {
    return isDark(context) ? backgroundDark : backgroundLight;
  }

  static Color surfaceFor(BuildContext context) {
    return isDark(context) ? surfaceDark : surfaceLight;
  }

  static Color elevatedSurfaceFor(BuildContext context) {
    return isDark(context) ? elevatedDark : elevatedLight;
  }

  static Color textFor(BuildContext context) {
    return isDark(context) ? textDark : textLight;
  }

  static Color mutedFor(BuildContext context) {
    return isDark(context) ? mutedTextDark : mutedTextLight;
  }

  static Color subtleFor(BuildContext context) {
    return isDark(context) ? subtleTextDark : subtleTextLight;
  }

  static Color strokeFor(BuildContext context) {
    return isDark(context) ? strokeDark : strokeLight;
  }

  static Color specularFor(BuildContext context) {
    return isDark(context) ? specularDark : specularLight;
  }
}
