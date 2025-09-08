// data/datasource/testimonial_data.dart
import 'package:flutter/material.dart';
import '../../../../app/assets/app_assets.dart';
class TestimonialStat {
  final String number;
  final String label;
  final Color color;

  const TestimonialStat({
    required this.number,
    required this.label,
    required this.color,
  });
}

class CarBrand {
  final String name;
  final String assetPath;

  const CarBrand({
    required this.name,
    required this.assetPath,
  });
}

class TestimonialData {
  // Video and testimonial info
  static const String videoUrl = 'https://www.youtube.com/watch?v=1-BBlH2hbQg';
  static const String videoThumbnail = AppAssets.testimonialVideo;
  static const String testimonialName = 'Chadwick Martin';
  static const String testimonialTitle = 'President, Martin Management Group';

  // Content
  static const String mainHeadline = 'Learn how Toma is generating more service revenue across all their locations around the country.';
  static const String resultsBadge = 'Results in 90 Days';

  // Statistics
  static const List<TestimonialStat> stats = [
    TestimonialStat(
      number: '9K+',
      label: 'Appointments\nBooked',
      color: Color(0xFF10B981),
    ),
    TestimonialStat(
      number: '\$2M+',
      label: 'Revenue\nGenerated',
      color: Color(0xFF8B5CF6),
    ),
    TestimonialStat(
      number: '22K+',
      label: 'Calls\nAutomated',
      color: Color(0xFF06B6D4),
    ),
  ];

  // Car brands
  static const List<CarBrand> carBrands = [
    CarBrand(name: 'subaru', assetPath: AppAssets.brandSubaru),
    CarBrand(name: 'nissan', assetPath: AppAssets.brandNissan),
    CarBrand(name: 'toyota', assetPath: AppAssets.brandToyota),
    CarBrand(name: 'hyundai', assetPath: AppAssets.brandHyundai),
    CarBrand(name: 'genesis', assetPath: AppAssets.brandGenesis),
    CarBrand(name: 'dodge', assetPath: AppAssets.brandDodge),
    CarBrand(name: 'audi', assetPath: AppAssets.brandAudi),
    CarBrand(name: 'kia', assetPath: AppAssets.brandKia),
    CarBrand(name: 'honda', assetPath: AppAssets.brandHonda),
  ];
}