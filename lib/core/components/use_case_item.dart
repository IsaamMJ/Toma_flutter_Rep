import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';

class UseCaseItem extends StatefulWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const UseCaseItem({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<UseCaseItem> createState() => _UseCaseItemState();
}

class _UseCaseItemState extends State<UseCaseItem> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverChange(bool isHovered) {
    setState(() => _isHovered = isHovered);
    isHovered ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHoverChange(true),
            onExit: (_) => _onHoverChange(false),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(12),
                splashColor: AppColors.buttonPrimary.withOpacity(0.1),
                highlightColor: AppColors.buttonPrimary.withOpacity(0.05),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.all(widget.isSelected ? 20 : 16),
                  decoration: _buildDecoration(),
                  child: Row(
                    children: [
                      _buildIndicator(),
                      const SizedBox(width: 16),
                      Expanded(child: _buildContent()),
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

  BoxDecoration _buildDecoration() {
    if (widget.isSelected) {
      return BoxDecoration(
        color: AppColors.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buttonPrimary.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonPrimary.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );
    }

    return BoxDecoration(
      color: _isHovered ? AppColors.surface.withOpacity(0.3) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      border: _isHovered ? Border.all(color: AppColors.buttonOutline.withOpacity(0.2)) : null,
    );
  }

  Widget _buildIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 4,
      height: widget.isSelected ? 24 : 20,
      decoration: BoxDecoration(
        color: widget.isSelected
            ? AppColors.buttonPrimary
            : _isHovered
            ? AppColors.buttonPrimary.withOpacity(0.4)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow(),
        _buildDescription(),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Expanded(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              color: widget.isSelected || _isHovered
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: widget.isSelected ? 17 : 16,
            ),
            child: Text(widget.title),
          ),
        ),
        AnimatedRotation(
          duration: const Duration(milliseconds: 150),
          turns: widget.isSelected ? 0.25 : 0,
          child: Icon(
            Icons.chevron_right,
            size: 20,
            color: widget.isSelected ? AppColors.buttonPrimary : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: widget.isSelected
          ? Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          widget.description,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
            fontSize: 15,
          ),
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}