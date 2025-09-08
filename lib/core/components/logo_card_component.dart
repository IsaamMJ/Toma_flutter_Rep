import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/utils/responsive_helper.dart';

// Generic logo card widget for any type of logo/brand display
class LogoCard extends StatelessWidget {
  final Map<String, dynamic> logoData;
  final int animationDelay;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;

  const LogoCard({
    super.key,
    required this.logoData,
    this.animationDelay = 0,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    // Use responsive height if not provided
    final cardHeight = height ?? ResponsiveHelper.getLogoCardHeight(context);

    return Container(
      width: width,
      height: cardHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: _buildLogoContent(context),
      ),
    ).animate().fadeIn(
      duration: 500.ms,
      delay: animationDelay.ms,
    ).slideY(begin: 0.2);
  }

  Widget _buildLogoContent(BuildContext context) {
    // Check if this is an image-based logo
    final imagePath = logoData['imagePath'] as String?;
    if (imagePath != null) {
      return _buildImageLogo(context);
    }

    // Handle text-based logos
    return _buildTextLogo(context);
  }

  Widget _buildImageLogo(BuildContext context) {
    final imagePath = logoData['imagePath'] as String;
    final name = logoData['name'] as String;
    final imageWidth = logoData['imageWidth'] as double? ?? 100.0;
    final imageHeight = logoData['imageHeight'] as double? ?? 40.0;

    // Scale image size based on screen size
    final scaleFactor = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 0.8,
      tablet: 0.9,
      desktop: 1.0,
    );

    return Image.asset(
      imagePath,
      width: imageWidth * scaleFactor,
      height: imageHeight * scaleFactor,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to text if image fails to load
        return Text(
          name,
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveValue(
              context: context,
              mobile: 10,
              tablet: 11,
              desktop: 12,
            ),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Widget _buildTextLogo(BuildContext context) {
    final name = logoData['name'] as String;
    final color = logoData['color'] as Color?;
    final subtitle = logoData['subtitle'] as String?;
    final isCircle = logoData['isCircle'] as bool? ?? false;
    final hasArrow = logoData['hasArrow'] as bool? ?? false;
    final hasIcon = logoData['hasIcon'] as bool? ?? false;
    final hasSymbol = logoData['hasSymbol'] as bool? ?? false;
    final isOval = logoData['isOval'] as bool? ?? false;
    final fontSize = logoData['fontSize'] as double?;

    // Provide default color if none specified
    final logoColor = color ?? Colors.black87;

    // Get responsive font sizes
    final responsiveFontSize = fontSize ?? ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 12,
      tablet: 13,
      desktop: 14,
    );

    if (isCircle) return _buildCircleLogo(context, name, logoColor, responsiveFontSize);
    if (isOval) return _buildOvalLogo(context, name, logoColor, responsiveFontSize);
    return _buildDefaultLogo(context, name, logoColor, subtitle, hasArrow, hasSymbol, hasIcon, responsiveFontSize);
  }

  Widget _buildCircleLogo(BuildContext context, String name, Color logoColor, double fontSize) {
    final circleSize = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 40,
      tablet: 45,
      desktop: 50,
    );

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: logoColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOvalLogo(BuildContext context, String name, Color logoColor, double fontSize) {
    final ovalWidth = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 70,
      tablet: 75,
      desktop: 80,
    );
    final ovalHeight = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 30,
      tablet: 32,
      desktop: 35,
    );

    return Container(
      width: ovalWidth,
      height: ovalHeight,
      decoration: BoxDecoration(
        color: logoColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultLogo(BuildContext context, String name, Color logoColor, String? subtitle,
      bool hasArrow, bool hasSymbol, bool hasIcon, double fontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Arrow icon (for DEALER-FX style)
            if (hasArrow) ...[
              Container(
                width: ResponsiveHelper.getResponsiveValue(
                  context: context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                ),
                height: ResponsiveHelper.getResponsiveValue(
                  context: context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                ),
                decoration: BoxDecoration(
                  color: logoColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: 12,
                    tablet: 13,
                    desktop: 14,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            // Symbol (for xtime infinity symbol)
            if (hasSymbol) ...[
              Text(
                '∞',
                style: TextStyle(
                  color: logoColor,
                  fontSize: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: 20,
                    tablet: 22,
                    desktop: 24,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            // Main text
            Flexible(
              child: Text(
                name,
                style: TextStyle(
                  color: logoColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            // Dot icon (for myHoorma style)
            if (hasIcon && logoData['iconType'] == 'dot') ...[
              const SizedBox(width: 4),
              Container(
                width: ResponsiveHelper.getResponsiveValue(
                  context: context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                ),
                height: ResponsiveHelper.getResponsiveValue(
                  context: context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                ),
                decoration: BoxDecoration(
                  color: logoColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
            // Security icon (for DEALER VAULT style)
            if (hasIcon && logoData['iconType'] == 'security') ...[
              const SizedBox(width: 8),
              Icon(
                Icons.security,
                color: logoColor,
                size: ResponsiveHelper.getResponsiveValue(
                  context: context,
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
              ),
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: logoColor,
              fontSize: ResponsiveHelper.getResponsiveValue(
                context: context,
                mobile: 7,     // Reduced from 8
                tablet: 8,     // Reduced from 9
                desktop: 10,   // Keep same
              ),
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

// Generic grid layout for logo cards
class LogoGrid extends StatelessWidget {
  final List<List<Map<String, dynamic>>> logoRows;
  final double? cardHeight;
  final double verticalSpacing;
  final double horizontalSpacing;
  final bool enableAnimation;
  final int baseAnimationDelay;
  final int rowAnimationOffset;
  final int cardAnimationOffset;
  final BorderRadius? cardBorderRadius;
  final Color? cardBackgroundColor;
  final Color? cardBorderColor;
  final List<BoxShadow>? cardBoxShadow;

  const LogoGrid({
    super.key,
    required this.logoRows,
    this.cardHeight,
    this.verticalSpacing = 32,
    this.horizontalSpacing = 12,
    this.enableAnimation = true,
    this.baseAnimationDelay = 300,
    this.rowAnimationOffset = 200,
    this.cardAnimationOffset = 100,
    this.cardBorderRadius,
    this.cardBackgroundColor,
    this.cardBorderColor,
    this.cardBoxShadow,
  });

  @override
  Widget build(BuildContext context) {
    // Get responsive vertical spacing - reduce for mobile
    final responsiveVerticalSpacing = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 16,    // Reduced from 32
      tablet: 24,    // Reduced from 32
      desktop: verticalSpacing, // Keep original for desktop
    );

    return Column(
      children: logoRows.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final row = rowEntry.value;

        return Container(
          margin: EdgeInsets.only(
            bottom: rowIndex < logoRows.length - 1 ? responsiveVerticalSpacing : 0,
          ),
          child: ResponsiveHelper.isMobile(context)
              ? _buildMobileRow(context, row, rowIndex)
              : ResponsiveHelper.isTablet(context)
              ? _buildTabletRow(context, row, rowIndex)
              : _buildDesktopRow(context, row, rowIndex),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopRow(BuildContext context, List<Map<String, dynamic>> logos, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: logos.asMap().entries.map((entry) {
        final index = entry.key;
        final logo = entry.value;

        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: horizontalSpacing),
            child: LogoCard(
              logoData: logo,
              height: cardHeight,
              animationDelay: enableAnimation
                  ? baseAnimationDelay + (rowIndex * rowAnimationOffset) + (index * cardAnimationOffset)
                  : 0,
              borderRadius: cardBorderRadius,
              backgroundColor: cardBackgroundColor,
              borderColor: cardBorderColor,
              boxShadow: cardBoxShadow,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTabletRow(BuildContext context, List<Map<String, dynamic>> logos, int rowIndex) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: logos.asMap().entries.map((entry) {
        final index = entry.key;
        final logo = entry.value;

        return LogoCard(
          logoData: logo,
          width: ResponsiveHelper.getLogoCardWidth(context),
          height: cardHeight,
          animationDelay: enableAnimation
              ? baseAnimationDelay + (rowIndex * rowAnimationOffset) + (index * cardAnimationOffset)
              : 0,
          borderRadius: cardBorderRadius,
          backgroundColor: cardBackgroundColor,
          borderColor: cardBorderColor,
          boxShadow: cardBoxShadow,
        );
      }).toList(),
    );
  }

  Widget _buildMobileRow(BuildContext context, List<Map<String, dynamic>> logos, int rowIndex) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: logos.asMap().entries.map((entry) {
        final index = entry.key;
        final logo = entry.value;

        return LogoCard(
          logoData: logo,
          width: ResponsiveHelper.getLogoCardWidth(context),
          height: cardHeight,
          animationDelay: enableAnimation
              ? baseAnimationDelay + (rowIndex * rowAnimationOffset) + (index * cardAnimationOffset)
              : 0,
          borderRadius: cardBorderRadius,
          backgroundColor: cardBackgroundColor,
          borderColor: cardBorderColor,
          boxShadow: cardBoxShadow,
        );
      }).toList(),
    );
  }
}