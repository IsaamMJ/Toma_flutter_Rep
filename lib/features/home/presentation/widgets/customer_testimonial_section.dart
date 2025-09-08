import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/customer_testimonial_dat.dart';

class CustomerTestimonialSection extends StatefulWidget {
  const CustomerTestimonialSection({super.key});

  @override
  State<CustomerTestimonialSection> createState() => _CustomerTestimonialSectionState();
}

class _CustomerTestimonialSectionState extends State<CustomerTestimonialSection> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  void _goToTestimonial(int index) {
    setState(() => currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: AppConstants.animationMedium,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppConstants.sectionPaddingVertical),
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                _buildHeader(context, isMobile),
                SizedBox(height: AppConstants.spaceXXL),
                SizedBox(
                  height: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: 480.0,
                    tablet: 420.0,
                    desktop: 380.0,
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: CustomerTestimonialData.testimonials.length,
                    onPageChanged: (index) => setState(() => currentIndex = index),
                    itemBuilder: (context, index) => _buildTestimonialCard(
                      CustomerTestimonialData.testimonials[index],
                      context,
                    ),
                  ),
                ),
                SizedBox(height: AppConstants.spaceM),
                _buildNavigationControls(context),
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
          CustomerTestimonialData.sectionTitle,
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
          CustomerTestimonialData.sectionDescription,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeS : AppConstants.fontSizeL,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildTestimonialCard(CustomerTestimonial testimonial, BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final cardHeight = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 200.0,
      tablet: 240.0,
      desktop: 280.0,
    );

    if (isMobile) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceS),
        child: Column(
          children: [
            _buildPersonCard(testimonial, context, cardHeight),
            SizedBox(height: AppConstants.spaceL),
            _buildQuoteCard(testimonial, context, cardHeight),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _buildQuoteCard(testimonial, context, cardHeight)),
          SizedBox(width: AppConstants.spaceXXL),
          Expanded(flex: 1, child: _buildPersonCard(testimonial, context, cardHeight)),
        ],
      ),
    );
  }

  Widget _buildPersonCard(CustomerTestimonial testimonial, BuildContext context, double cardHeight) {
    final brandColors = _getBrandColors(testimonial.dealershipType);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: brandColors,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.spaceL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.company.split(' ')[0],
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? AppConstants.fontSizeL : AppConstants.fontSizeXXL,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      testimonial.dealershipType.toUpperCase(),
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? AppConstants.fontSizeM : AppConstants.fontSizeL,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      width: isMobile ? 56 : 64,
                      height: isMobile ? 56 : 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          testimonial.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPersonAvatar(testimonial),
                        ),
                      ),
                    ),
                    SizedBox(width: AppConstants.spaceM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            testimonial.name,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? AppConstants.fontSizeS : AppConstants.fontSizeM,
                            ),
                          ),
                          SizedBox(height: AppConstants.spaceXS),
                          Text(
                            testimonial.title,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: isMobile ? 11 : AppConstants.fontSizeXS,
                            ),
                          ),
                          Text(
                            testimonial.location,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isMobile ? 10 : 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppConstants.spaceM),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.spaceS,
                    vertical: AppConstants.spaceXS,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    testimonial.results,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow).slideX(begin: 0.3);
  }

  Widget _buildPersonAvatar(CustomerTestimonial testimonial) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.6)],
        ),
      ),
      child: Center(
        child: Text(
          testimonial.name.split(' ').map((n) => n[0]).join(''),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteCard(CustomerTestimonial testimonial, BuildContext context, double cardHeight) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      height: cardHeight,
      padding: EdgeInsets.all(AppConstants.spaceXL),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote,
            size: 36,
            color: AppColors.accent.withOpacity(0.6),
          ),
          SizedBox(height: AppConstants.spaceL),
          Expanded(
            child: Text(
              testimonial.quote,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isMobile ? AppConstants.fontSizeM : AppConstants.fontSizeL,
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms);
  }

  Widget _buildNavigationControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavButton(
          Icons.arrow_back_ios,
          currentIndex > 0 ? () => _goToTestimonial(currentIndex - 1) : null,
        ),
        SizedBox(width: AppConstants.spaceL),
        Row(
          children: CustomerTestimonialData.testimonials.asMap().entries.map((entry) {
            final isActive = currentIndex == entry.key;
            return GestureDetector(
              onTap: () => _goToTestimonial(entry.key),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppConstants.spaceXS),
                width: isActive ? 32 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isActive ? AppColors.accent : AppColors.textMuted.withOpacity(0.3),
                ),
              ).animate().scale(duration: AppConstants.animationFast, curve: Curves.easeInOut),
            );
          }).toList(),
        ),
        SizedBox(width: AppConstants.spaceL),
        _buildNavButton(
          Icons.arrow_forward_ios,
          currentIndex < CustomerTestimonialData.testimonials.length - 1
              ? () => _goToTestimonial(currentIndex + 1)
              : null,
        ),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback? onTap) {
    final isEnabled = onTap != null;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppConstants.spaceS),
        border: Border.all(
          color: isEnabled ? AppColors.divider : AppColors.textMuted.withOpacity(0.3),
        ),
        boxShadow: isEnabled ? [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.spaceS),
          onTap: onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              icon,
              color: isEnabled ? AppColors.textSecondary : AppColors.textMuted,
              size: AppConstants.iconS,
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getBrandColors(String dealershipType) {
    switch (dealershipType.toLowerCase()) {
      case 'nissan':
        return [Color(0xFFE52B2B), Color(0xFFC41E3A)];
      case 'toyota':
        return [Color(0xFFEB0A1E), Color(0xFFCC0A1E)];
      case 'honda':
        return [Color(0xFF0066CC), Color(0xFF004499)];
      default:
        return [AppColors.accent, AppColors.accentHover];
    }
  }
}