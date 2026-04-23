import 'package:flutter/material.dart';

/// Theme registry for the Creative Curve design system.
abstract final class AppTheme {
  static const Color background = Color(0xFF121212);
  static const Color text = Color(0xFFF5F5F7);
  static const Color curveRed = Color(0xFFFF365E);
  static const Color electricBlue = Color(0xFF00A9FF);
  static const Color tileHoverRedTint = Color(0x33FF365E);
  static const Color tileHoverBlueTint = Color(0x3300A9FF);
  static const Color tileBaseWhiteTint = Color(0x1AFFFFFF);
  static const Color tileBorderIdle = Color(0x55FFFFFF);
  static const Duration tileAnimationDuration = Duration(milliseconds: 200);

  /// Material 3 dark theme with premium, high-contrast agency styling.
  ///
  /// The custom font family names intentionally fall back to built-in sans-serif
  /// stacks so the UI remains stable until bundled font assets are configured.
  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: curveRed,
        secondary: electricBlue,
        surface: Color(0xFF1A1A1D),
        onPrimary: text,
        onSecondary: text,
        onSurface: text,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: <String>['Inter', 'sans-serif'],
          fontWeight: FontWeight.w700,
          color: text,
          height: 1.1,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: <String>['Inter', 'sans-serif'],
          fontWeight: FontWeight.w700,
          color: text,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontFamilyFallback: <String>['Inter', 'sans-serif'],
          fontWeight: FontWeight.w600,
          color: text,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Inter',
          fontFamilyFallback: <String>['Space Grotesk', 'sans-serif'],
          color: text,
          height: 1.5,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Inter',
          fontFamilyFallback: <String>['Space Grotesk', 'sans-serif'],
          color: text,
          height: 1.4,
        ),
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF1A1A1D),
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: text,
          backgroundColor: curveRed,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
