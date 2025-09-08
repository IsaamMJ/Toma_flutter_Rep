import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../demo/presentation/book_a_demo_modal.dart';
import '../../data/datasources/automation_cta_data.dart';

class AutomationCTASection extends StatelessWidget {
  const AutomationCTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      color: Colors.grey.shade50,
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

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContentSection(context),
        SizedBox(height: AppConstants.spaceXXL),
        _buildImageSection(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 5, child: _buildContentSection(context)),
        SizedBox(width: AppConstants.spaceHuge),
        Expanded(flex: 6, child: _buildImageSection(context)),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AutomationCTAData.headline,
          style: GoogleFonts.crimsonText(
            color: Colors.black,
            fontSize: isMobile ? AppConstants.fontSizeHeroMobile : AppConstants.fontSizeHero,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow).slideY(begin: 0.2),

        SizedBox(height: AppConstants.spaceL),

        Text(
          AutomationCTAData.description,
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.grey.shade700,
            fontSize: isMobile ? AppConstants.fontSizeM : AppConstants.fontSizeL,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.2),

        SizedBox(height: AppConstants.spaceXXL),

        SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () => BookDemoModal.show(context),

            icon: Icon(
              Icons.mic,
              size: AppConstants.iconL,
              color: Colors.white,
            ),
            label: Text(
              AutomationCTAData.buttonText,
              style: AppTextStyles.button.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceXL),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 400.ms).scale(begin: const Offset(0.9, 0.9)),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      height: isMobile ? 300 : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade100,
                      Colors.white,
                      Colors.grey.shade50,
                    ],
                  ),
                ),
                child: CustomPaint(
                  painter: WavePatternPainter(),
                ),
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                AutomationCTAData.ctaImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(AppConstants.radiusL),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported_outlined,
                            size: AppConstants.iconXXL,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: AppConstants.spaceS),
                          Text(
                            'Image not found',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 300.ms).slideX(begin: 0.1);
  }
}

class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade200.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();

    for (int i = 0; i < 8; i++) {
      final y = (size.height / 8) * i;
      path.moveTo(0, y);

      for (double x = 0; x <= size.width; x += 20) {
        final waveY = y + (10 * (i % 2 == 0 ? 1 : -1)) *
            (0.5 + 0.5 * (x / size.width));
        if (x == 0) {
          path.moveTo(x, waveY);
        } else {
          path.lineTo(x, waveY);
        }
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}