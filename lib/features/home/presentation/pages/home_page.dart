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
import '../widgets/meet_employee_section.dart'; // Add this import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _automationKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _testimonialKey = GlobalKey();
  final GlobalKey _automationCTAKey = GlobalKey();
  final GlobalKey _integrationKey = GlobalKey();
  final GlobalKey _realCallsKey = GlobalKey();
  final GlobalKey _customerTestimonialKey = GlobalKey();
  final GlobalKey _whyTomaKey = GlobalKey();
  final GlobalKey _meetEmployeeKey = GlobalKey(); // Add this key
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
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 80), // Navigation space

                    // Hero Section with animations
                    HeroSection(
                      onViewWorkPressed: () => _scrollToSection(_portfolioKey),
                    ),

                    // Clients Section - immediately after hero
                    const ClientsSection(),

                    // Automation Section
                    Container(
                      key: _automationKey,
                      child: const AutomationSection(),
                    ),

                    // Testimonial Section
                    Container(
                      key: _testimonialKey,
                      child: const TestimonialSection(),
                    ),

                    // Automation CTA Section
                    Container(
                      key: _automationCTAKey,
                      child: const AutomationCTASection(),
                    ),

                    // Integration Section
                    Container(
                      key: _integrationKey,
                      child: const IntegrationSection(),
                    ),

                    Container(
                      key: _realCallsKey,
                      child: const RealCallsSection(),
                    ),

                    Container(
                      key: _customerTestimonialKey,
                      child: const CustomerTestimonialSection(),
                    ),

                    Container(
                      key: _whyTomaKey,
                      child: const WhyTomaSection(),
                    ),

                    // Add the MeetEmployeeSection right after WhyTomaSection
                    Container(
                      key: _meetEmployeeKey,
                      child: const MeetEmployeeSection(),
                    ),
                    Container(
                      key: _tomafooter,
                      child: const TomaFooter(),
                    ),


                    // Fixed Navigation Bar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: CustomNavigationBar(
                        onContactPressed: () => _scrollToSection(_contactKey),
                        onCompanyPressed: _scrollToTop,
                        onBlogPressed: () => _scrollToSection(_servicesKey),
                        onCaseStudiesPressed: () =>
                            _scrollToSection(_portfolioKey),
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
              ),
            ],
          ),
        );
      }
        );
    }
    }
