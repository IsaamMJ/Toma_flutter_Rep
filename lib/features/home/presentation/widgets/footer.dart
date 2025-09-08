import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/responsive_helper.dart';

class TomaFooter extends StatefulWidget {
  const TomaFooter({super.key});

  @override
  State<TomaFooter> createState() => _TomaFooterState();
}

class _TomaFooterState extends State<TomaFooter> {
  final TextEditingController _emailController = TextEditingController();
  bool _isHovered = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 32 : 60,
                vertical: isMobile ? 40 : 60,
              ),
              child: Column(
                children: [
                  if (isMobile)
                    _buildMobileLayout(context)
                  else
                    _buildDesktopLayout(context),

                  const SizedBox(height: 40),

                  // Social media icons
                  _buildSocialMediaSection(),

                  const SizedBox(height: 40),

                  // Divider line
                  Container(
                    height: 1,
                    color: Colors.grey.shade800,
                    margin: const EdgeInsets.only(bottom: 30),
                  ),

                  // Bottom section with copyright and links
                  _buildBottomSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Logo and signup
        Expanded(
          flex: 2,
          child: _buildLeftSection(context),
        ),

        // Right side - Navigation links
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildLeftSection(context),
        const SizedBox(height: 40),
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildLeftSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Text(
          'toma',
          style: TextStyle(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: -1.5,
          ),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),

        const SizedBox(height: 16),

        // Tagline
        Text(
          'AI Automation Platform for Automotive Dealerships.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.grey.shade400,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),

        const SizedBox(height: 32),

        // Signup text
        Text(
          'Sign up and watch us build.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 15,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideY(begin: 0.3),

        const SizedBox(height: 16),

        // Email signup form
        _buildEmailSignupForm(isMobile),
      ],
    );
  }

  Widget _buildEmailSignupForm(bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        children: [
          // Email input
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _emailController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'your@dealership.com',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Submit button
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit
                  if (_emailController.text.isNotEmpty) {
                    // Process email signup
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signed up with ${_emailController.text}'),
                        backgroundColor: Colors.grey.shade800,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isHovered ? Colors.white : Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  elevation: 0,
                  minimumSize: const Size(80, 44),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildRightSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    final navigationLinks = [
      'Contact',
      'Company',
      'Case Studies',
      'Blog',
      'Careers',
    ];

    return Container(
      alignment: isMobile ? Alignment.center : Alignment.topRight,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: navigationLinks.asMap().entries.map((entry) {
          final index = entry.key;
          final link = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                // Handle navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Navigate to $link'),
                    backgroundColor: Colors.grey.shade800,
                  ),
                );
              },
              child: Text(
                link,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
            ),
          ).animate().fadeIn(
            duration: 600.ms,
            delay: (800 + (index * 100)).ms,
          ).slideY(begin: 0.3);
        }).toList(),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.close, 'X (Twitter)'),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.business, 'LinkedIn'),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.play_arrow, 'YouTube'),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 1200.ms);
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Open $label'),
            backgroundColor: Colors.grey.shade800,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade700,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color: Colors.grey.shade400,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final bottomLinks = ['Trust Center', 'Privacy Policy', 'Terms'];

    if (isMobile) {
      return Column(
        children: [
          // Bottom navigation links
          Wrap(
            alignment: WrapAlignment.center,
            children: bottomLinks.asMap().entries.map((entry) {
              final index = entry.key;
              final link = entry.value;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Navigate to $link'),
                          backgroundColor: Colors.grey.shade800,
                        ),
                      );
                    },
                    child: Text(
                      link,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  if (index < bottomLinks.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '•',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            '2025 Toma, Inc. All rights reserved.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Copyright
        Text(
          '2025 Toma, Inc. All rights reserved.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),

        // Bottom navigation links
        Row(
          children: bottomLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;

            return Row(
              children: [
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Navigate to $link'),
                        backgroundColor: Colors.grey.shade800,
                      ),
                    );
                  },
                  child: Text(
                    link,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                if (index < bottomLinks.length - 1)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '•',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 1500.ms);
  }
}