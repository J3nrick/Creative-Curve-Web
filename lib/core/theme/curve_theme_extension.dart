import 'dart:ui';
import 'package:flutter/material.dart';

/// Design tokens and glassmorphism parameters encapsulated in a [ThemeExtension]
/// to enable instantaneous, zero-layout-shift theme transitions.
class CurveThemeExtension extends ThemeExtension<CurveThemeExtension> {
  const CurveThemeExtension({
    required this.curveRed,
    required this.curveRedHover,
    required this.curveRedGlow,
    required this.background,
    required this.surface,
    required this.darkSurface,
    required this.elevatedSurface,
    required this.textPrimary,
    required this.textMuted,
    required this.textSubtle,
    required this.stroke,
    required this.specular,
    required this.glassFill,
    required this.glassBorder,
    this.glassBlurSigma = 20.0,
  });

  // --- BRAND ACCENTS ---
  final Color curveRed;
  final Color curveRedHover;
  final Color curveRedGlow;

  // --- SURFACES & BACKGROUNDS ---
  final Color background;
  final Color surface;
  final Color darkSurface;
  final Color elevatedSurface;

  // --- TYPOGRAPHY COLORS ---
  final Color textPrimary;
  final Color textMuted;
  final Color textSubtle;

  // --- BORDERS & GLASS HIGHLIGHTS ---
  final Color stroke;
  final Color specular;
  final Color glassFill;
  final Color glassBorder;
  final double glassBlurSigma;

  // --- DARK MODE PRESET (Default macOS Studio) ---
  static const CurveThemeExtension dark = CurveThemeExtension(
    curveRed: Color(0xFFFF3B30),
    curveRedHover: Color(0xFFFF5449),
    curveRedGlow: Color(0x28FF3B30),
    background: Color(0xFF09090B),
    surface: Color(0xFF141417),
    darkSurface: Color(0xFF141417),
    elevatedSurface: Color(0xFF1B1B20),
    textPrimary: Color(0xFFF4F4F6),
    textMuted: Color(0xFF9898A4),
    textSubtle: Color(0xFF636370),
    stroke: Color(0xFF242429),
    specular: Color(0x33FFFFFF),
    glassFill: Color(0xB8141417),
    glassBorder: Color(0x33FFFFFF),
    glassBlurSigma: 20.0,
  );

  // --- LIGHT MODE PRESET (Clean Architectural White) ---
  static const CurveThemeExtension light = CurveThemeExtension(
    curveRed: Color(0xFFFF3B30),
    curveRedHover: Color(0xFFFF5449),
    curveRedGlow: Color(0x28FF3B30),
    background: Color(0xFFF7F8FA),
    surface: Color(0xFFFFFFFF),
    darkSurface: Color(0xFF141417),
    elevatedSurface: Color(0xFFFDFCFC),
    textPrimary: Color(0xFF0F1013),
    textMuted: Color(0xFF5E6572),
    textSubtle: Color(0xFF8E95A2),
    stroke: Color(0xFFE2E4E9),
    specular: Color(0xCCFFFFFF),
    glassFill: Color(0xC7FFFFFF),
    glassBorder: Color(0x1F000000),
    glassBlurSigma: 20.0,
  );

  @override
  CurveThemeExtension copyWith({
    Color? curveRed,
    Color? curveRedHover,
    Color? curveRedGlow,
    Color? background,
    Color? surface,
    Color? darkSurface,
    Color? elevatedSurface,
    Color? textPrimary,
    Color? textMuted,
    Color? textSubtle,
    Color? stroke,
    Color? specular,
    Color? glassFill,
    Color? glassBorder,
    double? glassBlurSigma,
  }) {
    return CurveThemeExtension(
      curveRed: curveRed ?? this.curveRed,
      curveRedHover: curveRedHover ?? this.curveRedHover,
      curveRedGlow: curveRedGlow ?? this.curveRedGlow,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      darkSurface: darkSurface ?? this.darkSurface,
      elevatedSurface: elevatedSurface ?? this.elevatedSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textSubtle: textSubtle ?? this.textSubtle,
      stroke: stroke ?? this.stroke,
      specular: specular ?? this.specular,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      glassBlurSigma: glassBlurSigma ?? this.glassBlurSigma,
    );
  }

  @override
  CurveThemeExtension lerp(
    covariant ThemeExtension<CurveThemeExtension>? other,
    double t,
  ) {
    if (other is! CurveThemeExtension) {
      return this;
    }

    return CurveThemeExtension(
      curveRed: Color.lerp(curveRed, other.curveRed, t) ?? curveRed,
      curveRedHover:
          Color.lerp(curveRedHover, other.curveRedHover, t) ?? curveRedHover,
      curveRedGlow:
          Color.lerp(curveRedGlow, other.curveRedGlow, t) ?? curveRedGlow,
      background:
          Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      darkSurface:
          Color.lerp(darkSurface, other.darkSurface, t) ?? darkSurface,
      elevatedSurface: Color.lerp(elevatedSurface, other.elevatedSurface, t) ??
          elevatedSurface,
      textPrimary:
          Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textMuted: Color.lerp(textMuted, other.textMuted, t) ?? textMuted,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t) ?? textSubtle,
      stroke: Color.lerp(stroke, other.stroke, t) ?? stroke,
      specular: Color.lerp(specular, other.specular, t) ?? specular,
      glassFill: Color.lerp(glassFill, other.glassFill, t) ?? glassFill,
      glassBorder:
          Color.lerp(glassBorder, other.glassBorder, t) ?? glassBorder,
      glassBlurSigma:
          lerpDouble(glassBlurSigma, other.glassBlurSigma, t) ?? glassBlurSigma,
    );
  }
}

/// Convenience extensions on [BuildContext] to access [CurveThemeExtension]
extension CurveThemeContext on BuildContext {
  CurveThemeExtension get curveTheme =>
      Theme.of(this).extension<CurveThemeExtension>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? CurveThemeExtension.dark
          : CurveThemeExtension.light);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
