import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/testimonial_data.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  bool _isVideoHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey.shade50, Colors.white],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Container(
              padding: EdgeInsets.all(ResponsiveHelper.isMobile(context)
                  ? AppConstants.spaceL  // Reduced from spaceXL
                  : AppConstants.spaceXXL),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.1),
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
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildVideoSection(),
        SizedBox(height: AppConstants.spaceXL), // Reduced from spaceXXL
        _buildContentSection(),
        SizedBox(height: AppConstants.spaceXXL),
        _buildCarLogos(),
        SizedBox(height: AppConstants.spaceXXL),
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
            SizedBox(width: AppConstants.spaceXXXL),
            Expanded(flex: 6, child: _buildContentSection()),
          ],
        ),
        SizedBox(height: AppConstants.spaceXXXL),
        _buildCarLogos(),
        SizedBox(height: AppConstants.spaceXL),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildVideoSection() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isVideoHovered = true),
      onExit: (_) => setState(() => _isVideoHovered = false),
      child: GestureDetector(
        onTap: _launchVideo,
        child: AnimatedContainer(
          duration: AppConstants.animationMedium,
          height: isMobile ? 220 : 300, // Reduced mobile height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
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
    ).animate().fadeIn(duration: AppConstants.animationSlow).scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildVideoBackground() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        child: Stack(
          children: [
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
            Image.asset(
              TestimonialData.videoThumbnail,
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
        width: 80, // Reduced size for mobile
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.grey.shade700, Colors.grey.shade800],
          ),
        ),
        child: Icon(
            Icons.person,
            size: ResponsiveHelper.isMobile(context) ? AppConstants.iconXL : AppConstants.iconXXL,
            color: Colors.grey.shade500
        ),
      ),
    );
  }

  Widget _buildVideoOverlay() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Positioned(
      bottom: AppConstants.spaceM, // Reduced spacing
      left: AppConstants.spaceM,
      right: AppConstants.spaceM,
      child: Container(
        padding: EdgeInsets.all(isMobile ? AppConstants.spaceM : AppConstants.spaceL),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.85),
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              TestimonialData.testimonialName,
              style: (isMobile ? AppTextStyles.bodyMedium : AppTextStyles.bodyLarge).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppConstants.spaceXS),
            Text(
              TestimonialData.testimonialTitle,
              style: (isMobile ? AppTextStyles.bodySmall : AppTextStyles.bodyMedium).copyWith(
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    final isMobile = ResponsiveHelper.isMobile(context);
    final buttonSize = isMobile ? AppConstants.spaceXXL : AppConstants.spaceXXXL;

    return Positioned(
      top: AppConstants.spaceM, // Moved to top instead of bottom
      right: AppConstants.spaceM,
      child: AnimatedScale(
        scale: _isVideoHovered ? 1.1 : 1.0,
        duration: AppConstants.animationMedium,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.play_arrow,
            color: Colors.black.withOpacity(0.8),
            size: isMobile ? AppConstants.iconL : AppConstants.iconXL,
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TestimonialData.mainHeadline,
          style: GoogleFonts.crimsonText(
            color: Colors.white,
            fontSize: isMobile ? 24.0 : 36.0, // Reduced mobile font size
            fontWeight: FontWeight.w800,
            height: 1.2, // Increased line height for better spacing
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.3),

        SizedBox(height: isMobile ? AppConstants.spaceXL : AppConstants.spaceXXL),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spaceM,
            vertical: AppConstants.spaceS,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
          ),
          child: Text(
            TestimonialData.resultsBadge,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 400.ms),

        SizedBox(height: AppConstants.spaceXL),
        _buildStats(),
      ],
    );
  }

  Widget _buildStats() {
    final isMobile = ResponsiveHelper.isMobile(context);

    if (isMobile) {
      return Column(
        children: _buildStatItems(),
      );
    } else {
      return Row(
        children: _buildStatItems(),
      );
    }
  }

  List<Widget> _buildStatItems() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return TestimonialData.stats.asMap().entries.map((entry) {
      final index = entry.key;
      final stat = entry.value;

      Widget statWidget = Container(
        margin: EdgeInsets.only(
          right: !isMobile && index < TestimonialData.stats.length - 1 ? AppConstants.spaceXL : 0,
          bottom: isMobile && index < TestimonialData.stats.length - 1 ? AppConstants.spaceL : 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: isMobile ? AppConstants.spaceXL : AppConstants.spaceXXL,
              decoration: BoxDecoration(
                color: stat.color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: AppConstants.spaceM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stat.number,
                    style: AppTextStyles.heroTitle.copyWith(
                      color: Colors.white,
                      fontSize: isMobile ? 28.0 : 40.0, // Reduced mobile font size
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: AppConstants.spaceXS),
                  Text(
                    stat.label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(
        duration: AppConstants.animationSlow,
        delay: (600 + index * 150).ms,
      ).slideX(begin: -0.2);

      return isMobile ? statWidget : Expanded(child: statWidget);
    }).toList();
  }

  Widget _buildCarLogos() {
    return Container(
      padding: EdgeInsets.all(AppConstants.spaceL),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: ResponsiveHelper.isMobile(context) ? AppConstants.spaceL : AppConstants.spaceXXL,
        runSpacing: AppConstants.spaceL,
        children: TestimonialData.carBrands.asMap().entries.map((entry) {
          final index = entry.key;
          final brand = entry.value;

          return Container(
            height: 40,
            constraints: const BoxConstraints(minWidth: 60),
            child: Image.asset(
              brand.assetPath,
              height: 32,
              fit: BoxFit.contain,
              color: Colors.white.withOpacity(0.7),
              errorBuilder: (_, __, ___) => _buildBrandFallback(brand.name),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: (1200 + index * 100).ms);
        }).toList(),
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 1000.ms);
  }

  Widget _buildBrandFallback(String brand) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.spaceS,
        vertical: AppConstants.spaceS,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(AppConstants.spaceXS),
      ),
      child: Text(
        brand.toUpperCase(),
        style: AppTextStyles.bodySmall.copyWith(
          color: Colors.grey.shade500,
          fontSize: AppConstants.fontSizeXS,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final isMobile = ResponsiveHelper.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          _buildPrimaryButton(),
          SizedBox(height: AppConstants.spaceM),
          _buildSecondaryButton(),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPrimaryButton(),
        SizedBox(width: AppConstants.spaceL),
        _buildSecondaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return SizedBox(
      height: 52,
      width: isMobile ? double.infinity : null,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceXL),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          elevation: 0,
        ),
        child: Text(
          'Read Case Study',
          style: AppTextStyles.button.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 1800.ms).slideY(begin: 0.5);
  }

  Widget _buildSecondaryButton() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return SizedBox(
      height: 52,
      width: isMobile ? double.infinity : null,
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(Icons.arrow_forward, size: AppConstants.iconM, color: Colors.white),
        label: Text(
          'See All Studies',
          style: AppTextStyles.button.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceL),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: BorderSide(color: Colors.white.withOpacity(0.2)),
          ),
        ),
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 1900.ms).slideY(begin: 0.5);
  }

  Future<void> _launchVideo() async {
    try {
      final uri = Uri.parse(TestimonialData.videoUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching video: $e');
    }
  }
}