// data/datasource/why_toma_data.dart
import 'package:flutter/material.dart';

class WhyTomaFeature {
  final IconData icon;
  final String title;
  final String description;

  const WhyTomaFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class WhyTomaData {
  static const String sectionLabel = 'Why Toma?';
  static const String mainTitle = 'There\'s No Competition';
  static const String subtitle =
      'Built for dealerships that refuse to settle, Toma\'s AI outperforms the rest—smarter, faster, and more reliable than any alternative.';

  static const List<WhyTomaFeature> features = [
    WhyTomaFeature(
      icon: Icons.all_out_outlined,
      title: 'End-to-End Automation',
      description: 'Automate tasks completely, reducing reliance on frequent human intervention.',
    ),
    WhyTomaFeature(
      icon: Icons.headset_mic_outlined,
      title: 'Natural & Fast Conversations',
      description: 'Fine-tuned AI provides more natural interactions and the lowest response latency.',
    ),
    WhyTomaFeature(
      icon: Icons.send_outlined,
      title: 'Omnichannel Communications',
      description: 'Automate voice and SMS interactions, unlike single-channel competitor offerings.',
    ),
    WhyTomaFeature(
      icon: Icons.link_outlined,
      title: '1-Hour Support Included',
      description: 'Rest assured you can roll out new technology with our dedicated support team.',
    ),
    WhyTomaFeature(
      icon: Icons.rocket_launch_outlined,
      title: 'Onboard With Ease',
      description: 'Deploy quickly with minimal training, without disrupting your dealership\'s daily operations.',
    ),
    WhyTomaFeature(
      icon: Icons.psychology_outlined,
      title: 'In-House AI Advantage',
      description: 'Our proprietary AI allows deeper customization compared to other products.',
    ),
  ];
}