import 'package:flutter/widgets.dart';

abstract final class ResponsiveLayout {
  static const double mobileMax = 767;
  static const double tabletMax = 1100;

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
}
