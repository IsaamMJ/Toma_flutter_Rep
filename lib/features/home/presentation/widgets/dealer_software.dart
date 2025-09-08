import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../core/components/logo_card_component.dart';
import '../../../../core/utils/responsive_helper.dart';

class IntegrationSection extends StatelessWidget {
  const IntegrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      color: Colors.grey.shade50, // Light background
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                // Header text
                Text(
                  'Integrates with Your Dealership Software',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: ResponsiveHelper.isMobile(context) ? 16 : 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms),

                const SizedBox(height: 40),

                // Logo grid using LogoCard components
                LogoGrid(
                  logoRows: _getIntegrationData(),
                  verticalSpacing: 24,
                  horizontalSpacing: 16,
                  baseAnimationDelay: 700, // Start after header animation
                  rowAnimationOffset: 150,
                  cardAnimationOffset: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Integration-specific data
  List<List<Map<String, dynamic>>> _getIntegrationData() {
    return [
      // Row 1
      [
        {
          'name': 'CDK',
          'color': Colors.black,
          'isCircle': true,
          'fontSize': 14.0,
        },
        {
          'name': 'Dealertrack',
          'color': const Color(0xFF1E3A8A),
          'subtitle': 'by Cox Automotive',
          'fontSize': 14.0,
        },
        {
          'name': 'myHoorma',
          'color': const Color(0xFFFF6B35),
          'hasIcon': true,
          'iconType': 'dot',
          'fontSize': 16.0,
        },
        {
          'name': 'xtime',
          'color': const Color(0xFFFF8C00),
          'hasSymbol': true,
          'fontSize': 18.0,
        },
        {
          'name': 'DCC',
          'color': Colors.black,
          'subtitle': 'CUSTOMER CONNECT',
          'fontSize': 14.0,
        },
      ],
      // Row 2
      [
        {
          'name': 'DEALER-FX',
          'color': const Color(0xFF8BC34A),
          'hasArrow': true,
          'fontSize': 12.0,
        },
        {
          'name': 'Reynolds',
          'color': const Color(0xFF1565C0),
          'subtitle': '&Reynolds.',
          'fontSize': 16.0,
        },
        {
          'name': 'PBS',
          'color': const Color(0xFF1565C0),
          'isOval': true,
          'fontSize': 18.0,
        },
        {
          'name': 'DEALER VAULT',
          'color': const Color(0xFF8BC34A),
          'hasIcon': true,
          'iconType': 'security',
          'fontSize': 11.0,
        },
        {
          'name': 'HOMENET',
          'color': const Color(0xFF00BCD4),
          'subtitle': 'AUTOMOTIVE',
          'fontSize': 14.0,
        },
      ],
    ];
  }
}