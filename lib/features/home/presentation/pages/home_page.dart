import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/navigation_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

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
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 80), // Navigation space

                    // Hero Section
                    Container(
                      height: 600,
                      width: double.infinity,
                      color: AppColors.background,
                      child: Center(
                        child: Padding(
                          padding: ResponsiveHelper.getHorizontalPadding(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'We Create Digital Excellence',
                                style: ResponsiveHelper.isMobile(context)
                                    ? AppTextStyles.heroTitleMobile
                                    : AppTextStyles.heroTitle,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Transforming ideas into powerful digital experiences',
                                style: AppTextStyles.heroSubtitle,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: () => _scrollToSection(_portfolioKey),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16
                                  ),
                                ),
                                child: const Text('View Our Work'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Services Section
                    Container(
                      key: _servicesKey,
                      height: 400,
                      color: AppColors.surface,
                      child: Center(
                        child: Text(
                          'Our Services',
                          style: ResponsiveHelper.isMobile(context)
                              ? AppTextStyles.sectionTitleMobile
                              : AppTextStyles.sectionTitle,
                        ),
                      ),
                    ),

                    // Portfolio Section
                    Container(
                      key: _portfolioKey,
                      height: 400,
                      color: AppColors.card,
                      child: Center(
                        child: Text(
                          'Our Portfolio',
                          style: ResponsiveHelper.isMobile(context)
                              ? AppTextStyles.sectionTitleMobile
                              : AppTextStyles.sectionTitle,
                        ),
                      ),
                    ),

                    // Contact Section
                    Container(
                      key: _contactKey,
                      height: 400,
                      color: AppColors.surface,
                      child: Center(
                        child: Text(
                          'Contact Us',
                          style: ResponsiveHelper.isMobile(context)
                              ? AppTextStyles.sectionTitleMobile
                              : AppTextStyles.sectionTitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Fixed Navigation
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomNavigationBar(
                  onContactPressed: () => _scrollToSection(_contactKey),
                  onCompanyPressed: _scrollToTop, // Map to home for now
                  onBlogPressed: () => _scrollToSection(_servicesKey), // Map to services
                  onCaseStudiesPressed: () => _scrollToSection(_portfolioKey), // Map to portfolio
                  onDealerLoginPressed: () {
                    // Handle dealer login
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dealer Login pressed')),
                    );
                  },
                  onBookDemoPressed: () {
                    // Handle book demo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Book Demo pressed')),
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
}