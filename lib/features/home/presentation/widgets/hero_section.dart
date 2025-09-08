import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/nav_bar_item_button.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../demo/presentation/book_a_demo_modal.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    // Reduced mobile hero height - changed multiplier from 0.9 to 0.75 and min height from 650 to 550
    final heroHeight = screenHeight > 600
        ? (isMobile ? screenHeight * 0.75 : screenHeight * 0.9)
        : (isMobile ? 550.0 : 650.0);

    return Container(
      height: heroHeight,
      width: double.infinity,
      color: Colors.grey.shade50,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Container(
            margin: ResponsiveHelper.getHorizontalPadding(context),
            height: heroHeight - (isMobile ? AppConstants.spaceXXL : AppConstants.spaceHuge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
              borderRadius: BorderRadius.circular(isMobile ? AppConstants.radiusM : AppConstants.radiusXXL),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isMobile ? AppConstants.radiusM : AppConstants.radiusXXL),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // Background image
                  Positioned.fill(
                    child: Transform.translate(
                      offset: isMobile ? const Offset(0, -70) : Offset.zero, // Move up by 50 pixels
                      child: Transform.scale(
                        scale: isMobile ? 1.2 : 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/images/hero_bg.jpg'),
                              fit: BoxFit.cover,
                              alignment: isMobile
                                  ? const Alignment(0.8, 0.0) // Reset to center vertically
                                  : const Alignment(0.5, 0.5),
                              opacity: isMobile ? 0.5 : 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Gradient overlay for text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: isMobile
                            ? [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ]
                            : [
                          Colors.white.withOpacity(0.95),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.6, 1.0],
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(isMobile ? AppConstants.spaceL : AppConstants.spaceXXL),
                    child: Row(
                      children: [
                        Expanded(
                          flex: isMobile ? 1 : 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                            children: [
                              // Main heading
                              Text(
                                'The AI Platform for',
                                style: GoogleFonts.crimsonText(
                                  fontSize: isMobile ? AppConstants.fontSizeHeroMobile : AppConstants.fontSizeHero,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade800,
                                  height: 1.1,
                                ),
                                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              )
                                  .animate()
                                  .fadeIn(duration: AppConstants.animationSlow, delay: 200.ms)
                                  .slideX(begin: -0.3, end: 0),

                              // Bold text
                              Text(
                                'Automotive',
                                style: GoogleFonts.crimsonText(
                                  fontSize: isMobile ? AppConstants.fontSizeHeroMobile : AppConstants.fontSizeHero,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  height: 1.1,
                                ),
                                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              )
                                  .animate()
                                  .fadeIn(duration: AppConstants.animationSlow, delay: 400.ms)
                                  .slideX(begin: -0.3, end: 0),

                              SizedBox(height: isMobile ? AppConstants.spaceL : AppConstants.spaceXL),

                              // Subtitle
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: isMobile ? double.infinity : 500,
                                ),
                                child: Text(
                                  'Toma builds personalized AI agents that automate customer communications and operational tasks for automotive dealerships.',
                                  style: GoogleFonts.libreBaskerville(
                                    fontSize: isMobile ? AppConstants.fontSizeM : AppConstants.fontSizeL,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade600,
                                    height: 1.5,
                                  ),
                                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                                )
                                    .animate()
                                    .fadeIn(duration: AppConstants.animationSlow, delay: 600.ms)
                                    .slideX(begin: -0.2, end: 0),
                              ),

                              SizedBox(height: isMobile ? AppConstants.spaceXL : AppConstants.spaceXXL),

                              // CTA Buttons
                              if (isMobile)
                                Column(
                                  children: [
                                    EnhancedPrimaryButton(
                                      label: 'Talk to Toma',
                                      icon: Icons.graphic_eq,
                                      onPressed: () => BookDemoModal.show(context),
                                      isFullWidth: true,
                                    ),
                                    SizedBox(height: AppConstants.spaceM),
                                    OutlinedIconButton(
                                      label: 'Book a Demo',
                                      icon: Icons.arrow_forward,
                                      onPressed: () => BookDemoModal.show(context),
                                      isFullWidth: true,
                                    ),
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    EnhancedPrimaryButton(
                                      label: 'Talk to Toma',
                                      icon: Icons.graphic_eq,
                                      onPressed: () => BookDemoModal.show(context),
                                    )
                                        .animate()
                                        .fadeIn(duration: AppConstants.animationSlow, delay: 1000.ms)
                                        .scale(begin: const Offset(0.8, 0.8)),
                                    SizedBox(width: AppConstants.spaceL),
                                    OutlinedIconButton(
                                      label: 'Book a Demo',
                                      icon: Icons.arrow_forward,
                                      onPressed: () => BookDemoModal.show(context),
                                    )
                                        .animate()
                                        .fadeIn(duration: AppConstants.animationSlow, delay: 1200.ms)
                                        .scale(begin: const Offset(0.8, 0.8)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (!isMobile)
                          const Expanded(
                            flex: 4,
                            child: SizedBox(),
                          ),
                      ],
                    ),
                  ),

                  // Backed by badge - now centered on mobile, right-aligned on desktop
                  Positioned(
                    bottom: isMobile ? AppConstants.spaceL : AppConstants.spaceXL,
                    left: isMobile ? 0 : null,
                    right: isMobile ? 0 : AppConstants.spaceXL,
                    child: isMobile
                        ? Center(
                      child: _buildBackedByBadge()
                          .animate()
                          .fadeIn(duration: AppConstants.animationSlow, delay: 1800.ms),
                    )
                        : _buildBackedByBadge()
                        .animate()
                        .fadeIn(duration: AppConstants.animationSlow, delay: 1800.ms),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackedByBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spaceM,
        vertical: AppConstants.spaceS,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Backed by: ',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
              fontSize: AppConstants.fontSizeXS,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.spaceS - 2,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.orange.shade600,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Y',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(width: AppConstants.spaceXS),
          Text(
            'Y Combinator & alpz',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontSize: AppConstants.fontSizeXS,
            ),
          ),
        ],
      ),
    );
  }
}