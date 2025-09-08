// data/datasource/customer_testimonial_data.dart
import '../../../../app/assets/app_assets.dart';
class CustomerTestimonial {
  final String quote;
  final String name;
  final String title;
  final String company;
  final String location;
  final String results;
  final String dealershipType;
  final String imagePath;

  const CustomerTestimonial({
    required this.quote,
    required this.name,
    required this.title,
    required this.company,
    required this.location,
    required this.results,
    required this.dealershipType,
    required this.imagePath,
  });
}

class CustomerTestimonialData {
  static const String sectionTitle = 'Customer Success Stories';

  static const String sectionDescription =
      'See how dealerships are transforming their operations\nand achieving measurable results with our AI platform.';

  static const List<CustomerTestimonial> testimonials = [
    CustomerTestimonial(
      quote: 'Toma saves us 43 hours each month and is like adding a new team member. Our advisors can focus on in-person customers while AI handles routine inquiries perfectly.',
      name: 'Eric Stockton',
      title: 'Service Manager',
      company: 'Boulder Nissan',
      location: 'Boulder, CO',
      results: '43 hours saved monthly',
      dealershipType: 'Nissan',
      imagePath: AppAssets.customerNissan,
    ),
    CustomerTestimonial(
      quote: 'Response times improved dramatically and customer satisfaction is at an all-time high. Toma handles complex service questions better than we expected.',
      name: 'Johnson',
      title: 'Operations Manager',
      company: 'Metro Toyota',
      location: 'Seattle, WA',
      results: '85% faster response times',
      dealershipType: 'Toyota',
      imagePath: AppAssets.customerToyota,
    ),
    CustomerTestimonial(
      quote: 'Our team can focus on building relationships and closing deals while Toma automates routine tasks. The ROI has been exceptional.',
      name: 'Michael Chen',
      title: 'General Manager',
      company: 'Pacific Honda',
      location: 'San Diego, CA',
      results: '200% ROI in 6 months',
      dealershipType: 'Honda',
      imagePath: AppAssets.customerHonda,
    ),
  ];
}