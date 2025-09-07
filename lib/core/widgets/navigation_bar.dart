import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/text_styles.dart';

class CustomNavigationBar extends StatelessWidget {
  final VoidCallback? onContactPressed;
  final VoidCallback? onCompanyPressed;
  final VoidCallback? onBlogPressed;
  final VoidCallback? onCaseStudiesPressed;
  final VoidCallback? onDealerLoginPressed;
  final VoidCallback? onBookDemoPressed;

  const CustomNavigationBar({
    super.key,
    this.onContactPressed,
    this.onCompanyPressed,
    this.onBlogPressed,
    this.onCaseStudiesPressed,
    this.onDealerLoginPressed,
    this.onBookDemoPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white, // Light background like toma design
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            // Logo
            Text(
              'toma',
              style: AppTextStyles.navItem.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),

            if (isDesktop) ...[
              const Spacer(),
              // Navigation Links - Centered
              Row(
                children: [
                  _buildNavItem('Contact', onContactPressed),
                  _buildNavItem('Company', onCompanyPressed),
                  _buildNavItem('Blog', onBlogPressed),
                  _buildNavItem('Case Studies', onCaseStudiesPressed),
                ],
              ),
              const Spacer(),

              // Action Buttons - Right
              Row(
                children: [
                  _buildDealerLoginButton(),
                  const SizedBox(width: 16),
                  _buildBookDemoButton(),
                ],
              ),
            ] else ...[
              const Spacer(),
              IconButton(
                onPressed: () => _showMobileMenu(context),
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, VoidCallback? onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(
            title,
            style: AppTextStyles.navItem.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDealerLoginButton() {
    return OutlinedButton.icon(
      onPressed: onDealerLoginPressed,
      icon: const Icon(Icons.person_outline, size: 18),
      label: const Text('Dealer Login'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildBookDemoButton() {
    return ElevatedButton(
      onPressed: onBookDemoPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: const Text('Book a Demo'),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileMenuItem('Contact', onContactPressed, context),
            _buildMobileMenuItem('Company', onCompanyPressed, context),
            _buildMobileMenuItem('Blog', onBlogPressed, context),
            _buildMobileMenuItem('Case Studies', onCaseStudiesPressed, context),
            const Divider(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  onDealerLoginPressed?.call();
                },
                icon: const Icon(Icons.person_outline),
                label: const Text('Dealer Login'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onBookDemoPressed?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Book a Demo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(String title, VoidCallback? onPressed, BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(color: AppColors.navText)),
      onTap: () {
        Navigator.pop(context);
        onPressed?.call();
      },
    );
  }
}