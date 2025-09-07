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
    return MediaQuery.of(context).size.width >= AppConstants.tabletWidth;
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
}