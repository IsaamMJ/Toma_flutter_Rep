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
      padding: EdgeInsets.all(AppConstants.spaceXXL),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppConstants.spaceXL : AppConstants.spaceXXL + AppConstants.spaceS,
                vertical: isMobile ? AppConstants.spaceXXL : AppConstants.spaceXXL + AppConstants.spaceS,
              ),
              child: Column(
                children: [
                  if (isMobile)
                    _buildMobileLayout(context)
                  else
                    _buildDesktopLayout(context),

                  SizedBox(height: AppConstants.spaceXXL),
                  _buildSocialMediaSection(),
                  SizedBox(height: AppConstants.spaceXXL),

                  Container(
                    height: 1,
                    color: Colors.grey.shade800,
                    margin: EdgeInsets.only(bottom: AppConstants.spaceXL),
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
      children: [
        _buildLeftSection(context),
        SizedBox(height: AppConstants.spaceXXL),
        _buildRightSection(context),
      ],
    );
  }

  Widget _buildLeftSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FooterData.logoText,
          style: AppTextStyles.heroTitle.copyWith(
            fontSize: isMobile ? 36.0 : AppConstants.fontSizeHero,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: -1.5,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow).slideY(begin: 0.3),

        SizedBox(height: AppConstants.spaceM),

        Text(
          FooterData.tagline,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeS : AppConstants.fontSizeM,
            color: Colors.grey.shade400,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 200.ms).slideY(begin: 0.3),

        SizedBox(height: AppConstants.spaceXL),

        Text(
          FooterData.signupText,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: isMobile ? AppConstants.fontSizeS : 15.0,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 400.ms).slideY(begin: 0.3),

        SizedBox(height: AppConstants.spaceM),
        _buildEmailSignupForm(isMobile),
      ],
    );
  }

  Widget _buildEmailSignupForm(bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 600.ms).slideY(begin: 0.3);
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
            margin: EdgeInsets.only(bottom: AppConstants.spaceS),
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
                  fontSize: 15.0,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: FooterData.socialMedia.asMap().entries.map((entry) {
        final index = entry.key;
        final social = entry.value;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spaceS),
          child: _buildSocialIcon(social.icon, social.label),
        );
      }).toList(),
    ).animate().fadeIn(duration: AppConstants.animationSlow, delay: 1200.ms);
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
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      child: Container(
        width: AppConstants.spaceXL,
        height: AppConstants.spaceXL,
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
          size: AppConstants.iconS,
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
                        fontSize: AppConstants.fontSizeXS + 1,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  if (index < FooterData.bottomLinks.length - 1)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: AppConstants.spaceS),
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
          SizedBox(height: AppConstants.spaceM),
          Text(
            FooterData.copyright,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: AppConstants.fontSizeXS + 1,
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