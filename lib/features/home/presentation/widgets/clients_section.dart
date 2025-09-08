import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/logo_card_component.dart';
import '../../../../core/utils/responsive_helper.dart';

class ClientsSection extends StatelessWidget {
  const ClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.getResponsiveValue(
          context: context,
          mobile: 40.0,
          tablet: 50.0,
          desktop: 60.0,
        ),
      ),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                // Enhanced Section Header
                _buildSectionHeader(context),

                SizedBox(
                  height: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: 32.0,
                    tablet: 40.0,
                    desktop: 48.0,
                  ),
                ),

                // Logos Grid with enhanced styling
                _buildLogosGrid(context),

                SizedBox(
                  height: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: 24.0,
                    tablet: 28.0,
                    desktop: 32.0,
                  ),
                ),

                // Enhanced bottom content
                _buildBottomContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        // Pre-header text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            'TRUSTED WORLDWIDE',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 1.2,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildLogosGrid(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background.withOpacity(0.8),
            AppColors.surface.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(
        ResponsiveHelper.getResponsiveValue(
          context: context,
          mobile: 24.0,
          tablet: 32.0,
          desktop: 40.0,
        ),
      ),
      child: Column(
        children: [
          // Optional: Add a small header inside the grid
          Container(
            padding: EdgeInsets.only(
              bottom: ResponsiveHelper.getResponsiveValue(
                context: context,
                mobile: 20.0,
                tablet: 24.0,
                desktop: 28.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 1,
                  color: AppColors.primary.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'FEATURED PARTNERS',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 1,
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ],
            ),
          ),

          LogoGrid(
            logoRows: _getClientLogosData(),
            cardHeight: ResponsiveHelper.getResponsiveValue(
              context: context,
              mobile: 60.0,
              tablet: 70.0,
              desktop: 80.0,
            ),
            verticalSpacing: ResponsiveHelper.getResponsiveValue(
              context: context,
              mobile: 16.0,
              tablet: 20.0,
              desktop: 24.0,
            ),
            horizontalSpacing: ResponsiveHelper.getResponsiveValue(
              context: context,
              mobile: 12.0,
              tablet: 16.0,
              desktop: 20.0,
            ),
            baseAnimationDelay: 600,
            rowAnimationOffset: 150,
            cardAnimationOffset: 80,
            cardBackgroundColor: Colors.white.withOpacity(0.6),
            cardBorderColor: AppColors.primary.withOpacity(0.08),
            cardBoxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context) {
    return Column(
      children: [
        // Enhanced "and hundreds more" text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 16,
                color: AppColors.primary.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                'and hundreds more growing businesses',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: 13.0,
                    tablet: 14.0,
                    desktop: 15.0,
                  ),
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 800.ms, delay: 1400.ms)
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
      ],
    );
  }

  // Client logos data - using local asset images
  List<List<Map<String, dynamic>>> _getClientLogosData() {
    return [
      // Row 1
      [
        {
          'name': 'Pohanka Automotive Group',
          'imagePath': 'assets/images/clients/pohanka.png',
          'imageWidth': 140.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Hudson Automotive Group',
          'imagePath': 'assets/images/clients/hudson.png',
          'imageWidth': 120.0,
          'imageHeight': 40.0,
        },
        {
          'name': 'LearGUY',
          'imagePath': 'assets/images/clients/learguy.png',
          'imageWidth': 100.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Schomp',
          'imagePath': 'assets/images/clients/schomp.png',
          'imageWidth': 120.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Martin Management Group',
          'imagePath': 'assets/images/clients/martin.png',
          'imageWidth': 130.0,
          'imageHeight': 40.0,
        },
        {
          'name': 'Harvey Auto Group',
          'imagePath': 'assets/images/clients/harvey.png',
          'imageWidth': 120.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Seth Wadley',
          'imagePath': 'assets/images/clients/sethwadley.png',
          'imageWidth': 110.0,
          'imageHeight': 40.0,
        },
      ],
      // Row 2
      [
        {
          'name': 'Elko Auto Group',
          'imagePath': 'assets/images/clients/elko.png',
          'imageWidth': 100.0,
          'imageHeight': 40.0,
        },
        {
          'name': 'Muller',
          'imagePath': 'assets/images/clients/muller.png',
          'imageWidth': 120.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'York Automotive Group',
          'imagePath': 'assets/images/clients/york.png',
          'imageWidth': 110.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Bergeys',
          'imagePath': 'assets/images/clients/bergeys.png',
          'imageWidth': 120.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Mirak',
          'imagePath': 'assets/images/clients/mirak.png',
          'imageWidth': 100.0,
          'imageHeight': 40.0,
        },
        {
          'name': 'Rickenbaugh',
          'imagePath': 'assets/images/clients/rickenbaugh.png',
          'imageWidth': 130.0,
          'imageHeight': 35.0,
        },
        {
          'name': 'Preston',
          'imagePath': 'assets/images/clients/preston.png',
          'imageWidth': 100.0,
          'imageHeight': 35.0,
        },
      ],
    ];
  }
}