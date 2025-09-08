import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../demo/presentation/book_a_demo_modal.dart';

class MeetEmployeeSection extends StatelessWidget {
  const MeetEmployeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: ResponsiveHelper.isMobile(context)
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildContentSection(context)),
        const SizedBox(width: 60),
        Expanded(child: _buildImageSection()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildImageSection(),
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

        Text(
          'Toma acts as a virtual team member, tirelessly working around the clock to handle tasks with speed and precision.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey.shade600,
            height: 1.6,
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideX(begin: -0.3),

        const SizedBox(height: 40),
        _buildBenefitsList(),
        const SizedBox(height: 40),
        _buildTalkToTomaButton(context),
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
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  entry.value,
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
          delay: (400 + (entry.key * 150)).ms,
        ).slideX(begin: -0.2);
      }).toList(),
    );
  }

  Widget _buildTalkToTomaButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => BookDemoModal.show(context), // ✅ Opens modal

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Talk to Toma',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 12),
            Container(
              width: 20,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 2, height: 12, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                  Container(width: 2, height: 16, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                  Container(width: 2, height: 10, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                  Container(width: 2, height: 14, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'assets/aiemp.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'AI Employee',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: 1000.ms, delay: 200.ms).scale(begin: const Offset(0.9, 0.9));
  }
}
