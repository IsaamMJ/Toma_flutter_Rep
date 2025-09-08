import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/why_tome_data.dart';

class WhyTomaSection extends StatelessWidget {
  const WhyTomaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                Text(
                  WhyTomaData.sectionLabel,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: AppConstants.fontSizeS,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: AppConstants.animationSlow),

                SizedBox(height: AppConstants.spaceM),

                Text(
                  WhyTomaData.mainTitle,
                  style: GoogleFonts.crimsonText(
                    fontSize: isMobile ? AppConstants.fontSizeHeroMobile : AppConstants.fontSizeHero,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.3),

                SizedBox(height: AppConstants.spaceL),

                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    WhyTomaData.subtitle,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontSize: isMobile ? AppConstants.fontSizeM : AppConstants.fontSizeL,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 400.ms),
                ),

                SizedBox(height: AppConstants.spaceXXL + AppConstants.spaceM),

                _buildFeaturesGrid(context, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        children: WhyTomaData.features.asMap().entries.map((entry) {
          return Container(
            margin: EdgeInsets.only(bottom: AppConstants.spaceM),
            child: _buildFeatureCard(entry.value, entry.key),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildFeatureCard(WhyTomaData.features[0], 0)),
            SizedBox(width: AppConstants.spaceM),
            Expanded(child: _buildFeatureCard(WhyTomaData.features[1], 1)),
            SizedBox(width: AppConstants.spaceM),
            Expanded(child: _buildFeatureCard(WhyTomaData.features[2], 2)),
          ],
        ),
        SizedBox(height: AppConstants.spaceM),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildFeatureCard(WhyTomaData.features[3], 3)),
            SizedBox(width: AppConstants.spaceM),
            Expanded(child: _buildFeatureCard(WhyTomaData.features[4], 4)),
            SizedBox(width: AppConstants.spaceM),
            Expanded(child: _buildFeatureCard(WhyTomaData.features[5], 5)),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(WhyTomaFeature feature, int index) {
    return Container(
      padding: EdgeInsets.all(AppConstants.spaceXL),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppConstants.spaceXXL,
            height: AppConstants.spaceXXL,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              feature.icon,
              size: AppConstants.iconL,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: AppConstants.spaceL),

          Text(
            feature.title,
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: AppConstants.fontSizeXL,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.3,
            ),
          ),

          SizedBox(height: AppConstants.spaceS),

          Text(
            feature.description,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: AppConstants.fontSizeM - 1,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: AppConstants.animationSlow,
      delay: (200 + (index * 100)).ms,
    ).slideY(begin: 0.2);
  }
}