import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  static const String videoUrl = 'https://www.youtube.com/watch?v=1-BBlH2hbQg';
  bool _isVideoHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey.shade50, Colors.white],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: EdgeInsets.all(ResponsiveHelper.isMobile(context) ? 32 : 48),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ResponsiveHelper.isMobile(context)
                ? _buildMobileLayout()
                : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildVideoSection(),
        const SizedBox(height: 40),
        _buildContentSection(),
        const SizedBox(height: 48),
        _buildCarLogos(),
        const SizedBox(height: 40),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: _buildVideoSection()),
            const SizedBox(width: 64),
            Expanded(flex: 6, child: _buildContentSection()),
          ],
        ),
        const SizedBox(height: 64),
        _buildCarLogos(),
        const SizedBox(height: 48),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildVideoSection() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isVideoHovered = true),
      onExit: (_) => setState(() => _isVideoHovered = false),
      child: GestureDetector(
        onTap: _launchVideo,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(_isVideoHovered ? 0.2 : 0.1),
                blurRadius: _isVideoHovered ? 24 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              _buildVideoBackground(),
              _buildVideoOverlay(),
              _buildPlayButton(),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildVideoBackground() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            // Full width image with proper alignment
            Image.asset(
              'assets/images/chadwick.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, __, ___) => _buildPersonPlaceholder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonPlaceholder() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.grey.shade700, Colors.grey.shade800],
          ),
        ),
        child: Icon(Icons.person, size: 60, color: Colors.grey.shade500),
      ),
    );
  }

  Widget _buildVideoOverlay() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Chadwick Martin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'President, Martin Management Group',
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: AnimatedScale(
        scale: _isVideoHovered ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(Icons.play_arrow, color: Colors.black.withOpacity(0.8), size: 32),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learn how Toma is generating more service revenue across all their locations around the country.',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelper.isMobile(context) ? 32 : 42,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),

        const SizedBox(height: 40),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Results in 90 Days',
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

        const SizedBox(height: 32),

        _buildStats(),
      ],
    );
  }

  Widget _buildStats() {
    final stats = [
      {'number': '9K+', 'label': 'Appointments\nBooked', 'color': const Color(0xFF10B981)},
      {'number': '\$2M+', 'label': 'Revenue\nGenerated', 'color': const Color(0xFF8B5CF6)},
      {'number': '22K+', 'label': 'Calls\nAutomated', 'color': const Color(0xFF06B6D4)},
    ];

    return ResponsiveHelper.isMobile(context)
        ? Column(children: _buildStatItems(stats))
        : Row(children: _buildStatItems(stats));
  }

  List<Widget> _buildStatItems(List<Map<String, dynamic>> stats) {
    return stats.asMap().entries.map((entry) {
      final index = entry.key;
      final stat = entry.value;
      final isMobile = ResponsiveHelper.isMobile(context);

      return Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: isMobile ? 0 : (index < 2 ? 32 : 0),
            bottom: isMobile ? 32 : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      color: stat['color'],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stat['number']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 36 : 44,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          stat['label']!,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(
        duration: 700.ms,
        delay: (600 + index * 150).ms,
      ).slideX(begin: -0.2);
    }).toList();
  }

  Widget _buildCarLogos() {
    final brands = ['subaru', 'nissan', 'toyota', 'hyundai', 'genesis', 'dodge', 'audi', 'kia', 'honda'];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: ResponsiveHelper.isMobile(context) ? 24 : 48,
        runSpacing: 24,
        children: brands.asMap().entries.map((entry) {
          final index = entry.key;
          final brand = entry.value;

          return Container(
            height: 40,
            constraints: const BoxConstraints(minWidth: 60),
            child: Image.asset(
              'assets/images/brands/$brand.png',
              height: 32,
              fit: BoxFit.contain,
              color: Colors.white.withOpacity(0.7),
              errorBuilder: (_, __, ___) => _buildBrandFallback(brand),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: (1200 + index * 100).ms);
        }).toList(),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms);
  }

  Widget _buildBrandFallback(String brand) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        brand.toUpperCase(),
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPrimaryButton(),
        const SizedBox(width: 24),
        _buildSecondaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      height: 52,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          elevation: 0,
        ),
        child: const Text(
          'Read Case Study',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1800.ms).slideY(begin: 0.5);
  }

  Widget _buildSecondaryButton() {
    return Container(
      height: 52,
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
        label: const Text(
          'See All Studies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1900.ms).slideY(begin: 0.5);
  }

  Future<void> _launchVideo() async {
    try {
      final uri = Uri.parse(videoUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching video: $e');
    }
  }
}