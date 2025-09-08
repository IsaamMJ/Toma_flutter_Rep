import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../app/theme/app_constants.dart';

class LoginModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: AppColors.overlay,
      barrierDismissible: true,
      builder: (context) => const _LoginModalContent(),
    );
  }
}

class _LoginModalContent extends StatefulWidget {
  const _LoginModalContent();

  @override
  State<_LoginModalContent> createState() => _LoginModalContentState();
}

class _LoginModalContentState extends State<_LoginModalContent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _isEmailLogin = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppConstants.animationMedium,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

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
                horizontal: isSmallScreen ? 16.0 : 60.0,
                vertical: isSmallScreen && keyboardHeight > 0
                    ? 20.0
                    : screenHeight * 0.1,
              ),
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 440,
                    maxHeight: screenHeight * 0.9,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                        isSmallScreen ? AppConstants.radiusL : AppConstants.radiusXL
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow.withOpacity(0.15),
                        blurRadius: 32,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(isSmallScreen),
                      _buildContent(isSmallScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          isSmallScreen ? 20 : 32,
          isSmallScreen ? 20 : 28,
          isSmallScreen ? 16 : 24,
          0
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(
              'Sign in to Toma',
              style: AppTextStyles.getSerifStyle(
                fontSize: isSmallScreen ? 24.0 : 32.0,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: const Icon(Icons.close, size: 20, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Already onboarded? Continue to your account using your business email.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: isSmallScreen ? 14 : null,
            ),
          ),
          SizedBox(height: isSmallScreen ? 24 : 32),

          if (!_isEmailLogin) ...[
            _buildSignInButton(
              icon: Container(
                width: 20, height: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://developers.google.com/identity/images/g-logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              text: 'Sign in with Google',
              onTap: _handleGoogleSignIn,
            ),
            const SizedBox(height: 16),
            _buildSignInButton(
              icon: const Icon(Icons.mail_outline, size: 20, color: AppColors.textPrimary),
              text: 'Sign in with Email/Password',
              onTap: () {
                setState(() => _isEmailLogin = true);
                HapticFeedback.lightImpact();
              },
            ),
          ] else
            _buildEmailForm(isSmallScreen),

          SizedBox(height: isSmallScreen ? 16 : 24),
          _buildFooterText(isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildSignInButton({
    required Widget icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(color: AppColors.navBorder),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  text,
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm(bool isSmallScreen) {
    return Column(
      children: [
        _buildTextField(
          controller: _emailController,
          hintText: 'Business email',
          prefixIcon: const Icon(Icons.mail_outline, color: AppColors.textMuted),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted),
          obscureText: !_isPasswordVisible,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            child: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: AppColors.textMuted,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: isSmallScreen ? 48 : 52,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleEmailSignIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
              width: 20, height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              'Sign In',
              style: AppTextStyles.button.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => setState(() => _isEmailLogin = false),
          child: Text(
            '← Back to sign in options',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.navBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
      ),
    );
  }

  Widget _buildFooterText(bool isSmallScreen) {
    final textStyle = AppTextStyles.bodySmall.copyWith(
      fontSize: isSmallScreen ? 12 : null,
    );
    final linkStyle = textStyle.copyWith(
      color: AppColors.accent,
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: textStyle,
            children: [
              const TextSpan(text: 'First time logging in? Create your account using your '),
              TextSpan(text: 'business email here', style: linkStyle),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: textStyle,
            children: [
              const TextSpan(text: 'Are you a dealership owner or manager? '),
              TextSpan(text: 'Email our support team', style: linkStyle),
              const TextSpan(text: ' to get started.'),
            ],
          ),
        ),
      ],
    );
  }

  void _handleGoogleSignIn() async {
    HapticFeedback.lightImpact();
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign In - Integration needed')),
    );
  }

  void _handleEmailSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    HapticFeedback.lightImpact();
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email Sign In - Integration needed')),
    );
  }
}