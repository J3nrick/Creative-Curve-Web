import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static final SmoothRectangleBorder smoothShape = SmoothRectangleBorder(
    borderRadius: SmoothBorderRadius(
      cornerRadius: 20,
      cornerSmoothing: 0.6,
    ),
  );

  static ThemeData get darkTheme {
    final TextTheme interText = GoogleFonts.interTextTheme();
    final TextTheme grooveText = GoogleFonts.spaceGroteskTextTheme(interText);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.curveRed,
        onPrimary: AppColors.textDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDark,
      ),
      textTheme: interText.copyWith(
        displayLarge: grooveText.displayLarge?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 0.95,
        ),
        displayMedium: grooveText.displayMedium?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1,
        ),
        headlineLarge: grooveText.headlineLarge?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        titleLarge: grooveText.titleLarge?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: interText.bodyLarge?.copyWith(
          color: AppColors.textDark,
          height: 1.45,
        ),
        bodyMedium: interText.bodyMedium?.copyWith(
          color: AppColors.textDark,
          height: 1.45,
        ),
        labelLarge: interText.labelLarge?.copyWith(
          color: AppColors.mutedTextDark,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.8,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: smoothShape,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.curveRed,
          foregroundColor: AppColors.textDark,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: smoothShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textDark,
          side: const BorderSide(color: AppColors.strokeDark),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: smoothShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF27272A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.strokeDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.strokeDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.curveRed),
        ),
      ),
      dividerColor: AppColors.strokeDark,
    );
  }

  static ThemeData get lightTheme {
    final TextTheme interText = GoogleFonts.interTextTheme();
    final TextTheme grooveText = GoogleFonts.spaceGroteskTextTheme(interText);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.curveRed,
        onPrimary: Colors.white,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textLight,
      ),
      textTheme: interText.copyWith(
        displayLarge: grooveText.displayLarge?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 0.95,
        ),
        displayMedium: grooveText.displayMedium?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1,
        ),
        headlineLarge: grooveText.headlineLarge?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        titleLarge: grooveText.titleLarge?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: interText.bodyLarge?.copyWith(
          color: AppColors.textLight,
          height: 1.45,
        ),
        bodyMedium: interText.bodyMedium?.copyWith(
          color: AppColors.textLight,
          height: 1.45,
        ),
        labelLarge: interText.labelLarge?.copyWith(
          color: AppColors.mutedTextLight,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.8,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textLight,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: smoothShape,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.curveRed,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: smoothShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textLight,
          side: const BorderSide(color: AppColors.strokeLight),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: smoothShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.strokeLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.strokeLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.curveRed),
        ),
      ),
      dividerColor: AppColors.strokeLight,
    );
  }
}
