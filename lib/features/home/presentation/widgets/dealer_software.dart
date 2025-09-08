import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/logo_card_component.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/dealer_software_data.dart';

class IntegrationSection extends StatelessWidget {
  const IntegrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      color: Colors.grey.shade50,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                Text(
                  IntegrationData.sectionTitle,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: ResponsiveHelper.isMobile(context)
                        ? AppConstants.fontSizeM
                        : AppConstants.fontSizeL,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: AppConstants.animationSlow),

                SizedBox(height: AppConstants.spaceXXL),

                LogoGrid(
                  logoRows: IntegrationData.getIntegrationLogos(),
                  verticalSpacing: AppConstants.spaceL,
                  horizontalSpacing: AppConstants.spaceM,
                  baseAnimationDelay: 700,
                  rowAnimationOffset: 150,
                  cardAnimationOffset: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}