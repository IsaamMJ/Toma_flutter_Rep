import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../core/utils/responsive_helper.dart';

class CustomerTestimonialSection extends StatefulWidget {
  const CustomerTestimonialSection({super.key});

  @override
  State<CustomerTestimonialSection> createState() => _CustomerTestimonialSectionState();
}

class _CustomerTestimonialSectionState extends State<CustomerTestimonialSection> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> testimonials = [
    {
      'quote': 'Toma saves us 43 hours each month and is like adding a new team member. Our advisors can focus on in-person customers while AI handles routine inquiries perfectly.',
      'name': 'Eric Stockton',
      'title': 'Service Manager',
      'company': 'Boulder Nissan',
      'location': 'Boulder, CO',
      'results': '43 hours saved monthly',
      'dealershipType': 'Nissan',
      'image': 'assets/customers/nissan.jpg',
    },
    {
      'quote': 'Response times improved dramatically and customer satisfaction is at an all-time high. Toma handles complex service questions better than we expected.',
      'name': 'Johnson',
      'title': 'Operations Manager',
      'company': 'Metro Toyota',
      'location': 'Seattle, WA',
      'results': '85% faster response times',
      'dealershipType': 'Toyota',
      'image': 'assets/customers/toyota.jpg',
    },
    {
      'quote': 'Our team can focus on building relationships and closing deals while Toma automates routine tasks. The ROI has been exceptional.',
      'name': 'Michael Chen',
      'title': 'General Manager',
      'company': 'Pacific Honda',
      'location': 'San Diego, CA',
      'results': '200% ROI in 6 months',
      'dealershipType': 'Honda',
      'image': 'assets/customers/honda.jpg',
    },
  ];

  void _goToTestimonial(int index) {
    setState(() => currentIndex = index);
    _pageController.animateToPage(index, duration: AppConstants.animationMedium, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.getResponsiveValue(
          context: context,
          mobile: AppConstants.paddingXXL,
          tablet: AppConstants.paddingXXL + 20,
          desktop: 100,
        ),
      ),
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                _buildHeader(context, isMobile),
                SizedBox(height: ResponsiveHelper.getResponsiveValue(
                  context: context, mobile: 40, tablet: 50, desktop: 60,
                )),
                SizedBox(
                  height: ResponsiveHelper.getResponsiveValue(
                    context: context, mobile: 480, tablet: 420, desktop: 380,
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: testimonials.length,
                    onPageChanged: (index) => setState(() => currentIndex = index),
                    itemBuilder: (context, index) => _buildTestimonialCard(testimonials[index], context),
                  ),
                ),
                const SizedBox(height: 16),
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
          'Customer Success Stories',
          style: isMobile ? AppTextStyles.sectionTitleMobile : AppTextStyles.sectionTitle,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
        SizedBox(height: ResponsiveHelper.getResponsiveValue(
          context: context, mobile: 12, tablet: 16, desktop: 20,
        )),
        Text(
          'See how dealerships are transforming their operations\nand achieving measurable results with our AI platform.',
          style: isMobile
              ? AppTextStyles.bodyMedium.copyWith(fontSize: 14)
              : AppTextStyles.bodyLarge,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),
      ],
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial, BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    // Define consistent card height for both cards
    final cardHeight = ResponsiveHelper.getResponsiveValue(
      context: context,
      mobile: 200,
      tablet: 240,
      desktop: 280,
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            _buildPersonCard(testimonial, context, cardHeight),
            const SizedBox(height: 24),
            _buildQuoteCard(testimonial, context, cardHeight),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _buildQuoteCard(testimonial, context, cardHeight)),
          const SizedBox(width: 48),
          Expanded(flex: 1, child: _buildPersonCard(testimonial, context, cardHeight)),
        ],
      ),
    );
  }

  Widget _buildPersonCard(Map<String, dynamic> testimonial, BuildContext context, double cardHeight) {
    final brandColors = _getBrandColors(testimonial['dealershipType']);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      height: cardHeight, // Use the passed cardHeight parameter
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: brandColors,
        ),
        borderRadius: BorderRadius.circular(20),
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
          // Background pattern/texture
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company branding
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial['company'].split(' ')[0],
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      testimonial['dealershipType'].toUpperCase(),
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Person section
                Row(
                  children: [
                    // Person image
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
                        child: testimonial['image'] != null
                            ? (testimonial['image'].startsWith('http')
                            ? Image.network(
                          testimonial['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPersonAvatar(testimonial),
                        )
                            : Image.asset(
                          testimonial['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPersonAvatar(testimonial),
                        ))
                            : _buildPersonAvatar(testimonial),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Person details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            testimonial['name'],
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            testimonial['title'],
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: isMobile ? 11 : 12,
                            ),
                          ),
                          Text(
                            testimonial['location'],
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

                const SizedBox(height: 16),

                // Results badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    testimonial['results'],
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
    ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.3);
  }

  Widget _buildPersonAvatar(Map<String, dynamic> testimonial) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.6)],
        ),
      ),
      child: Center(
        child: Text(
          testimonial['name'].split(' ').map((n) => n[0]).join(''),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteCard(Map<String, dynamic> testimonial, BuildContext context, double cardHeight) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      height: cardHeight, // Use the passed cardHeight parameter
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
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
          Icon(Icons.format_quote, size: 36, color: AppColors.accent.withOpacity(0.6)),
          const SizedBox(height: 20),
          Expanded( // Allow text to fill remaining space
            child: Text(
              testimonial['quote'],
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isMobile ? 16 : 18,
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms);
  }

  Widget _buildNavigationControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavButton(Icons.arrow_back_ios, currentIndex > 0 ? () => _goToTestimonial(currentIndex - 1) : null),
        const SizedBox(width: 24),
        Row(
          children: testimonials.asMap().entries.map((entry) {
            final isActive = currentIndex == entry.key;
            return GestureDetector(
              onTap: () => _goToTestimonial(entry.key),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
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
        const SizedBox(width: 24),
        _buildNavButton(Icons.arrow_forward_ios, currentIndex < testimonials.length - 1 ? () => _goToTestimonial(currentIndex + 1) : null),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback? onTap) {
    final isEnabled = onTap != null;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isEnabled ? AppColors.divider : AppColors.textMuted.withOpacity(0.3)),
        boxShadow: isEnabled ? [BoxShadow(color: AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2))] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(icon, color: isEnabled ? AppColors.textSecondary : AppColors.textMuted, size: 16),
          ),
        ),
      ),
    );
  }

  List<Color> _getBrandColors(String dealershipType) {
    switch (dealershipType.toLowerCase()) {
      case 'nissan': return [Color(0xFFE52B2B), Color(0xFFC41E3A)];
      case 'toyota': return [Color(0xFFEB0A1E), Color(0xFFCC0A1E)];
      case 'honda': return [Color(0xFF0066CC), Color(0xFF004499)];
      default: return [AppColors.accent, AppColors.accentHover];
    }
  }
}