import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';

class CustomerTestimonialSection extends StatefulWidget {
  const CustomerTestimonialSection({super.key});

  @override
  State<CustomerTestimonialSection> createState() => _CustomerTestimonialSectionState();
}

class _CustomerTestimonialSectionState extends State<CustomerTestimonialSection> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> testimonials = [
    {
      'quote': 'My experience with Toma has been 10 out of 10. It saves 43 hours of our advisors\' time on average each month so we can focus on in-person customers and drive revenue. It\'s almost like we added another member to our team.',
      'name': 'Eric Stockton',
      'title': 'Service Manager, Boulder Nissan',
      'company': 'Boulder Nissan',
      'avatar': 'assets/images/eric_avatar.jpg', // You'll need to add actual image
      'logo': 'assets/images/boulder_nissan_logo.png', // You'll need to add actual image
      'dealershipImage': 'assets/images/boulder_nissan_dealership.jpg', // You'll need to add actual image
    },
    {
      'quote': 'Toma has revolutionized how we handle customer service. Our response times have improved dramatically, and customer satisfaction scores are at an all-time high.',
      'name': 'Sarah Johnson',
      'title': 'Operations Manager, Metro Toyota',
      'company': 'Metro Toyota',
      'avatar': 'assets/images/sarah_avatar.jpg',
      'logo': 'assets/images/metro_toyota_logo.png',
      'dealershipImage': 'assets/images/metro_toyota_dealership.jpg',
    },
    {
      'quote': 'The automation capabilities of Toma have freed up our team to focus on what matters most - building relationships with our customers and closing deals.',
      'name': 'Michael Chen',
      'title': 'General Manager, Pacific Honda',
      'company': 'Pacific Honda',
      'avatar': 'assets/images/michael_avatar.jpg',
      'logo': 'assets/images/pacific_honda_logo.png',
      'dealershipImage': 'assets/images/pacific_honda_dealership.jpg',
    },
  ];

  void _nextTestimonial() {
    setState(() {
      currentIndex = (currentIndex + 1) % testimonials.length;
    });
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousTestimonial() {
    setState(() {
      currentIndex = (currentIndex - 1 + testimonials.length) % testimonials.length;
    });
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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
              // Header
              Text(
                'What Our Customers Say About Us',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),

              const SizedBox(height: 60),

              // Testimonial content
              SizedBox(
                height: isMobile ? 600 : 500,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: testimonials.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildTestimonialCard(testimonials[index], isMobile);
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Navigation controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Page indicators
                  Row(
                    children: testimonials.asMap().entries.map((entry) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == entry.key ? 12 : 8,
                        height: currentIndex == entry.key ? 12 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == entry.key
                              ? Colors.black87
                              : Colors.grey.shade300,
                        ),
                      ).animate().scale(
                        duration: 200.ms,
                        curve: Curves.easeInOut,
                      );
                    }).toList(),
                  ),

                  const SizedBox(width: 40),

                  // Navigation arrows
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _previousTestimonial,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _nextTestimonial,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mobile: Image first
          _buildDealershipImage(testimonial),
          const SizedBox(height: 32),
          // Mobile: Content below
          _buildTestimonialContent(testimonial, isMobile),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Desktop: Image on left
        Expanded(
          flex: 1,
          child: _buildDealershipImage(testimonial),
        ),
        const SizedBox(width: 60),
        // Desktop: Content on right
        Expanded(
          flex: 1,
          child: _buildTestimonialContent(testimonial, isMobile),
        ),
      ],
    );
  }

  Widget _buildDealershipImage(Map<String, dynamic> testimonial) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.withOpacity(0.8),
                Colors.blue.shade900.withOpacity(0.9),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Background pattern/texture
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1562141961-9316a0bb4b4b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Overlay gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Dealership branding
              Positioned(
                bottom: 40,
                left: 40,
                right: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dealership name
                    Text(
                      'Boulder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NISSAN',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.3);
  }

  Widget _buildTestimonialContent(Map<String, dynamic> testimonial, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quote
        Text(
          '"${testimonial['quote']}"',
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade800,
            height: 1.6,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms),

        const SizedBox(height: 32),

        // Customer info
        Row(
          children: [
            // Avatar
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Name and title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    testimonial['title'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Company logo placeholder
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BOULDER',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'NISSAN',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

        const SizedBox(height: 24),

        // Read case study link
        GestureDetector(
          onTap: () {
            // Handle case study navigation
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening case study...'),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                'Read Case Study',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.black87,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 600.ms),
      ],
    );
  }
}