import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../core/utils/responsive_helper.dart';

class RealCallsSection extends StatefulWidget {
  const RealCallsSection({super.key});

  @override
  State<RealCallsSection> createState() => _RealCallsSectionState();
}

class _RealCallsSectionState extends State<RealCallsSection>
    with TickerProviderStateMixin {
  late AnimationController _scrollController;
  late Animation<double> _scrollAnimation;
  bool _isPaused = false;

  final List<Map<String, dynamic>> callData = [
    {
      'location': 'Phoenix',
      'service': 'Oil Change',
      'timeAgo': '2 hours ago',
      'duration': '2m 42s',
      'status': 'pending',
      'isResolved': false,
    },
    {
      'location': 'Miami',
      'service': 'Brake Inspection',
      'timeAgo': '45 minutes ago',
      'duration': '3m 12s',
      'status': 'resolved',
      'isResolved': true,
    },
    {
      'location': 'Boston',
      'service': 'Tire Rotation',
      'timeAgo': '1 hour ago',
      'duration': '1m 55s',
      'status': 'resolved',
      'isResolved': true,
    },
    {
      'location': 'Seattle',
      'service': 'Engine Diagnostic',
      'timeAgo': '30 minutes ago',
      'duration': '4m 18s',
      'status': 'resolved',
      'isResolved': true,
    },
    {
      'location': 'Denver',
      'service': 'Battery Check',
      'timeAgo': '3 hours ago',
      'duration': '1m 38s',
      'status': 'resolved',
      'isResolved': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      duration: const Duration(seconds: 40), // Slower for better readability
      vsync: this,
    );

    _scrollAnimation = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: _scrollController,
      curve: Curves.linear,
    ));

    // Check for reduced motion preference
    final mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    if (!mediaQuery.disableAnimations) {
      _scrollController.repeat();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _scrollController.stop();
      } else {
        _scrollController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.getResponsiveValue(
          context: context,
          mobile: AppConstants.paddingXXL,
          tablet: AppConstants.paddingXXL + 20,
          desktop: 100,
        ),
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.surfaceGradient,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                // Header Section
                _buildHeader(context, isMobile),

                SizedBox(height: ResponsiveHelper.getResponsiveValue(
                  context: context,
                  mobile: 40,
                  tablet: 50,
                  desktop: 60,
                )),

                // Controls for accessibility
                _buildControls(context),

                const SizedBox(height: 24),

                // Scrolling call notifications
                _buildScrollingCards(context, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Text(
          'Live Customer Calls',
          style: isMobile
              ? AppTextStyles.sectionTitleMobile
              : AppTextStyles.sectionTitle,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),

        SizedBox(height: ResponsiveHelper.getResponsiveValue(
          context: context,
          mobile: 12,
          tablet: 16,
          desktop: 20,
        )),

        Text(
          'See how our AI handles real customer inquiries in real-time,\nautomating responses and improving satisfaction.',
          style: isMobile
              ? AppTextStyles.bodyMedium.copyWith(fontSize: 14)
              : AppTextStyles.bodyLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: _toggleAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isPaused ? Icons.play_arrow : Icons.pause,
                      size: 16,
                      color: AppColors.textSecondary,
                      semanticLabel: _isPaused ? 'Play animation' : 'Pause animation',
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isPaused ? 'Play' : 'Pause',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollingCards(BuildContext context, bool isMobile) {
    return SizedBox(
      height: ResponsiveHelper.getResponsiveValue(
        context: context,
        mobile: 160,
        tablet: 180,
        desktop: 200,
      ),
      child: OverflowBox(
        maxWidth: double.infinity,
        child: AnimatedBuilder(
          animation: _scrollAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                _scrollAnimation.value * MediaQuery.of(context).size.width * 1.5,
                0,
              ),
              child: Row(
                children: [
                  ...callData.map((call) => _buildCallCard(call, context)),
                  ...callData.map((call) => _buildCallCard(call, context)), // Duplicate for seamless loop
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCallCard(Map<String, dynamic> call, BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: isMobile ? 260 : 300, // Adjusted width for better mobile experience
      margin: EdgeInsets.only(right: isMobile ? 16 : 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header with location and status
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: call['isResolved']
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.statusPending.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone,
                  color: call['isResolved']
                      ? AppColors.success
                      : AppColors.statusPending,
                  size: 18,
                  semanticLabel: 'Customer call',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call['location'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      call['timeAgo'],
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(call),
            ],
          ),

          const SizedBox(height: 16),

          // Service name - Primary focus
          Text(
            call['service'],
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: 18,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Duration metadata
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: AppColors.textMuted,
                semanticLabel: 'Call duration',
              ),
              const SizedBox(width: 6),
              Text(
                'Duration: ${call['duration']}',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(Map<String, dynamic> call) {
    final isResolved = call['isResolved'] as bool;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isResolved
            ? AppColors.success.withOpacity(0.1)
            : AppColors.statusPending.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isResolved ? Icons.check_circle : Icons.schedule,
            size: 12,
            color: isResolved ? AppColors.success : AppColors.statusPending,
            semanticLabel: isResolved ? 'Resolved' : 'Pending',
          ),
          const SizedBox(width: 4),
          Text(
            isResolved ? 'Resolved' : 'In Progress',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isResolved ? AppColors.success : AppColors.statusPending,
            ),
          ),
        ],
      ),
    );
  }
}