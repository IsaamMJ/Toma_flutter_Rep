import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewWorkPressed;

  const HeroSection({
    super.key,
    this.onViewWorkPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight > 600 ? screenHeight * 0.85 : 600.0;

    return Container(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),

          // Content
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveHelper.getMaxWidth(context),
              ),
              padding: ResponsiveHelper.getHorizontalPadding(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main heading with animation
                  Text(
                    'We Create',
                    style: isMobile
                        ? AppTextStyles.heroTitleMobile
                        : AppTextStyles.heroTitle,
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 200.ms)
                      .slideY(begin: 0.3, end: 0),

                  // Gradient text
                  ShaderMask(
                    shaderCallback: (bounds) => AppColors.primaryGradient
                        .createShader(bounds),
                    child: Text(
                      'Digital Excellence',
                      style: (isMobile
                          ? AppTextStyles.heroTitleMobile
                          : AppTextStyles.heroTitle)
                          .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 600.ms)
                      .slideY(begin: 0.3, end: 0),

                  SizedBox(height: isMobile ? 24 : 32),

                  // Subtitle
                  Text(
                    'Transforming ideas into powerful digital experiences\nthat drive results and inspire users',
                    style: AppTextStyles.heroSubtitle.copyWith(
                      fontSize: isMobile ? 18 : 20,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 1000.ms)
                      .slideY(begin: 0.2, end: 0),

                  SizedBox(height: isMobile ? 32 : 48),

                  // CTA Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPrimaryButton(
                        'View Our Work',
                        widget.onViewWorkPressed,
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1400.ms)
                          .scale(begin: const Offset(0.8, 0.8)),

                      if (!isMobile) ...[
                        const SizedBox(width: 24),
                        _buildSecondaryButton(
                          'Get In Touch',
                              () {},
                        )
                            .animate()
                            .fadeIn(duration: 800.ms, delay: 1600.ms)
                            .scale(begin: const Offset(0.8, 0.8)),
                      ],
                    ],
                  ),

                  SizedBox(height: isMobile ? 48 : 64),

                  // Scroll indicator
                  _buildScrollIndicator()
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 800.ms, delay: 2000.ms)
                      .moveY(
                    begin: -10,
                    end: 10,
                    duration: 2000.ms,
                    curve: Curves.easeInOut,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.primary.withOpacity(0.8),
            AppColors.background,
          ],
        ),
      ),
      child: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: BackgroundPainter(_backgroundController.value),
          );
        },
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: AppTextStyles.button,
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback? onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.textSecondary),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.button.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Text(
          'Scroll to explore',
          style: AppTextStyles.bodySmall,
        ),
        const SizedBox(height: 8),
        Container(
          width: 2,
          height: 32,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.textSecondary.withOpacity(0.3),
                AppColors.textSecondary,
              ],
            ),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.accent.withOpacity(0.1),
          AppColors.accent.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Animated circles
    for (int i = 0; i < 3; i++) {
      final offset = Offset(
        size.width * (0.2 + i * 0.3),
        size.height * (0.3 + (animationValue + i * 0.3) % 1 * 0.4),
      );

      canvas.drawCircle(
        offset,
        50 + i * 30,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}