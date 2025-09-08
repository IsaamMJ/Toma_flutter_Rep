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
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const AutomationContent(),
        const SizedBox(height: 48),
        _WorkflowVisualization(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 5, child: AutomationContent()),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _WorkflowVisualization()),
      ],
    );
  }
}

class _WorkflowVisualization extends StatelessWidget {
  static const _steps = [
    ('Customer Inquiry', Icons.person, 'Recall notice appointment?', 0),
    ('AI Processing', Icons.psychology, 'Analyzing request...', 800),
    ('Auto-Resolution', Icons.check_circle, 'Appointment rescheduled!', 1600),
  ];

  static const _metrics = [
    ('Response Time', '< 2 sec', Icons.timer),
    ('Success Rate', '94%', Icons.trending_up),
    ('Available', '24/7', Icons.access_time),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  ..._buildWorkflowSteps(),
                  const Spacer(),
                  _buildMetrics(),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 0.3, duration: 800.ms, delay: 400.ms);
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPulsingDot(),
              const SizedBox(width: 6),
              Text(
                'Live Demo',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          '347 Calls Handled Today',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildPulsingDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
    ).animate(onPlay: (controller) => controller.repeat())
        .scale(begin: const Offset(1, 1), end: const Offset(1.3, 1.3), duration: 1000.ms)
        .then()
        .scale(begin: const Offset(1.3, 1.3), end: const Offset(1, 1), duration: 1000.ms);
  }

  List<Widget> _buildWorkflowSteps() {
    final steps = <Widget>[];
    for (int i = 0; i < _steps.length; i++) {
      final (title, icon, description, delay) = _steps[i];
      steps.add(_buildWorkflowStep(title, icon, description, delay));
      if (i < _steps.length - 1) steps.add(_buildFlowLine());
    }
    return steps;
  }

  Widget _buildWorkflowStep(String title, IconData icon, String description, int delay) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buttonOutline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.buttonPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.buttonPrimary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.3);
  }

  Widget _buildFlowLine() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 2,
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.buttonPrimary.withOpacity(0.5),
                  AppColors.buttonPrimary,
                ],
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 2000.ms, color: AppColors.buttonPrimary.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _buildMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _metrics
          .map((metric) => _buildMetric(metric.$1, metric.$2, metric.$3))
          .toList(),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.buttonPrimary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontSize: 11,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 2000.ms).scale(begin: const Offset(0.8, 0.8));
  }
}