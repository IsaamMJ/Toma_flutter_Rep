import 'package:flutter/material.dart';
import '../../app/theme/app_constants.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileWidth && width < AppConstants.tabletWidth;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletWidth; // REVERTED: Back to original tabletWidth
  }

  static double getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > AppConstants.desktopWidth) {
      return AppConstants.desktopWidth;
    }
    return width;
  }

  static EdgeInsets getHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: AppConstants.paddingS);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: AppConstants.paddingL);
    } else {
      return const EdgeInsets.symmetric(horizontal: AppConstants.paddingXL);
    }
  }

  // Responsive spacing helper
  static double getResponsiveValue({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Quick responsive text style getter
  static TextStyle getResponsiveTextStyle(
      BuildContext context,
      TextStyle baseStyle,
      double mobileScale,
      ) {
    if (isMobile(context)) {
      return baseStyle.copyWith(fontSize: baseStyle.fontSize! * mobileScale);
    }
    return baseStyle;
  }

  // NEW: Get responsive logo card width
  static double? getLogoCardWidth(BuildContext context) {
    if (isMobile(context)) {
      return (MediaQuery.of(context).size.width - 80) / 3; // 3 per row with padding (CHANGED from 2 to 3)
    } else if (isTablet(context)) {
      return (MediaQuery.of(context).size.width - 120) / 3; // 3 per row with padding
    }
    return null; // Desktop uses Expanded in Row
  }

  // NEW: Get responsive logo card height (REDUCED for compact layout)
  static double getLogoCardHeight(BuildContext context) {
    return getResponsiveValue(
      context: context,
      mobile: 45,    // Reduced from 60
      tablet: 55,    // Reduced from 70
      desktop: 80,   // Keep desktop same
    );
  }
}