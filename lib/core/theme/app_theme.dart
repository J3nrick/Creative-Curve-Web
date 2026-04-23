import 'package:flutter/material.dart';

/// Theme registry for the Creative Curve design system.
abstract final class AppTheme {
  static const Color _background = Color(0xFF121212);
  static const Color _text = Color(0xFFF5F5F7);
  static const Color _curveRed = Color(0xFFFF365E);
  static const Color _electricBlue = Color(0xFF00A9FF);

  /// Material 3 dark theme with premium, high-contrast agency styling.
  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _background,
      colorScheme: const ColorScheme.dark(
        primary: _curveRed,
        secondary: _electricBlue,
        surface: Color(0xFF1A1A1D),
        onPrimary: _text,
        onSecondary: _text,
        onSurface: _text,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w700,
          color: _text,
          height: 1.1,
        ),
        headlineMedium: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w700,
          color: _text,
        ),
        titleLarge: const TextStyle(
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w600,
          color: _text,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'Inter',
          color: _text,
          height: 1.5,
        ),
        bodyMedium: const TextStyle(
          fontFamily: 'Inter',
          color: _text,
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
          foregroundColor: _text,
          backgroundColor: _curveRed,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
