import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/logo_card_component.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/client_data.dart';

class ClientsSection extends StatelessWidget {
  const ClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                _buildSectionHeader(),
                SizedBox(height: AppConstants.spaceXXL),
                _buildLogosGrid(context),
                SizedBox(height: AppConstants.spaceXL),
                _buildBottomContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spaceM,
        vertical: AppConstants.spaceS,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Text(
        'TRUSTED WORLDWIDE',
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: AppConstants.fontSizeXS,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 1.2,
        ),
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow).slideY(begin: 0.3);
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
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppConstants.spaceXXL),
      child: Column(
        children: [
          _buildGridHeader(),
          SizedBox(height: AppConstants.spaceL),
          LogoGrid(
            logoRows: ClientsData.getClientLogos(),
            cardHeight: ResponsiveHelper.getResponsiveValue(
              context: context,
              mobile: AppConstants.logoHeightMobile,
              tablet: AppConstants.logoHeightTablet,
              desktop: AppConstants.logoHeightDesktop,
            ),
            verticalSpacing: AppConstants.spaceL,
            horizontalSpacing: AppConstants.spaceM,
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

  Widget _buildGridHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 1,
          color: AppColors.primary.withOpacity(0.3),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceS),
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
    );
  }

  Widget _buildBottomContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spaceL,
        vertical: AppConstants.spaceS,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: AppConstants.iconS,
            color: AppColors.primary.withOpacity(0.7),
          ),
          SizedBox(width: AppConstants.spaceS),
          Text(
            'and hundreds more growing businesses',
            style: AppTextStyles.bodyMedium.copyWith(
              fontStyle: FontStyle.italic,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveHelper.getResponsiveValue(
                context: context,
                mobile: AppConstants.fontSizeS - 1,
                tablet: AppConstants.fontSizeS,
                desktop: AppConstants.fontSizeM - 1,
              ),
            ),
          ),
        ],
      ),
    ).animate()
        .fadeIn(duration: AppConstants.animationSlow, delay: 1400.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }
}