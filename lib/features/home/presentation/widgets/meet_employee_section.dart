import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/responsive_helper.dart';

class MeetEmployeeSection extends StatelessWidget {
  const MeetEmployeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.white,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          padding: ResponsiveHelper.getHorizontalPadding(context),
          child: Column(
            children: [
              // Main content section
              if (isMobile)
                _buildMobileLayout(context)
              else
                _buildDesktopLayout(context),

              const SizedBox(height: 80),

              // Press section
              _buildPressSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side - Content
        Expanded(
          flex: 1,
          child: _buildContentSection(context),
        ),

        const SizedBox(width: 80),

        // Right side - AI Assistant Image
        Expanded(
          flex: 1,
          child: _buildAIAssistantSection(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAIAssistantSection(context),
        const SizedBox(height: 40),
        _buildContentSection(context),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Meet Your New Employee',
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3),

        const SizedBox(height: 24),

        // Description
        Text(
          'Toma acts as a virtual team member, tirelessly working around the clock to handle tasks with speed and precision.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey.shade600,
            height: 1.6,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: -0.3),

        const SizedBox(height: 40),

        // Benefits checklist
        _buildBenefitsList(),

        const SizedBox(height: 40),

        // Talk to Toma button
        _buildTalkToTomaButton(),
      ],
    );
  }

  Widget _buildBenefitsList() {
    final benefits = [
      'Reduce training and turnover costs',
      'Increase efficiency without adding headcount',
      'Never miss a sales or service opportunity',
    ];

    return Column(
      children: benefits.asMap().entries.map((entry) {
        final index = entry.key;
        final benefit = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkmark
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
              ),

              const SizedBox(width: 16),

              // Benefit text
              Expanded(
                child: Text(
                  benefit,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(
          duration: 600.ms,
          delay: (400 + (index * 150)).ms,
        ).slideX(begin: -0.2);
      }).toList(),
    );
  }

  Widget _buildTalkToTomaButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle talk to Toma action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Talk to Toma',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 20,
              height: 20,
              child: Stack(
                children: [
                  Container(
                    width: 3,
                    height: 12,
                    margin: const EdgeInsets.only(left: 4, top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    width: 3,
                    height: 16,
                    margin: const EdgeInsets.only(left: 8, top: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    width: 3,
                    height: 10,
                    margin: const EdgeInsets.only(left: 12, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildAIAssistantSection(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: 40,
            left: 60,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: 80,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 40,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.purple.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 60,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main AI assistant image
          Center(
            child: Stack(
              children: [
                // Profile circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade200,
                            Colors.grey.shade300,
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

                // AI badge
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms, delay: 200.ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildPressSection(BuildContext context) {
    return Column(
      children: [
        // "As seen in" text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'As seen in these publications ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle "and more" tap
              },
              child: Text(
                'and more',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Press logos
        _buildPressLogos(context),
      ],
    ).animate().fadeIn(duration: 800.ms, delay: 1000.ms);
  }

  Widget _buildPressLogos(BuildContext context) {
    final pressLogos = [
      {'name': 'CAR DEALERSHIP GUY', 'isImage': false},
      {'name': 'TechCrunch', 'isImage': false, 'color': Colors.green},
      {'name': 'Automotive News', 'isImage': false, 'color': Colors.blue},
      {'name': 'ANDREESSEN HOROWITZ', 'isImage': false},
      {'name': 'Futurism', 'isImage': false},
      {'name': 'Auto Remarketing', 'isImage': false},
    ];

    return ResponsiveHelper.isMobile(context)
        ? _buildMobilePressLogos(pressLogos)
        : _buildDesktopPressLogos(pressLogos);
  }

  Widget _buildDesktopPressLogos(List<Map<String, dynamic>> logos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: logos.map((logo) => _buildPressLogo(logo)).toList(),
    );
  }

  Widget _buildMobilePressLogos(List<Map<String, dynamic>> logos) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: logos.map((logo) => _buildPressLogo(logo)).toList(),
    );
  }

  Widget _buildPressLogo(Map<String, dynamic> logo) {
    return Container(
      height: 40,
      constraints: const BoxConstraints(minWidth: 120),
      child: Center(
        child: Text(
          logo['name'] as String,
          style: TextStyle(
            fontSize: logo['name'] == 'TechCrunch' ? 16 : 14,
            fontWeight: logo['name'] == 'TechCrunch' ? FontWeight.bold : FontWeight.w600,
            color: (logo['color'] as Color?) ?? Colors.grey.shade700,
            letterSpacing: logo['name'] == 'ANDREESSEN HOROWITZ' || logo['name'] == 'CAR DEALERSHIP GUY'
                ? 1.2 : 0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}