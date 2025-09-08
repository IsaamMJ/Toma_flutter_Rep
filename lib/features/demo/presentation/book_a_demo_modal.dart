import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../app/theme/app_constants.dart';

class BookDemoModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: true,
      builder: (context) => const _BookDemoModalContent(),
    );
  }
}

class _BookDemoModalContent extends StatefulWidget {
  const _BookDemoModalContent();

  @override
  State<_BookDemoModalContent> createState() => _BookDemoModalContentState();
}

class _BookDemoModalContentState extends State<_BookDemoModalContent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final isMobile = screenSize.width < 768;
    final isSmallMobile = screenSize.width < 480;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(screenSize.width),
                vertical: _getVerticalPadding(screenSize.height, isMobile),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: _getMaxWidth(screenSize.width),
                  maxHeight: screenSize.height * (isMobile ? 0.95 : 0.85),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: isMobile ? 20 : 40,
                      offset: Offset(0, isMobile ? 10 : 20),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                  child: _buildLayout(isMobile, isTablet, isSmallMobile),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < 480) return 16;
    if (screenWidth < 768) return 20;
    return 40;
  }

  double _getVerticalPadding(double screenHeight, bool isMobile) {
    if (isMobile) {
      return screenHeight < 700 ? 20 : 40;
    }
    return 60;
  }

  double _getMaxWidth(double screenWidth) {
    if (screenWidth < 768) return double.infinity;
    if (screenWidth < 1024) return 800;
    return 1100;
  }

  Widget _buildLayout(bool isMobile, bool isTablet, bool isSmallMobile) {
    if (isMobile) {
      // Mobile: Show only the right panel (form)
      return _buildMobileLayout(isSmallMobile);
    } else if (isTablet) {
      return _buildTabletLayout();
    }
    return _buildDesktopLayout();
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildLeftPanel(false, false)),
        Expanded(flex: 2, child: _buildRightPanel(false, false)),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildLeftPanel(true, false)),
        Expanded(flex: 1, child: _buildRightPanel(true, false)),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallMobile) {
    // Mobile: Only show the right panel (form)
    return Container(
      color: Colors.white,
      child: _buildRightPanel(true, isSmallMobile),
    );
  }

  Widget _buildLeftPanel(bool isCompact, bool isSmallMobile) {
    final titleFontSize = isSmallMobile ? 24.0 : isCompact ? 28.0 : 36.0;
    final padding = isSmallMobile ? 20.0 : isCompact ? 24.0 : 40.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        image: DecorationImage(
          image: NetworkImage(
              'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Ik0wIDBoMjAwdjIwMEgweiIgZmlsbD0iIzFBMUExQSIvPgo8cGF0aCBkPSJNNTAgNTBMMTUwIDE1ME01MCA1MEwxNTAgNTAiIHN0cm9rZT0iIzMzMzMzMyIgc3Ryb2tlLXdpZHRoPSIwLjUiIG9wYWNpdHk9IjAuMyIvPgo8L3N2Zz4='
          ),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Automate Your Dealership Operations',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
              if (!isCompact)
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: isSmallMobile ? 12 : 20),
          Text(
            'Get started and join dealerships achieving these results every month:',
            style: TextStyle(
              fontSize: isSmallMobile ? 14 : 16,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          SizedBox(height: isSmallMobile ? 20 : 32),
          Expanded(
            child: isCompact && !isSmallMobile
                ? _buildCompactSteps()
                : _buildFullSteps(isSmallMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildFullSteps(bool isSmallMobile) {
    return ListView(
      children: [
        _buildStep(
          icon: Icons.access_time,
          title: 'Step 1: Never Miss a Call',
          description: 'Our AI responds instantly, 24/7, answering every call',
          isCompact: isSmallMobile,
        ),
        SizedBox(height: isSmallMobile ? 12 : 20),
        _buildStep(
          icon: Icons.calendar_today,
          title: 'Step 2: Book More Service',
          description: 'Schedule 180+ additional appointments monthly',
          isCompact: isSmallMobile,
        ),
        SizedBox(height: isSmallMobile ? 12 : 20),
        _buildStep(
          icon: Icons.attach_money,
          title: 'Step 3: Grow Revenue',
          description: 'Generate an additional \$30,000 in monthly revenue',
          highlightText: '\$30,000',
          highlightColor: const Color(0xFF4CAF50),
          isCompact: isSmallMobile,
        ),
        SizedBox(height: isSmallMobile ? 12 : 20),
        _buildStep(
          icon: Icons.group,
          title: 'Step 4: Free Your Team',
          description: 'Reclaim 40+ hours of staff time monthly',
          isCompact: isSmallMobile,
        ),
      ],
    );
  }

  Widget _buildCompactSteps() {
    return Column(
      children: [
        _buildCompactStep(Icons.access_time, 'Never Miss a Call', '24/7 AI responses'),
        _buildCompactStep(Icons.calendar_today, '180+ More Appointments', 'Monthly bookings'),
        _buildCompactStep(Icons.attach_money, '\$30,000 Extra Revenue', 'Per month', isHighlighted: true),
        _buildCompactStep(Icons.group, '40+ Hours Saved', 'Staff time monthly'),
      ],
    );
  }

  Widget _buildCompactStep(IconData icon, String title, String subtitle, {bool isHighlighted = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isHighlighted ? const Color(0xFF4CAF50) : Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String description,
    String? highlightText,
    Color? highlightColor,
    bool isCompact = false,
  }) {
    final padding = isCompact ? 16.0 : 20.0;
    final titleSize = isCompact ? 14.0 : 16.0;
    final descSize = isCompact ? 12.0 : 14.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isCompact ? 16 : 20,
            ),
          ),
          SizedBox(width: isCompact ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: isCompact ? 4 : 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: descSize,
                      color: Colors.white70,
                      height: 1.3,
                    ),
                    children: highlightText != null
                        ? _buildHighlightedText(description, highlightText, highlightColor!)
                        : [TextSpan(text: description)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(String text, String highlight, Color color) {
    final parts = text.split(highlight);
    final spans = <TextSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: highlight,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ));
      }
    }
    return spans;
  }

  Widget _buildRightPanel(bool isCompact, bool isSmallMobile) {
    final padding = isSmallMobile ? 20.0 : isCompact ? 24.0 : 40.0;
    final titleSize = isSmallMobile ? 22.0 : 28.0;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: isCompact ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Schedule a Demo',
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ),
              // Always show close button for mobile since left panel is hidden
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF666666),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Automate your operations like these dealerships:',
            style: TextStyle(
              fontSize: isSmallMobile ? 12 : 14,
              color: const Color(0xFF666666),
            ),
          ),
          SizedBox(height: isSmallMobile ? 16 : 24),
          _buildDealershipLogos(isSmallMobile),
          SizedBox(height: isSmallMobile ? 20 : 32),
          Text(
            'Toma is accepting meetings with dealerships only.',
            style: TextStyle(
              fontSize: isSmallMobile ? 11 : 13,
              color: const Color(0xFF666666),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Please email partners@toma.com for all other inquiries.',
            style: TextStyle(
              fontSize: isSmallMobile ? 11 : 13,
              color: const Color(0xFF666666),
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: isSmallMobile ? 16 : 24),
          Text(
            'Company Email*',
            style: TextStyle(
              fontSize: isSmallMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your business email',
              hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: isSmallMobile ? 14 : 16,
              ),
              filled: true,
              fillColor: const Color(0xFFF8F8F8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF1A1A1A), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isSmallMobile ? 14 : 16,
              ),
            ),
            style: TextStyle(fontSize: isSmallMobile ? 14 : 16),
          ),
          SizedBox(height: isSmallMobile ? 16 : 24),
          SizedBox(
            width: double.infinity,
            height: isSmallMobile ? 46 : 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleBookDemo,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1A),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : Text(
                'Next',
                style: TextStyle(
                  fontSize: isSmallMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (isCompact) SizedBox(height: isSmallMobile ? 16 : 20),
        ],
      ),
    );
  }

  Widget _buildDealershipLogos(bool isSmallMobile) {
    final fontSize = isSmallMobile ? 12.0 : 14.0;
    final height = isSmallMobile ? 32.0 : 40.0;
    final spacing = isSmallMobile ? 8.0 : 12.0;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Bergey\'s',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'HARVEY',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'HUDSON',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleBookDemo() async {
    if (_emailController.text.isEmpty || !_isValidEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid business email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    HapticFeedback.lightImpact();
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demo request submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}