import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/real_calls_data.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    );

    _scrollAnimation = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: _scrollController,
      curve: Curves.linear,
    ));

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
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      decoration: const BoxDecoration(
        gradient: AppColors.surfaceGradient,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                _buildHeader(context, isMobile),
                SizedBox(height: AppConstants.spaceXXL),
                _buildControls(context),
                SizedBox(height: AppConstants.spaceL),
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
          RealCallsData.sectionTitle,
          style: GoogleFonts.crimsonText(
            fontSize: isMobile ? AppConstants.fontSizeHeroMobile : AppConstants.fontSizeTitle,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: AppConstants.animationSlow).slideY(begin: 0.3),

        SizedBox(height: AppConstants.spaceL),

        Text(
          RealCallsData.sectionDescription,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeS : AppConstants.fontSizeL,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.3),
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
            borderRadius: BorderRadius.circular(AppConstants.radiusXL),
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
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              onTap: _toggleAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.spaceM,
                  vertical: AppConstants.spaceS,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isPaused ? Icons.play_arrow : Icons.pause,
                      size: AppConstants.iconS,
                      color: AppColors.textSecondary,
                      semanticLabel: _isPaused ? 'Play animation' : 'Pause animation',
                    ),
                    SizedBox(width: AppConstants.spaceS),
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
        mobile: 160.0,
        tablet: 180.0,
        desktop: 200.0,
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
                  ...RealCallsData.callData.map((call) => _buildCallCard(call, context)),
                  ...RealCallsData.callData.map((call) => _buildCallCard(call, context)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCallCard(RealCallItem call, BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: isMobile ? 260 : 300,
      margin: EdgeInsets.only(right: isMobile ? AppConstants.spaceM : AppConstants.spaceL),
      padding: EdgeInsets.all(AppConstants.spaceL),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
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
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: call.isResolved
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.statusPending.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone,
                  color: call.isResolved
                      ? AppColors.success
                      : AppColors.statusPending,
                  size: AppConstants.iconM,
                  semanticLabel: 'Customer call',
                ),
              ),
              SizedBox(width: AppConstants.spaceS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call.location,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppConstants.fontSizeM,
                      ),
                    ),
                    Text(
                      call.timeAgo,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: AppConstants.fontSizeXS,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(call),
            ],
          ),

          SizedBox(height: AppConstants.spaceM),

          Text(
            call.service,
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: AppConstants.fontSizeL,
              height: 1.2,
            ),
          ),

          SizedBox(height: AppConstants.spaceM),

          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: AppColors.textMuted,
                semanticLabel: 'Call duration',
              ),
              SizedBox(width: AppConstants.spaceXS),
              Text(
                'Duration: ${call.duration}',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: AppConstants.fontSizeXS,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(RealCallItem call) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spaceS,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        color: call.isResolved
            ? AppColors.success.withOpacity(0.1)
            : AppColors.statusPending.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.spaceS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            call.isResolved ? Icons.check_circle : Icons.schedule,
            size: AppConstants.fontSizeXS,
            color: call.isResolved ? AppColors.success : AppColors.statusPending,
            semanticLabel: call.isResolved ? 'Resolved' : 'Pending',
          ),
          SizedBox(width: AppConstants.spaceXS),
          Text(
            call.isResolved ? 'Resolved' : 'In Progress',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: call.isResolved ? AppColors.success : AppColors.statusPending,
            ),
          ),
        ],
      ),
    );
  }
}