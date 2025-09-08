import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/nav_bar_item_button.dart';
import '../../../../core/components/use_case_item.dart';
import '../../../../core/utils/responsive_helper.dart';

class AutomationContent extends StatefulWidget {
  const AutomationContent({super.key});

  @override
  State<AutomationContent> createState() => _AutomationContentState();
}

class _AutomationContentState extends State<AutomationContent> {
  int? selectedIndex;

  static const useCases = [
    ('Full-Store Receptionist', 'Handle all customer inquiries, answer common questions about services, pricing, and policies while directing complex issues to human staff when needed.'),
    ('Schedule Appointments 24/7', 'Book new service appointments and help customers reschedule or confirm existing ones—without human intervention.'),
    ('Generate Recall Service Revenue', 'Automatically reach out to customers about recalls, warranty work, and maintenance reminders to drive additional service revenue.'),
    ('Streamline Parts Requests', 'Process parts inquiries, check inventory availability, and coordinate with suppliers to ensure faster turnaround times.'),
    ('Reduce No-Shows', 'Send automated appointment reminders, confirmations, and follow-ups to significantly reduce missed appointments and improve scheduling efficiency.'),
    ('Build-Your-Own-Workflow', 'Create custom automation workflows tailored to your dealership\'s specific needs and processes with our intuitive workflow builder.'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(isMobile),
        const SizedBox(height: 32),
        _buildCTAButton(),
        const SizedBox(height: 48),
        _buildUseCaseLabel(),
        const SizedBox(height: 20),
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
          style: isMobile ? AppTextStyles.sectionTitleMobile : AppTextStyles.sectionTitle,
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'Make AI work for you by automating repetitive tasks that your dealership encounters every single day.',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildCTAButton() {
    return PrimaryButton(
      label: 'Talk to Toma',
      icon: Icons.graphic_eq,
      onPressed: () {},
      isFullWidth: true,
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms);
  }

  Widget _buildUseCaseLabel() {
    return Text(
      'USE CASES',
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textMuted,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms);
  }

  List<Widget> _buildUseCases() {
    return useCases.asMap().entries.map((entry) {
      final (index, (title, description)) = (entry.key, entry.value);
      final isSelected = index == selectedIndex;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: UseCaseItem(
          title: title,
          description: description,
          isSelected: isSelected,
          onTap: () => setState(() => selectedIndex = isSelected ? null : index),
        ),
      ).animate().fadeIn(
        duration: 500.ms,
        delay: (700 + index * 100).ms,
      );
    }).toList();
  }
}