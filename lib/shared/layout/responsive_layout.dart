import 'package:flutter/widgets.dart';

abstract final class ResponsiveLayout {
  /// Mobile: < 600px
  static const double mobileMax = 599;

  /// Tablet: 600px – 1024px
  static const double tabletMax = 1024;

  /// Desktop content cap to prevent ultra-wide stretch.
  static const double contentMaxWidth = 1200;

  /// Base unit for the 8dp spacing system.
  static const double grid = 8;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width <= mobileMax;
  }

  static bool isTablet(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return width > mobileMax && width <= tabletMax;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > tabletMax;
  }

  /// 1 / 2 / 3 column grid matching the Liquid Glass breakpoints.
  static int columnsFor(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.fromLTRB(grid * 2, grid * 3, grid * 2, grid * 5);
    }
    if (isTablet(context)) {
      return const EdgeInsets.fromLTRB(grid * 4, grid * 4, grid * 4, grid * 6);
    }
    return const EdgeInsets.fromLTRB(grid * 7, grid * 5, grid * 7, grid * 6);
  }

  static double space(double units) => grid * units;
}

/// Centers children inside a max-width content column.
class ContentConstraint extends StatelessWidget {
  const ContentConstraint({
    required this.child,
    this.maxWidth = ResponsiveLayout.contentMaxWidth,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
