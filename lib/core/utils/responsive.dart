import 'package:flutter/widgets.dart';

/// Simple responsive breakpoint helper used across the app so screens
/// adapt between phone, tablet, and web-admin (wide) layouts.
class Responsive {
  Responsive._();

  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Returns a value scaled by screen type — useful for paddings/fonts.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  /// Grid column count for feeds (live list, short videos, gift shop).
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) return 5;
    if (isTablet(context)) return 3;
    return 2;
  }
}
