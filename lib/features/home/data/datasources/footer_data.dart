// data/datasource/footer_data.dart
import 'package:flutter/material.dart';

class SocialMediaItem {
  final IconData icon;
  final String label;
  final String? url;

  const SocialMediaItem({
    required this.icon,
    required this.label,
    this.url,
  });
}

class FooterData {
  static const String logoText = 'toma';
  static const String tagline = 'AI Automation Platform for Automotive Dealerships.';
  static const String signupText = 'Sign up and watch us build.';
  static const String emailPlaceholder = 'your@dealership.com';
  static const String submitButtonText = 'Submit';
  static const String copyright = '2025 Toma, Inc. All rights reserved.';

  static const List<String> navigationLinks = [
    'Contact',
    'Company',
    'Case Studies',
    'Blog',
    'Careers',
  ];

  static const List<SocialMediaItem> socialMedia = [
    SocialMediaItem(
      icon: Icons.close,
      label: 'X (Twitter)',
      url: 'https://twitter.com/toma',
    ),
    SocialMediaItem(
      icon: Icons.business,
      label: 'LinkedIn',
      url: 'https://linkedin.com/company/toma',
    ),
    SocialMediaItem(
      icon: Icons.play_arrow,
      label: 'YouTube',
      url: 'https://youtube.com/@toma',
    ),
  ];

  static const List<String> bottomLinks = [
    'Trust Center',
    'Privacy Policy',
    'Terms',
  ];
}