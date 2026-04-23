import 'package:creative_curve_web/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    final TextTheme interText = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.curveRed,
        onPrimary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.charcoal,
      ),
      textTheme: interText.copyWith(
        displayLarge: interText.displayLarge?.copyWith(
          color: AppColors.charcoal,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.2,
          height: 0.95,
        ),
        displayMedium: interText.displayMedium?.copyWith(
          color: AppColors.charcoal,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1,
        ),
        headlineLarge: interText.headlineLarge?.copyWith(
          color: AppColors.charcoal,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        titleLarge: interText.titleLarge?.copyWith(
          color: AppColors.charcoal,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: interText.bodyLarge?.copyWith(
          color: AppColors.charcoal,
          height: 1.45,
        ),
        bodyMedium: interText.bodyMedium?.copyWith(
          color: AppColors.charcoal,
          height: 1.45,
        ),
        labelLarge: interText.labelLarge?.copyWith(
          color: AppColors.mutedText,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.charcoal,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.charcoal,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
        ),
      ),
      dividerColor: AppColors.stroke,
    );
  }
}
