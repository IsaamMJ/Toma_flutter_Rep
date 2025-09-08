import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../demo/presentation/book_a_demo_modal.dart';
import '../../data/datasources/meet_employee_data.dart';

class MeetEmployeeSection extends StatelessWidget {
  const MeetEmployeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: ResponsiveHelper.isMobile(context)
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildContentSection(context)),
        SizedBox(width: AppConstants.spaceXXL),
        Expanded(child: _buildImageSection()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildImageSection(),
        SizedBox(height: AppConstants.spaceXXL),
        _buildContentSection(context),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start, // Add this condition
      children: [
        Text(
          MeetEmployeeData.mainTitle,
          style: GoogleFonts.crimsonText(
            fontSize: isMobile ? AppConstants.fontSizeHeroMobile : AppConstants.fontSizeHero,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start, // Add this for text centering
        ).animate().fadeIn(duration: AppConstants.animationSlow).slideX(begin: -0.3),

        SizedBox(height: AppConstants.spaceL),

        Text(
          MeetEmployeeData.description,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeM : AppConstants.fontSizeL,
            color: Colors.grey.shade600,
            height: 1.6,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start, // Add this for text centering
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideX(begin: -0.3),

        SizedBox(height: AppConstants.spaceXXL),
        _buildBenefitsList(),
        SizedBox(height: AppConstants.spaceXXL),
        _buildTalkToTomaButton(context),
      ],
    );
  }

  Widget _buildBenefitsList() {
    return Column(
      children: MeetEmployeeData.benefits.asMap().entries.map((entry) {
        return Container(
          margin: EdgeInsets.only(bottom: AppConstants.spaceM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppConstants.iconL,
                height: AppConstants.iconL,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: AppConstants.fontSizeS,
                ),
              ),
              SizedBox(width: AppConstants.spaceM),
              Expanded(
                child: Text(
                  entry.value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: AppConstants.fontSizeM,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(
          duration: AppConstants.animationSlow,
          delay: (400 + (entry.key * 150)).ms,
        ).slideX(begin: -0.2);
      }).toList(),
    );
  }

  Widget _buildTalkToTomaButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusRound),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => BookDemoModal.show(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spaceXL,
            vertical: AppConstants.spaceL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusRound),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              MeetEmployeeData.buttonText,
              style: AppTextStyles.button.copyWith(
                fontSize: AppConstants.fontSizeM,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: AppConstants.spaceS),
            Container(
              width: AppConstants.iconL,
              height: AppConstants.iconL,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 2,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 800.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
        child: Image.asset(
          MeetEmployeeData.employeeImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: AppConstants.iconXXL + AppConstants.spaceXL,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: AppConstants.spaceM),
                    Text(
                      'AI Employee',
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: AppConstants.fontSizeL,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: 1000.ms, delay: 200.ms).scale(begin: const Offset(0.9, 0.9));
  }
}