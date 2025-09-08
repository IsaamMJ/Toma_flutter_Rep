import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

class AutomationCTASection extends StatelessWidget {
  const AutomationCTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.grey.shade50, // Light gray background
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
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
        const SizedBox(height: 40),
        _buildImageSection(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildContentSection(context),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 6,
          child: _buildImageSection(context),
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main heading
        Text(
          'What will you automate?',
          style: TextStyle(
            color: Colors.black,
            fontSize: ResponsiveHelper.isMobile(context) ? 32 : 48,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

        const SizedBox(height: 24),

        // Description text
        Text(
          'Schedule a demo with Toma to learn more about the revenue you can capture and expenses you can reduce with automation & AI.',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: ResponsiveHelper.isMobile(context) ? 16 : 18,
            height: 1.5,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2),

        const SizedBox(height: 40),

        // CTA Button
        Container(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.mic,
              size: 20,
              color: Colors.white,
            ),
            label: Text(
              'Talk to Toma',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).scale(begin: const Offset(0.9, 0.9)),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Container(
      height: ResponsiveHelper.isMobile(context) ? 300 : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background pattern/texture (optional - can be removed if not needed)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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

            // Main CTA Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/cta_image.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image not found',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
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
    ).animate().fadeIn(duration: 800.ms, delay: 300.ms).slideX(begin: 0.1);
  }
}

// Custom painter for the wave pattern background
class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade200.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Create subtle wave lines
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