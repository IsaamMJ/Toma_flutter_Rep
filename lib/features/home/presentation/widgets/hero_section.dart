import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/nav_bar_item_button.dart';
import '../../../../core/utils/responsive_helper.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewWorkPressed;
  final VoidCallback? onBookDemoPressed;

  const HeroSection({
    super.key,
    this.onViewWorkPressed,
    this.onBookDemoPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _carController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _carController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight > 600 ? screenHeight * 0.9 : 650.0;

    return Container(
      height: heroHeight,
      width: double.infinity,
      color: Colors.grey.shade50, // Outer background
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200), // Same as navbar
          child: Container(
            margin: ResponsiveHelper.getHorizontalPadding(context), // Professional spacing
            height: heroHeight - (isMobile ? 40 : 80), // Inner container with margin
            decoration: BoxDecoration(
              // Fallback gradient (always visible)
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
              borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
              child: Stack(
                clipBehavior: Clip.hardEdge, // Ensure proper clipping
                children: [
                  // Background image with different positioning for mobile/desktop
                  Positioned.fill(
                    child: Transform.scale(
                      scale: isMobile ? 1.2 : 1.0, // 1.2 = 120% size (zoom in)
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/images/hero_bg.jpg'),
                            fit: BoxFit.cover,
                            alignment: isMobile
                                ? const Alignment(0.8, -0.5) // Right portion, more up
                                : const Alignment(0.5, 0.5), // Center on desktop
                            opacity: isMobile ? 0.5 : 1.0,
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
                          // Mobile: Less aggressive gradient since image is already at 50% opacity
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ]
                            : [
                          // Desktop: Stronger gradient for better text readability
                          Colors.white.withOpacity(0.95),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.6, 1.0],
                      ),
                    ),
                  ),

                  // Content with proper padding inside container
                  Padding(
                    padding: EdgeInsets.all(isMobile ? 24.0 : 48.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: isMobile ? 1 : 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Main heading
                              Text(
                                'The AI Platform for',
                                style: GoogleFonts.crimsonText(
                                  fontSize: isMobile ? 32 : 48,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade800,
                                  height: 1.1,
                                ),
                                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              )
                                  .animate()
                                  .fadeIn(duration: 800.ms, delay: 200.ms)
                                  .slideX(begin: -0.3, end: 0),

                              // Bold text
                              Text(
                                'Automotive',
                                style: GoogleFonts.crimsonText(
                                  fontSize: isMobile ? 32 : 48,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  height: 1.1,
                                ),
                                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                              )
                                  .animate()
                                  .fadeIn(duration: 800.ms, delay: 400.ms)
                                  .slideX(begin: -0.3, end: 0),

                              SizedBox(height: isMobile ? 20 : 32),

                              // Subtitle
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: isMobile ? double.infinity : 500,
                                ),
                                child: Text(
                                  'Toma builds personalized AI agents that automate customer communications and operational tasks for automotive dealerships.',
                                  style: GoogleFonts.libreBaskerville(
                                    fontSize: isMobile ? 16 : 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade600,
                                    height: 1.5,
                                  ),
                                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                                )
                                    .animate()
                                    .fadeIn(duration: 800.ms, delay: 600.ms)
                                    .slideX(begin: -0.2, end: 0),
                              ),

                              SizedBox(height: isMobile ? 32 : 48),

                              // CTA Buttons
                              if (isMobile)
                                Column(
                                  children: [
                                    PrimaryButton(
                                      label: 'Talk to Toma',
                                      icon: Icons.graphic_eq, // Sound wave icon like in your image
                                      onPressed: widget.onViewWorkPressed,
                                      isFullWidth: true,
                                    ),
                                    const SizedBox(height: 16),
                                    OutlinedIconButton(
                                      label: 'Book a Demo',
                                      icon: Icons.arrow_forward,
                                      onPressed: widget.onBookDemoPressed,
                                      isFullWidth: true,
                                    ),
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    PrimaryButton(
                                      label: 'Talk to Toma',
                                      icon: Icons.graphic_eq, // Sound wave icon like in your image
                                      onPressed: widget.onViewWorkPressed,
                                    )
                                        .animate()
                                        .fadeIn(duration: 800.ms, delay: 1000.ms)
                                        .scale(begin: const Offset(0.8, 0.8)),
                                    const SizedBox(width: 20),
                                    OutlinedIconButton(
                                      label: 'Book a Demo',
                                      icon: Icons.arrow_forward,
                                      onPressed: widget.onBookDemoPressed,
                                    )
                                        .animate()
                                        .fadeIn(duration: 800.ms, delay: 1200.ms)
                                        .scale(begin: const Offset(0.8, 0.8)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (!isMobile)
                          Expanded(
                            flex: 4,
                            child: Container(), // Space for background image content
                          ),
                      ],
                    ),
                  ),

                  // Backed by badge (bottom right, inside container)
                  Positioned(
                    bottom: isMobile ? 20 : 30,
                    right: isMobile ? 20 : 30,
                    child: _buildBackedByBadge()
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 1800.ms),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
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
              fontSize: 12,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
          const SizedBox(width: 4),
          Text(
            'Combinator Ã— alpz',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}