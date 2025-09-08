import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';

class RealCallsSection extends StatefulWidget {
  const RealCallsSection({super.key});

  @override
  State<RealCallsSection> createState() => _RealCallsSectionState();
}

class _RealCallsSectionState extends State<RealCallsSection>
    with TickerProviderStateMixin {
  late AnimationController _scrollController;
  late Animation<double> _scrollAnimation;

  final List<Map<String, dynamic>> callData = [
    {
      'name': 'Someone from',
      'location': 'Chandler',
      'service': 'Tire Rotation',
      'rating': '2/5',
      'duration': '1m 55s',
      'timeAgo': '8 hours ago',
      'status': 'Resolved',
      'isResolved': true,
    },
    {
      'name': 'Someone from',
      'location': 'Boston',
      'service': 'Recall Service',
      'rating': '3/5',
      'duration': '1m 18s',
      'timeAgo': '14 hours ago',
      'status': 'Resolved',
      'isResolved': true,
    },
    {
      'name': 'Someone from',
      'location': 'Phoenix',
      'service': 'Oil Change',
      'rating': '4/5',
      'duration': '2m 42s',
      'timeAgo': '2 hours ago',
      'status': 'Unresolved',
      'isResolved': false,
    },
    {
      'name': 'Someone from',
      'location': 'Miami',
      'service': 'Brake Service',
      'rating': '5/5',
      'duration': '3m 12s',
      'timeAgo': '6 hours ago',
      'status': 'Resolved',
      'isResolved': true,
    },
    {
      'name': 'Someone from',
      'location': 'Seattle',
      'service': 'Engine Check',
      'rating': '4/5',
      'duration': '2m 05s',
      'timeAgo': '1 hour ago',
      'status': 'Resolved',
      'isResolved': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _scrollAnimation = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: _scrollController,
      curve: Curves.linear,
    ));

    _scrollController.repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade50,
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.getMaxWidth(context),
            ),
            padding: ResponsiveHelper.getHorizontalPadding(context),
            child: Column(
              children: [
                Text(
                  'Real Calls Happening Now',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.isMobile(context) ? 28 : 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),

                const SizedBox(height: 16),

                Text(
                  'Make AI work for you by automating repetitive tasks that your\ndealership encounters every single day.',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.isMobile(context) ? 16 : 18,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Scrolling call notifications
          SizedBox(
            height: ResponsiveHelper.isMobile(context) ? 180 : 200,
            child: AnimatedBuilder(
              animation: _scrollAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    _scrollAnimation.value * MediaQuery.of(context).size.width * 2,
                    0,
                  ),
                  child: Row(
                    children: [
                      ...callData.map((call) => _buildCallCard(call, context)),
                      ...callData.map((call) => _buildCallCard(call, context)), // Duplicate for seamless loop
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallCard(Map<String, dynamic> call, BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: isMobile ? 280 : 320,
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone,
                  color: Colors.green.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          call['name'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          call['location'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'just called about',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Service name
          Text(
            'a ${call['service']}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Status row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: call['isResolved'] ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      call['isResolved'] ? Icons.check : Icons.close,
                      size: 12,
                      color: call['isResolved'] ? Colors.green.shade600 : Colors.red.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      call['status'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: call['isResolved'] ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 12,
                      color: Colors.orange.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      call['rating'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Duration and time
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: Colors.grey.shade500,
              ),
              const SizedBox(width: 4),
              Text(
                call['duration'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                call['timeAgo'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}