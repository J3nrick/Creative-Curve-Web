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

  static final SmoothRectangleBorder buttonShape = SmoothRectangleBorder(
    borderRadius: SmoothBorderRadius(
      cornerRadius: 14,
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
        onPrimary: Colors.white,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDark,
      ),
      textTheme: interText.copyWith(
        displayLarge: grooveText.displayLarge?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.2,
          height: 1.05,
        ),
        displayMedium: grooveText.displayMedium?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.0,
          height: 1.08,
        ),
        displaySmall: grooveText.displaySmall?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          height: 1.12,
        ),
        headlineLarge: grooveText.headlineLarge?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
        headlineMedium: grooveText.headlineMedium?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
        ),
        titleLarge: grooveText.titleLarge?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: interText.titleMedium?.copyWith(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: interText.bodyLarge?.copyWith(
          color: AppColors.textDark,
          height: 1.55,
        ),
        bodyMedium: interText.bodyMedium?.copyWith(
          color: AppColors.textDark,
          height: 1.5,
        ),
        labelLarge: interText.labelLarge?.copyWith(
          color: AppColors.mutedTextDark,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.4,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textDark,
          fontSize: 15,
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
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          shape: buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textDark,
          side: const BorderSide(color: AppColors.strokeDark, width: 1.2),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          shape: buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF16161A),
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
          borderSide: const BorderSide(color: AppColors.curveRed, width: 1.5),
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
          fontWeight: FontWeight.w900,
          letterSpacing: -1.2,
          height: 1.05,
        ),
        displayMedium: grooveText.displayMedium?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.0,
          height: 1.08,
        ),
        displaySmall: grooveText.displaySmall?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          height: 1.12,
        ),
        headlineLarge: grooveText.headlineLarge?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
        headlineMedium: grooveText.headlineMedium?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
        ),
        titleLarge: grooveText.titleLarge?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: interText.titleMedium?.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: interText.bodyLarge?.copyWith(
          color: AppColors.textLight,
          height: 1.55,
        ),
        bodyMedium: interText.bodyMedium?.copyWith(
          color: AppColors.textLight,
          height: 1.5,
        ),
        labelLarge: interText.labelLarge?.copyWith(
          color: AppColors.mutedTextLight,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.4,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textLight,
          fontSize: 15,
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
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          shape: buttonShape,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textLight,
          side: const BorderSide(color: AppColors.strokeLight, width: 1.2),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          shape: buttonShape,
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
          borderSide: const BorderSide(color: AppColors.curveRed, width: 1.5),
        ),
      ),
      dividerColor: AppColors.strokeLight,
    );
  }
}
