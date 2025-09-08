import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

class ClientsSection extends StatelessWidget {
  const ClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingXXL),
      color: AppColors.surface,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          padding: ResponsiveHelper.getHorizontalPadding(context),
          child: Column(
            children: [
              // Section Title
              Text(
                'Trusted by Efficient Dealerships',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 48),

              // Logos Grid
              _buildLogosGrid(context),

              const SizedBox(height: 32),

              // "and Hundreds More" text
              Text(
                'and Hundreds More',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogosGrid(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surface.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Your uploaded logo image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/clients.png', // Add your dealership logos image here
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, delay: 600.ms)
              .scale(begin: const Offset(0.9, 0.9)),
        ],
      ),
    );
  }
}