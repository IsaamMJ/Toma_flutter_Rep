import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

class AutomationContent extends StatefulWidget {
  const AutomationContent({super.key});

  @override
  State<AutomationContent> createState() => _AutomationContentState();
}

class _AutomationContentState extends State<AutomationContent> {
  int selectedIndex = 1; // Schedule Appointments is highlighted

  final List<Map<String, String>> useCases = [
    {'title': 'Full-Store Receptionist', 'description': ''},
    {
      'title': 'Schedule Appointments 24/7',
      'description': 'Book new service appointments and help customers reschedule or confirm existing ones—without human intervention.'
    },
    {'title': 'Generate Recall Service Revenue', 'description': ''},
    {'title': 'Streamline Parts Requests', 'description': ''},
    {'title': 'Reduce No-Shows', 'description': ''},
    {'title': 'Build-Your-Own-Workflow', 'description': ''},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Automation That Drives Revenue',
          style: isMobile
              ? AppTextStyles.sectionTitleMobile
              : AppTextStyles.sectionTitle,
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

        const SizedBox(height: 16),

        // Description
        Text(
          'Make AI work for you by automating repetitive tasks that your dealership encounters every single day.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

        const SizedBox(height: 32),

        // Buttons
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text('Talk to Toma'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

            const SizedBox(width: 16),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(color: AppColors.buttonOutline),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Get Started'),
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
          ],
        ),

        const SizedBox(height: 48),

        // Use Cases Label
        Text(
          'Use Cases',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

        const SizedBox(height: 24),

        // Use Cases List
        ...useCases.asMap().entries.map((entry) {
          final index = entry.key;
          final useCase = entry.value;
          final isSelected = index == selectedIndex;

          return _buildUseCaseItem(
            useCase['title']!,
            useCase['description']!,
            isSelected,
            index,
          ).animate().fadeIn(
              duration: 500.ms,
              delay: (700 + index * 100).ms
          );
        }).toList(),
      ],
    );
  }

  Widget _buildUseCaseItem(String title, String description, bool isSelected, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: () => setState(() => selectedIndex = index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface.withOpacity(0.5) : null,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: AppColors.buttonOutline.withOpacity(0.3))
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              if (description.isNotEmpty && isSelected) ...[
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}