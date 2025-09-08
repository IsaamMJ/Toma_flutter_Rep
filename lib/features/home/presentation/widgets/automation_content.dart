import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/nav_bar_item_button.dart';
import '../../../../core/components/use_case_item.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../demo/presentation/book_a_demo_modal.dart';
import '../../data/datasources/automation_data.dart';

class AutomationContent extends StatefulWidget {
  const AutomationContent({super.key});

  @override
  State<AutomationContent> createState() => _AutomationContentState();
}

class _AutomationContentState extends State<AutomationContent> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(isMobile),
        SizedBox(height: AppConstants.spaceXL),
        _buildCTAButton(),
        SizedBox(height: AppConstants.spaceXXL),
        _buildUseCaseLabel(),
        SizedBox(height: AppConstants.spaceL),
        ..._buildUseCases(),
      ],
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Automation That Drives Revenue',
          style: GoogleFonts.crimsonText(
            fontSize: isMobile ? 28.0 : 36.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            height: 1.2,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow).slideY(begin: 0.2),

        SizedBox(height: AppConstants.spaceM),

        Text(
          'Make AI work for you by automating repetitive tasks that your dealership encounters every single day.',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms),
      ],
    );
  }

  Widget _buildCTAButton() {
    return EnhancedPrimaryButton(
      label: 'Talk to Toma',
      icon: Icons.graphic_eq,
      onPressed: () => BookDemoModal.show(context),
      isFullWidth: true,
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 400.ms);
  }

  Widget _buildUseCaseLabel() {
    return Text(
      'USE CASES',
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textMuted,
        fontSize: AppConstants.fontSizeXS,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 600.ms);
  }

  List<Widget> _buildUseCases() {
    return AutomationData.useCases.asMap().entries.map((entry) {
      final index = entry.key;
      final (title, description) = entry.value;
      final isSelected = index == selectedIndex;

      return Padding(
        padding: EdgeInsets.only(bottom: AppConstants.spaceS),
        child: UseCaseItem(
          title: title,
          description: description,
          isSelected: isSelected,
          onTap: () => setState(() => selectedIndex = isSelected ? null : index),
        ),
      ).animate().fadeIn(
        duration: AppConstants.animationMedium,
        delay: (700 + index * 100).ms,
      );
    }).toList();
  }
}