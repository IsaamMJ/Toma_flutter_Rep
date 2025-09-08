import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_constants.dart';
import '../../app/theme/text_styles.dart';

// 1. Enhanced Navigation Bar Item Button
class NavBarItemButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isActive;
  final IconData? icon;

  const NavBarItemButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isActive = false,
    this.icon,
  });

  @override
  State<NavBarItemButton> createState() => _NavBarItemButtonState();
}

class _NavBarItemButtonState extends State<NavBarItemButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingS),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.accent.withOpacity(0.1)
                : _isHovered
                ? AppColors.navText.withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed != null ? () {
                HapticFeedback.lightImpact();
                widget.onPressed!();
              } : null,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 18,
                        color: widget.isActive ? AppColors.accent : AppColors.navText,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.title,
                      style: AppTextStyles.navItem.copyWith(
                        color: widget.isActive ? AppColors.accent : AppColors.navText,
                        fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. Enhanced Outlined Button with Icon
class OutlinedIconButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final bool isLoading;

  const OutlinedIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  @override
  State<OutlinedIconButton> createState() => _OutlinedIconButtonState();
}

class _OutlinedIconButtonState extends State<OutlinedIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isFullWidth ? double.infinity : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: OutlinedButton.icon(
          onPressed: widget.onPressed != null && !widget.isLoading ? () {
            HapticFeedback.selectionClick();
            widget.onPressed!();
          } : null,
          icon: widget.isLoading
              ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
            ),
          )
              : Icon(widget.icon, size: 18),
          label: Text(widget.label),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: BorderSide(
              color: widget.onPressed == null
                  ? AppColors.buttonOutline.withOpacity(0.5)
                  : AppColors.buttonOutline,
              width: 1.5,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: widget.isFullWidth ? 16 : 12,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: AppTextStyles.button,
            elevation: 0,
            shadowColor: Colors.transparent,
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.textPrimary.withOpacity(0.04);
                }
                if (states.contains(MaterialState.pressed)) {
                  return AppColors.textPrimary.withOpacity(0.08);
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}

// 3. Enhanced Primary Button
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isFullWidth = false,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isFullWidth ? double.infinity : null,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_animationController.value * 0.05),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: widget.onPressed != null && !widget.isLoading ? [
                  BoxShadow(
                    color: AppColors.buttonPrimary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : null,
              ),
              child: widget.icon != null
                  ? ElevatedButton.icon(
                onPressed: _getOnPressed(),
                icon: _buildIcon(),
                label: Text(widget.label),
                style: _buttonStyle,
              )
                  : ElevatedButton(
                onPressed: _getOnPressed(),
                style: _buttonStyle,
                child: _buildChild(),
              ),
            ),
          );
        },
      ),
    );
  }

  VoidCallback? _getOnPressed() {
    if (widget.onPressed == null || widget.isLoading) return null;
    return () {
      _animationController.forward().then((_) => _animationController.reverse());
      HapticFeedback.mediumImpact();
      widget.onPressed!();
    };
  }

  Widget _buildIcon() {
    if (widget.isLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    return Icon(widget.icon, size: 18);
  }

  Widget _buildChild() {
    if (widget.isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Text(widget.label),
        ],
      );
    }
    return Text(widget.label);
  }

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
    backgroundColor: widget.onPressed == null
        ? AppColors.buttonPrimary.withOpacity(0.6)
        : AppColors.buttonPrimary,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: widget.isFullWidth ? 16 : 14,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 0,
    shadowColor: Colors.transparent,
    textStyle: AppTextStyles.button.copyWith(fontWeight: FontWeight.w600),
  );
}