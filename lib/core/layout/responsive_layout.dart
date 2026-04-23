import 'package:flutter/material.dart';

/// Adaptive layout helper for mobile, tablet, and desktop breakpoints.
class ResponsiveLayout extends StatelessWidget {
  /// Creates a responsive widget that renders one of three child layouts.
  const ResponsiveLayout({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    super.key,
  });

  /// Layout rendered below 600 logical pixels.
  final Widget mobile;

  /// Layout rendered from 600 to 1023 logical pixels.
  final Widget tablet;

  /// Layout rendered at 1024+ logical pixels.
  final Widget desktop;

  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  /// Whether the current viewport is in mobile range.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileMaxWidth;

  /// Whether the current viewport is in tablet range.
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  /// Whether the current viewport is in desktop range.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletMaxWidth;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    }
    if (isTablet(context)) {
      return tablet;
    }
    return mobile;
  }
}
