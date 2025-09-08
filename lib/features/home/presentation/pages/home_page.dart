import 'package:flutter/material.dart';
import 'package:tomarep/features/home/presentation/widgets/footer.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/navigation_bar.dart';
import '../widgets/customer_testimonial_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/clients_section.dart';
import '../widgets/automation_section.dart';
import '../widgets/real_calls_section.dart';
import '../widgets/testimonial_section.dart';
import '../widgets/automation_cta_section.dart';
import '../widgets/dealer_software.dart';
import '../widgets/why_toma_section.dart';
import '../widgets/meet_employee_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _automationKey = GlobalKey();
  final GlobalKey _testimonialKey = GlobalKey();
  final GlobalKey _automationCTAKey = GlobalKey();
  final GlobalKey _integrationKey = GlobalKey();
  final GlobalKey _realCallsKey = GlobalKey();
  final GlobalKey _customerTestimonialKey = GlobalKey();
  final GlobalKey _whyTomaKey = GlobalKey();
  final GlobalKey _meetEmployeeKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: AppConstants.animationSlow,
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: AppConstants.animationSlow,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Navigation space - responsive
                SizedBox(
                  height: ResponsiveHelper.getResponsiveValue(
                    context: context,
                    mobile: AppConstants.navHeightMobile,
                    tablet: AppConstants.navHeightTablet,
                    desktop: AppConstants.navHeightDesktop,
                  ),
                ),

                // Hero Section
                const HeroSection(),


                // Clients Section
                const ClientsSection(),

                // Automation Section
                AutomationSection(key: _automationKey),

                _buildSectionSpacing(context),

                // Testimonial Section
                TestimonialSection(key: _testimonialKey),

                _buildSectionSpacing(context),

                // Automation CTA Section
                AutomationCTASection(key: _automationCTAKey),

                _buildSectionSpacing(context),

                // Integration Section
                IntegrationSection(key: _integrationKey),

                _buildSectionSpacing(context),

                // Real Calls Section
                RealCallsSection(key: _realCallsKey),

                _buildSectionSpacing(context),

                // Customer Testimonial Section
                CustomerTestimonialSection(key: _customerTestimonialKey),

                _buildSectionSpacing(context),

                // Why Toma Section
                WhyTomaSection(key: _whyTomaKey),

                _buildSectionSpacing(context),

                // Meet Employee Section
                MeetEmployeeSection(key: _meetEmployeeKey),

                // Footer
                TomaFooter(key: _footerKey),
              ],
            ),
          ),

          // Fixed Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(
              onContactPressed: () => _scrollToSection(_footerKey),
              onCompanyPressed: _scrollToTop,
              onBlogPressed: () => _scrollToSection(_automationKey),
              onCaseStudiesPressed: () => _scrollToSection(_customerTestimonialKey),
              // Removed onDealerLoginPressed - navigation bar handles it internally now
              onBookDemoPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Book Demo pressed'),
                    backgroundColor: AppColors.buttonPrimary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSpacing(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper.getResponsiveValue(
        context: context,
        mobile: AppConstants.sectionSpacingMobile,
        tablet: AppConstants.sectionSpacingTablet,
        desktop: AppConstants.sectionSpacingDesktop,
      ),
    );
  }
}