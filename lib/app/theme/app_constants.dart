class AppConstants {
  // App info
  static const String appName = 'Toma';

  // Responsive breakpoints (Updated to web standards)
  static const double mobileWidth = 768;
  static const double tabletWidth = 992;   // Tablet range: 768-991px
  static const double desktopWidth = 1440; // Desktop: 992px and above
  static const double maxContentWidth = 1200; // Professional layout constraint

  // Spacing system
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  static const double spaceXXXL = 64.0;
  static const double spaceHuge = 80.0;

  // Legacy padding system (for backward compatibility)
  static const double paddingXS = spaceS;
  static const double paddingS = spaceM;
  static const double paddingM = spaceL;
  static const double paddingL = spaceXL;
  static const double paddingXL = spaceXXL;
  static const double paddingXXL = spaceXXXL;

  // Border radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusRound = 30.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationXSlow = Duration(milliseconds: 800);

  // Typography scale
  static const double fontSizeXS = 12.0;
  static const double fontSizeS = 14.0;
  static const double fontSizeM = 16.0;
  static const double fontSizeL = 18.0;
  static const double fontSizeXL = 20.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeTitle = 36.0;
  static const double fontSizeHero = 48.0;
  static const double fontSizeHeroMobile = 32.0;

  // Section dimensions
  static const double heroHeight = 600;
  static const double sectionPaddingVertical = 80.0;
  static const double featureCardPadding = 32.0;

  // Component dimensions
  static const double buttonHeight = 44.0;
  static const double inputHeight = 44.0;
  static const double navBarHeight = 70.0;

  // Navigation heights
  static const double navHeightMobile = 70.0;
  static const double navHeightTablet = 80.0;
  static const double navHeightDesktop = 90.0;

  // Section spacing
  static const double sectionSpacingMobile = 24.0;
  static const double sectionSpacingTablet = 32.0;
  static const double sectionSpacingDesktop = 10.0;

  // Icon sizes
  static const double iconS = 16.0;
  static const double iconM = 20.0;
  static const double iconL = 24.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 48.0;

  // Logo card dimensions (responsive)
  static const double logoHeightMobile = 60;
  static const double logoHeightTablet = 70;
  static const double logoHeightDesktop = 80;

  // Logo element sizes
  static const double logoCircleSizeMobile = 40;
  static const double logoCircleSizeTablet = 45;
  static const double logoCircleSizeDesktop = 50;

  static const double logoOvalWidthMobile = 70;
  static const double logoOvalWidthTablet = 75;
  static const double logoOvalWidthDesktop = 80;

  static const double logoOvalHeightMobile = 30;
  static const double logoOvalHeightTablet = 32;
  static const double logoOvalHeightDesktop = 35;

  // Z-index layers
  static const double zIndexBase = 0;
  static const double zIndexRaised = 1;
  static const double zIndexFloating = 2;
  static const double zIndexModal = 10;
  static const double zIndexToast = 20;
}