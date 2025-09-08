import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/responsive_helper.dart';

class WhyTomaSection extends StatelessWidget {
  const WhyTomaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                // Small header text
                Text(
                  'Why Toma?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms),

                const SizedBox(height: 16),

                // Main title
                Text(
                  'There\'s No Competition',
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),

                const SizedBox(height: 24),

                // Subtitle
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Built for dealerships that refuse to settle, Toma\'s AI outperforms the rest—smarter, faster, and more reliable than any alternative.',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                ),

                const SizedBox(height: 60),

                // Features grid
                _buildFeaturesGrid(context, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context, bool isMobile) {
    final features = [
      {
        'icon': Icons.all_out_outlined,
        'title': 'End-to-End Automation',
        'description': 'Automate tasks completely, reducing reliance on frequent human intervention.',
      },
      {
        'icon': Icons.headset_mic_outlined,
        'title': 'Natural & Fast Conversations',
        'description': 'Fine-tuned AI provides more natural interactions and the lowest response latency.',
      },
      {
        'icon': Icons.send_outlined,
        'title': 'Omnichannel Communications',
        'description': 'Automate voice and SMS interactions, unlike single-channel competitor offerings.',
      },
      {
        'icon': Icons.link_outlined,
        'title': '1-Hour Support Included',
        'description': 'Rest assured you can roll out new technology with our dedicated support team.',
      },
      {
        'icon': Icons.rocket_launch_outlined,
        'title': 'Onboard With Ease',
        'description': 'Deploy quickly with minimal training, without disrupting your dealership\'s daily operations.',
      },
      {
        'icon': Icons.psychology_outlined,
        'title': 'In-House AI Advantage',
        'description': 'Our proprietary AI allows deeper customization compared to other products.',
      },
    ];

    if (isMobile) {
      return Column(
        children: features.asMap().entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildFeatureCard(entry.value, entry.key),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        // First row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildFeatureCard(features[0], 0)),
            const SizedBox(width: 16),
            Expanded(child: _buildFeatureCard(features[1], 1)),
            const SizedBox(width: 16),
            Expanded(child: _buildFeatureCard(features[2], 2)),
          ],
        ),
        const SizedBox(height: 16),
        // Second row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildFeatureCard(features[3], 3)),
            const SizedBox(width: 16),
            Expanded(child: _buildFeatureCard(features[4], 4)),
            const SizedBox(width: 16),
            Expanded(child: _buildFeatureCard(features[5], 5)),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature, int index) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              feature['icon'] as IconData,
              size: 24,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 24),

          // Title
          Text(
            feature['title'] as String,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            feature['description'] as String,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: 600.ms,
      delay: (200 + (index * 100)).ms,
    ).slideY(begin: 0.2);
  }
}

// Alternative version with custom icons using the same professional layout
class WhyTomaSectionCustomIcons extends StatelessWidget {
  const WhyTomaSectionCustomIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                // Small header text
                Text(
                  'Why Toma?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms),

                const SizedBox(height: 16),

                // Main title
                Text(
                  'There\'s No Competition',
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),

                const SizedBox(height: 24),

                // Subtitle
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    'Built for dealerships that refuse to settle, Toma\'s AI outperforms the rest—smarter, faster, and more reliable than any alternative.',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                ),

                const SizedBox(height: 60),

                // Features grid with custom icons
                _buildCustomFeaturesGrid(context, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomFeaturesGrid(BuildContext context, bool isMobile) {
    final features = [
      {
        'customIcon': _buildExpandIcon(),
        'title': 'End-to-End Automation',
        'description': 'Automate tasks completely, reducing reliance on frequent human intervention.',
      },
      {
        'customIcon': _buildHeadsetIcon(),
        'title': 'Natural & Fast Conversations',
        'description': 'Fine-tuned AI provides more natural interactions and the lowest response latency.',
      },
      {
        'customIcon': _buildPaperPlaneIcon(),
        'title': 'Omnichannel Communications',
        'description': 'Automate voice and SMS interactions, unlike single-channel competitor offerings.',
      },
      {
        'customIcon': _buildChainIcon(),
        'title': '1-Hour Support Included',
        'description': 'Rest assured you can roll out new technology with our dedicated support team.',
      },
      {
        'customIcon': _buildRocketIcon(),
        'title': 'Onboard With Ease',
        'description': 'Deploy quickly with minimal training, without disrupting your dealership\'s daily operations.',
      },
      {
        'customIcon': _buildBrainIcon(),
        'title': 'In-House AI Advantage',
        'description': 'Our proprietary AI allows deeper customization compared to other products.',
      },
    ];

    if (isMobile) {
      return Column(
        children: features.asMap().entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildCustomFeatureCard(entry.value, entry.key),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        // First row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCustomFeatureCard(features[0], 0)),
            const SizedBox(width: 16),
            Expanded(child: _buildCustomFeatureCard(features[1], 1)),
            const SizedBox(width: 16),
            Expanded(child: _buildCustomFeatureCard(features[2], 2)),
          ],
        ),
        const SizedBox(height: 16),
        // Second row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCustomFeatureCard(features[3], 3)),
            const SizedBox(width: 16),
            Expanded(child: _buildCustomFeatureCard(features[4], 4)),
            const SizedBox(width: 16),
            Expanded(child: _buildCustomFeatureCard(features[5], 5)),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomFeatureCard(Map<String, dynamic> feature, int index) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: feature['customIcon'] as Widget,
          ),

          const SizedBox(height: 24),

          // Title
          Text(
            feature['title'] as String,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            feature['description'] as String,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      duration: 600.ms,
      delay: (200 + (index * 100)).ms,
    ).slideY(begin: 0.2);
  }

  // Custom icon builders to match the original design
  Widget _buildExpandIcon() {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        child: Stack(
          children: [
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1.5),
                ),
                child: Icon(Icons.north_east, size: 6, color: Colors.black87),
              ),
            ),
            Positioned(
              bottom: 2,
              left: 2,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1.5),
                ),
                child: Icon(Icons.south_west, size: 6, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadsetIcon() {
    return const Center(
      child: Icon(
        Icons.headset_mic_outlined,
        size: 24,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPaperPlaneIcon() {
    return const Center(
      child: Icon(
        Icons.send_outlined,
        size: 24,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildChainIcon() {
    return const Center(
      child: Icon(
        Icons.link_outlined,
        size: 24,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildRocketIcon() {
    return const Center(
      child: Icon(
        Icons.rocket_launch_outlined,
        size: 24,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildBrainIcon() {
    return const Center(
      child: Icon(
        Icons.psychology_outlined,
        size: 24,
        color: Colors.black87,
      ),
    );
  }
}