import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomarep/features/home/presentation/widgets/footer.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/navigation_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
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
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _testimonialKey = GlobalKey();
  final GlobalKey _automationCTAKey = GlobalKey();
  final GlobalKey _integrationKey = GlobalKey();
  final GlobalKey _realCallsKey = GlobalKey();
  final GlobalKey _customerTestimonialKey = GlobalKey();
  final GlobalKey _whyTomaKey = GlobalKey();
  final GlobalKey _meetEmployeeKey = GlobalKey();
  final GlobalKey _tomafooter = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                        mobile: 70.0,
                        tablet: 80.0,
                        desktop: 90.0,
                      ),
                    ),

                    // Hero Section
                    HeroSection(
                      onViewWorkPressed: () => _scrollToSection(_portfolioKey),
                    ),

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

                    // Footer - no spacing needed
                    TomaFooter(key: _tomafooter),
                  ],
                ),
              ),

              // Fixed Navigation Bar - properly positioned
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomNavigationBar(
                  onContactPressed: () => _scrollToSection(_contactKey),
                  onCompanyPressed: _scrollToTop,
                  onBlogPressed: () => _scrollToSection(_automationKey),
                  onCaseStudiesPressed: () => _scrollToSection(_portfolioKey),
                  onDealerLoginPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Dealer Login pressed'),
                        backgroundColor: AppColors.textPrimary,
                      ),
                    );
                  },
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
      },
    );
  }

  // Helper method for consistent section spacing
  // Helper method for consistent section spacing - REDUCED for compact layout
  Widget _buildSectionSpacing(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper.getResponsiveValue(
        context: context,
        mobile: 24.0,   // Reduced from 40px (40% less)
        tablet: 32.0,   // Reduced from 60px (47% less)
        desktop: 10.0,  // Reduced from 80px (40% less)
      ),
    );
  }
}