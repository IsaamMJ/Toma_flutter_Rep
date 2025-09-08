import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';
import '../../app/theme/app_constants.dart';
import '../../core/utils/responsive_helper.dart';
import '../components/nav_bar_item_button.dart';

class CustomNavigationBar extends StatefulWidget {
  final VoidCallback? onContactPressed;
  final VoidCallback? onCompanyPressed;
  final VoidCallback? onBlogPressed;
  final VoidCallback? onCaseStudiesPressed;
  final VoidCallback? onDealerLoginPressed;
  final VoidCallback? onBookDemoPressed;
  final String? activeRoute;

  const CustomNavigationBar({
    super.key,
    this.onContactPressed,
    this.onCompanyPressed,
    this.onBlogPressed,
    this.onCaseStudiesPressed,
    this.onDealerLoginPressed,
    this.onBookDemoPressed,
    this.activeRoute,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveHelper.getResponsiveValue(
        context: context,
        mobile: 70.0,
        tablet: 80.0,
        desktop: 85.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        border: Border(
          bottom: BorderSide(color: AppColors.navBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200), // Max content width - this prevents edge stretching
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Row(
              children: [
                // Logo
                Text(
                  'toma',
                  style: AppTextStyles.navItem.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: ResponsiveHelper.getResponsiveValue(
                      context: context,
                      mobile: 22.0,
                      tablet: 24.0,
                      desktop: 26.0,
                    ),
                    letterSpacing: -0.5,
                  ),
                ),

                if (ResponsiveHelper.isDesktop(context)) ...[
                  const Spacer(),
                  _buildDesktopNavigation(),
                  const Spacer(),
                  _buildActionButtons(),
                ] else ...[
                  const Spacer(),
                  _buildMobileMenuButton(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.navBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.navBorder.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          NavBarItemButton(
            title: 'Contact',
            onPressed: widget.onContactPressed,
            isActive: widget.activeRoute == '/contact',
          ),
          NavBarItemButton(
            title: 'Company',
            onPressed: widget.onCompanyPressed,
            isActive: widget.activeRoute == '/company',
          ),
          NavBarItemButton(
            title: 'Blog',
            onPressed: widget.onBlogPressed,
            isActive: widget.activeRoute == '/blog',
          ),
          NavBarItemButton(
            title: 'Case Studies',
            onPressed: widget.onCaseStudiesPressed,
            isActive: widget.activeRoute == '/case-studies',
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        OutlinedIconButton(
          label: 'Dealer Login',
          icon: Icons.person_outline,
          onPressed: widget.onDealerLoginPressed,
        ),
        const SizedBox(width: 12),
        EnhancedPrimaryButton(
          label: 'Book a Demo',
          onPressed: widget.onBookDemoPressed,
        ),
      ],
    );
  }

  Widget _buildMobileMenuButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _isMenuOpen
            ? AppColors.textPrimary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() => _isMenuOpen = !_isMenuOpen);
          HapticFeedback.lightImpact();
          _showMobileMenu();
        },
        child: AnimatedRotation(
          turns: _isMenuOpen ? 0.5 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            _isMenuOpen ? Icons.close : Icons.menu,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _showMobileMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      isScrollControlled: true,
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          color: AppColors.navBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.navBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Menu items
              _buildMenuItem('Contact', Icons.contact_mail_outlined, widget.onContactPressed),
              _buildMenuItem('Company', Icons.business_outlined, widget.onCompanyPressed),
              _buildMenuItem('Blog', Icons.article_outlined, widget.onBlogPressed),
              _buildMenuItem('Case Studies', Icons.analytics_outlined, widget.onCaseStudiesPressed),

              const SizedBox(height: 24),

              // Action buttons
              OutlinedIconButton(
                label: 'Dealer Login',
                icon: Icons.person_outline,
                isFullWidth: true,
                onPressed: () {
                  Navigator.pop(context);
                  widget.onDealerLoginPressed?.call();
                },
              ),
              const SizedBox(height: 12),
              EnhancedPrimaryButton(
                label: 'Book a Demo',
                isFullWidth: true,
                onPressed: () {
                  Navigator.pop(context);
                  widget.onBookDemoPressed?.call();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ).then((_) => setState(() => _isMenuOpen = false));
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback? onPressed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.navText, size: 20),
        title: Text(
          title,
          style: AppTextStyles.navItem.copyWith(color: AppColors.navText),
        ),
        onTap: () {
          Navigator.pop(context);
          HapticFeedback.selectionClick();
          onPressed?.call();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}