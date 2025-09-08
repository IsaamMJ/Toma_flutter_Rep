import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.white, // Light background like your page
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          padding: ResponsiveHelper.getHorizontalPadding(context),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A), // Black container background
              borderRadius: BorderRadius.circular(20),
            ),
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
        _buildVideoSection(context),
        const SizedBox(height: 32),
        _buildContentSection(context),
        const SizedBox(height: 40),
        _buildCarLogos(context),
        const SizedBox(height: 32),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _buildVideoSection(context),
            ),
            const SizedBox(width: 60),
            Expanded(
              flex: 6,
              child: _buildContentSection(context),
            ),
          ],
        ),
        const SizedBox(height: 60),
        _buildCarLogos(context),
        const SizedBox(height: 40),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildVideoSection(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF333333),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Video background with person image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF1F1F1F),
              child: Stack(
                children: [
                  // Person image placeholder (you can replace with actual image)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF2A2A2A),
                            const Color(0xFF1A1A1A),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade600,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Name and title overlay at bottom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Chadwick Martin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'President, Martin Management Group',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Play button
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1);
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main heading
        Text(
          'Learn how Toma is generating more service revenue across all their locations around the country.',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelper.isMobile(context) ? 28 : 36,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

        const SizedBox(height: 32),

        // Stats label
        Text(
          'In 90 Days:',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

        const SizedBox(height: 24),

        // Statistics
        ResponsiveHelper.isMobile(context)
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildStatItems(context),
        )
            : Row(
          children: _buildStatItems(context),
        ),
      ],
    );
  }

  List<Widget> _buildStatItems(BuildContext context) {
    final stats = [
      {'number': '9000+', 'label': 'Appointments\nBooked'},
      {'number': '\$2M+', 'label': 'Revenue\nGenerated'},
      {'number': '22K+', 'label': 'Calls\nAutomated'},
    ];

    return stats.asMap().entries.map((entry) {
      final index = entry.key;
      final stat = entry.value;
      final isMobile = ResponsiveHelper.isMobile(context);

      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: isMobile ? 0 : (index < 2 ? 48 : 0),
            bottom: isMobile ? 24 : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat['number']!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 32 : 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat['label']!,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(
        duration: 600.ms,
        delay: (600 + index * 150).ms,
      );
    }).toList();
  }

  Widget _buildCarLogos(BuildContext context) {
    final carLogos = [
      {'name': 'SUBARU', 'icon': Icons.circle},
      {'name': 'NISSAN', 'icon': Icons.circle},
      {'name': 'TOYOTA', 'icon': Icons.circle},
      {'name': 'HYUNDAI', 'icon': Icons.circle},
      {'name': 'GENESIS', 'icon': Icons.circle},
      {'name': 'DODGE', 'icon': Icons.circle},
      {'name': 'AUDI', 'icon': Icons.circle},
      {'name': 'KIA', 'icon': Icons.circle},
      {'name': 'HONDA', 'icon': Icons.circle},
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: ResponsiveHelper.isMobile(context) ? 24 : 40,
      runSpacing: 20,
      children: carLogos.asMap().entries.map((entry) {
        final index = entry.key;
        final logo = entry.value;

        return Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                logo['icon'] as IconData,
                color: Colors.grey.shade600,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                logo['name'] as String,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(
          duration: 400.ms,
          delay: (1000 + index * 80).ms,
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Read Case Study button
        Container(
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: Text(
              'Read Case Study',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 1600.ms),

        const SizedBox(width: 24),

        // See All Studies button
        Container(
          height: 48,
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward,
              size: 16,
              color: Colors.white,
            ),
            label: Text(
              'See All Studies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 1700.ms),
      ],
    );
  }
}