import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/navigation_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widgets/hero_section.dart';
import '../widgets/clients_section.dart';

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

                    // Services Section
                    Container(
                      key: _servicesKey,
                      width: double.infinity,
                      color: AppColors.surface,
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: ResponsiveHelper.getMaxWidth(context),
                          ),
                          padding: ResponsiveHelper.getHorizontalPadding(context),
                          child: Text(
                            'Our Services',
                            style: ResponsiveHelper.isMobile(context)
                                ? AppTextStyles.sectionTitleMobile
                                : AppTextStyles.sectionTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    // Portfolio Section
                    Container(
                      key: _portfolioKey,
                      width: double.infinity,
                      color: AppColors.background,
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: ResponsiveHelper.getMaxWidth(context),
                          ),
                          padding: ResponsiveHelper.getHorizontalPadding(context),
                          child: Text(
                            'Our Portfolio',
                            style: ResponsiveHelper.isMobile(context)
                                ? AppTextStyles.sectionTitleMobile
                                : AppTextStyles.sectionTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    // Contact Section
                    Container(
                      key: _contactKey,
                      width: double.infinity,
                      color: AppColors.surface,
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: ResponsiveHelper.getMaxWidth(context),
                          ),
                          padding: ResponsiveHelper.getHorizontalPadding(context),
                          child: Text(
                            'Contact Us',
                            style: ResponsiveHelper.isMobile(context)
                                ? AppTextStyles.sectionTitleMobile
                                : AppTextStyles.sectionTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
}