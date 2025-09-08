import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_constants.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../data/datasources/footer_data.dart';

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
      padding: EdgeInsets.all(isMobile ? AppConstants.spaceL : AppConstants.spaceXXL),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(isMobile ? AppConstants.radiusL : AppConstants.radiusXXL),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppConstants.spaceL : AppConstants.spaceXXL + AppConstants.spaceS,
                vertical: isMobile ? AppConstants.spaceXL : AppConstants.spaceXXL + AppConstants.spaceS,
              ),
              child: Column(
                children: [
                  if (isMobile)
                    _buildMobileLayout(context)
                  else
                    _buildDesktopLayout(context),

                  SizedBox(height: isMobile ? AppConstants.spaceXL : AppConstants.spaceXXL),
                  _buildSocialMediaSection(),
                  SizedBox(height: isMobile ? AppConstants.spaceL : AppConstants.spaceXXL),

                  Container(
                    height: 1,
                    color: Colors.grey.shade800,
                    margin: EdgeInsets.only(bottom: isMobile ? AppConstants.spaceL : AppConstants.spaceXL),
                  ),

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
        Expanded(
          flex: 2,
          child: _buildLeftSection(context),
        ),
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center everything in mobile
      children: [
        _buildLeftSection(context),
        SizedBox(height: AppConstants.spaceXL), // Reduced spacing for mobile
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildLeftSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          FooterData.logoText,
          style: AppTextStyles.heroTitle.copyWith(
            fontSize: isMobile ? 28.0 : AppConstants.fontSizeHero, // Smaller on mobile
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: -1.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn(duration: AppConstants.animationSlow).slideY(begin: 0.3),

        SizedBox(height: isMobile ? AppConstants.spaceS : AppConstants.spaceM),

        Text(
          FooterData.tagline,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeXS : AppConstants.fontSizeM,
            color: Colors.grey.shade400,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.3),

        SizedBox(height: isMobile ? AppConstants.spaceL : AppConstants.spaceXL),

        Text(
          FooterData.signupText,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeXS : 15.0,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w400,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 400.ms).slideY(begin: 0.3),

        SizedBox(height: AppConstants.spaceM),
        _buildEmailSignupForm(isMobile),
      ],
    );
  }

  Widget _buildEmailSignupForm(bool isMobile) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 400),
      width: isMobile ? double.infinity : null,
      child: isMobile ? _buildMobileEmailForm() : _buildDesktopEmailForm(),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildMobileEmailForm() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: AppConstants.buttonHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade700,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: TextField(
            controller: _emailController,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontSize: AppConstants.fontSizeS,
            ),
            decoration: InputDecoration(
              hintText: FooterData.emailPlaceholder,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: Colors.grey.shade500,
                fontSize: AppConstants.fontSizeS,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppConstants.spaceL,
                vertical: AppConstants.spaceS,
              ),
            ),
          ),
        ),
        SizedBox(height: AppConstants.spaceM),
        SizedBox(
          width: double.infinity,
          height: AppConstants.buttonHeight,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: ElevatedButton(
              onPressed: () {
                if (_emailController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Signed up with ${_emailController.text}'),
                      backgroundColor: Colors.grey.shade800,
                    ),
                  );
                  _emailController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isHovered ? Colors.white : Colors.grey.shade300,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.spaceL,
                  vertical: AppConstants.spaceS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
              ),
              child: Text(
                FooterData.submitButtonText,
                style: AppTextStyles.button.copyWith(
                  fontSize: AppConstants.fontSizeS,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopEmailForm() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppConstants.buttonHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade700,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: TextField(
              controller: _emailController,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontSize: AppConstants.fontSizeS,
              ),
              decoration: InputDecoration(
                hintText: FooterData.emailPlaceholder,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey.shade500,
                  fontSize: AppConstants.fontSizeS,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppConstants.spaceL,
                  vertical: AppConstants.spaceS,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: AppConstants.spaceS),

        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: AppConstants.animationFast,
            child: ElevatedButton(
              onPressed: () {
                if (_emailController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Signed up with ${_emailController.text}'),
                      backgroundColor: Colors.grey.shade800,
                    ),
                  );
                  _emailController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isHovered ? Colors.white : Colors.grey.shade300,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.spaceL,
                  vertical: AppConstants.spaceS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
                minimumSize: Size(80, AppConstants.buttonHeight),
              ),
              child: Text(
                FooterData.submitButtonText,
                style: AppTextStyles.button.copyWith(
                  fontSize: AppConstants.fontSizeS,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      alignment: isMobile ? Alignment.center : Alignment.topRight,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: FooterData.navigationLinks.asMap().entries.map((entry) {
          final index = entry.key;
          final link = entry.value;

          return Container(
            margin: EdgeInsets.only(bottom: isMobile ? AppConstants.spaceXS : AppConstants.spaceS),
            child: InkWell(
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
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: isMobile ? AppConstants.fontSizeXS : 15.0,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.right,
              ),
            ),
          ).animate().fadeIn(
            duration: AppConstants.animationSlow,
            delay: (800 + (index * 100)).ms,
          ).slideY(begin: 0.3);
        }).toList(),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isMobile ? AppConstants.spaceS : AppConstants.spaceM,
      children: FooterData.socialMedia.asMap().entries.map((entry) {
        final index = entry.key;
        final social = entry.value;

        return _buildSocialIcon(social.icon, social.label);
      }).toList(),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 1200.ms);
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Open $label'),
            backgroundColor: Colors.grey.shade800,
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      child: Container(
        width: isMobile ? AppConstants.spaceL + 4 : AppConstants.spaceXL,
        height: isMobile ? AppConstants.spaceL + 4 : AppConstants.spaceXL,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade700,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        child: Icon(
          icon,
          color: Colors.grey.shade400,
          size: isMobile ? AppConstants.iconS : AppConstants.iconS,
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppConstants.spaceXS,
            runSpacing: AppConstants.spaceXS / 2,
            children: FooterData.bottomLinks.asMap().entries.map((entry) {
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
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: AppConstants.fontSizeXS,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  if (index < FooterData.bottomLinks.length - 1)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: AppConstants.spaceXS),
                      child: Text(
                        '•',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: AppConstants.fontSizeXS,
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: AppConstants.spaceS),
          Text(
            FooterData.copyright,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: AppConstants.fontSizeXS,
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
        Text(
          FooterData.copyright,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: AppConstants.fontSizeXS + 1,
            color: Colors.grey.shade600,
          ),
        ),
        Row(
          children: FooterData.bottomLinks.asMap().entries.map((entry) {
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
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: AppConstants.fontSizeXS + 1,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                if (index < FooterData.bottomLinks.length - 1)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: AppConstants.spaceM),
                    child: Text(
                      '•',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey.shade700,
                        fontSize: AppConstants.fontSizeXS + 1,
                      ),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 1500.ms);
  }
}