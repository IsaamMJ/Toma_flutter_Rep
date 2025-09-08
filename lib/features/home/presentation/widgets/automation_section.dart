import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import 'automation_content.dart';

class AutomationSection extends StatelessWidget {
  const AutomationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          padding: ResponsiveHelper.getHorizontalPadding(context),
          child: isMobile
              ? Column(
            children: [
              const AutomationContent(),
              const SizedBox(height: 48),
              _buildPhoneMockup(context),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 5,
                child: AutomationContent(),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 4,
                child: _buildPhoneMockup(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneMockup(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300, width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Background with subtle pattern
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade50,
                    Colors.white,
                  ],
                ),
              ),
            ),

            // Status bar
            Positioned(
              top: 10,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, size: 16, color: Colors.grey.shade700),
                      const SizedBox(width: 4),
                      Icon(Icons.wifi, size: 16, color: Colors.grey.shade700),
                      const SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 16, color: Colors.grey.shade700),
                    ],
                  ),
                ],
              ),
            ),

            // Chat header
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: 20, color: Colors.grey.shade700),
                    const SizedBox(width: 12),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(Icons.support_agent, size: 16, color: Colors.blue.shade700),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Toma Assistant',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 400.ms),

            // Chat messages
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  // User message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade500,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                          child: Text(
                            'Something came up, can I reschedule my appointment?',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.brown.shade300,
                        child: Icon(Icons.person, size: 16, color: Colors.white),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.3),

                  const SizedBox(height: 16),

                  // Assistant response
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade600,
                        child: Icon(Icons.support_agent, size: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: Text(
                            'No problem, when can you come in?',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.grey.shade800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 1200.ms).slideX(begin: -0.3),
                ],
              ),
            ),

            // Decorative elements
            Positioned(
              bottom: 60,
              right: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ),
            ).animate().fadeIn(delay: 1600.ms).scale(begin: const Offset(0.8, 0.8)),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.3, duration: 800.ms, delay: 400.ms);
  }
}