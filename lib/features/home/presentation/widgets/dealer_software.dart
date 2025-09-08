import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
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
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
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

              // Logo grid
              _buildLogoGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoGrid(BuildContext context) {
    final integrations = [
      // Row 1
      [
        {'name': 'CDK', 'color': Colors.black, 'isCircle': true},
        {'name': 'Dealertrack', 'color': Color(0xFF1E3A8A), 'subtitle': 'by Cox Automotive'},
        {'name': 'myHoorma', 'color': Color(0xFFFF6B35), 'hasIcon': true},
        {'name': 'xtime', 'color': Color(0xFFFF8C00), 'hasSymbol': true},
        {'name': 'DCC', 'color': Colors.black, 'subtitle': 'CUSTOMER CONNECT'},
      ],
      // Row 2
      [
        {'name': 'DEALER-FX', 'color': Color(0xFF8BC34A), 'hasArrow': true},
        {'name': 'Reynolds', 'color': Color(0xFF1565C0), 'subtitle': '&Reynolds.'},
        {'name': 'PBS', 'color': Color(0xFF1565C0), 'isOval': true},
        {'name': 'DEALER VAULT', 'color': Color(0xFF8BC34A), 'hasIcon': true},
        {'name': 'HOMENET', 'color': Color(0xFF00BCD4), 'subtitle': 'AUTOMOTIVE'},
      ],
    ];

    return Column(
      children: integrations.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final row = rowEntry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: ResponsiveHelper.isMobile(context)
              ? _buildMobileLogoRow(context, row, rowIndex)
              : _buildDesktopLogoRow(context, row, rowIndex),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopLogoRow(BuildContext context, List<Map<String, dynamic>> logos, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: logos.asMap().entries.map((entry) {
        final index = entry.key;
        final logo = entry.value;

        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildLogoCard(logo, rowIndex, index),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileLogoRow(BuildContext context, List<Map<String, dynamic>> logos, int rowIndex) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: logos.asMap().entries.map((entry) {
        final index = entry.key;
        final logo = entry.value;

        return Container(
          width: (MediaQuery.of(context).size.width - 80) / 2,
          child: _buildLogoCard(logo, rowIndex, index),
        );
      }).toList(),
    );
  }

  Widget _buildLogoCard(Map<String, dynamic> logo, int rowIndex, int index) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: _buildLogoContent(logo),
      ),
    ).animate().fadeIn(
      duration: 500.ms,
      delay: (300 + (rowIndex * 200) + (index * 100)).ms,
    ).slideY(begin: 0.2);
  }

  Widget _buildLogoContent(Map<String, dynamic> logo) {
    final name = logo['name'] as String;
    final color = logo['color'] as Color;
    final subtitle = logo['subtitle'] as String?;
    final isCircle = logo['isCircle'] as bool? ?? false;
    final hasArrow = logo['hasArrow'] as bool? ?? false;
    final hasIcon = logo['hasIcon'] as bool? ?? false;
    final hasSymbol = logo['hasSymbol'] as bool? ?? false;
    final isOval = logo['isOval'] as bool? ?? false;

    if (isCircle && name == 'CDK') {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            'CDK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    if (isOval && name == 'PBS') {
      return Container(
        width: 80,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'PBS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasArrow && name == 'DEALER-FX') ...[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (hasSymbol && name == 'xtime') ...[
              Text(
                '∞',
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            Text(
              name == 'xtime' ? 'xtime' : name,
              style: TextStyle(
                color: name == 'xtime' ? color : (name == 'myHoorma' ? color : color),
                fontSize: _getLogoFontSize(name),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hasIcon && name == 'myHoorma') ...[
              const SizedBox(width: 4),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
            if (hasIcon && name == 'DEALER VAULT') ...[
              const SizedBox(width: 8),
              Icon(
                Icons.security,
                color: color,
                size: 16,
              ),
            ],
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  double _getLogoFontSize(String name) {
    switch (name) {
      case 'CDK':
        return 16;
      case 'Dealertrack':
        return 14;
      case 'myHoorma':
        return 16;
      case 'xtime':
        return 18;
      case 'DCC':
        return 14;
      case 'DEALER-FX':
        return 12;
      case 'Reynolds':
        return 16;
      case 'PBS':
        return 18;
      case 'DEALER VAULT':
        return 11;
      case 'HOMENET':
        return 14;
      default:
        return 14;
    }
  }
}