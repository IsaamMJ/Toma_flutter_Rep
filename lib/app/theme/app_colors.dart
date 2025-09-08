import 'package:flutter/material.dart';

class AppColors {
  // Light theme colors to match Toma design
  static const Color primary = Color(0xFF000000); // Black for primary buttons
  static const Color background = Color(0xFFFFFFFF); // White background
  static const Color surface = Color(0xFFF8F9FA); // Very light gray for sections
  static const Color card = Color(0xFFFFFFFF); // White for cards

  // Text colors
  static const Color textPrimary = Color(0xFF000000); // Black for primary text
  static const Color textSecondary = Color(0xFF6B7280); // Gray for secondary text
  static const Color textMuted = Color(0xFF9CA3AF); // Lighter gray for muted text

  // Navigation specific
  static const Color navBackground = Color(0xFFFFFFFF); // White nav background
  static const Color navText = Color(0xFF111827); // Dark text for nav
  static const Color navBorder = Color(0xFFE5E7EB); // Light border

  // Button colors
  static const Color buttonPrimary = Color(0xFF000000); // Black primary button
  static const Color buttonSecondary = Color(0xFFFFFFFF); // White secondary button
  static const Color buttonOutline = Color(0xFFD1D5DB); // Gray outline

  // Accent colors
  static const Color accent = Color(0xFF3B82F6); // Blue accent
  static const Color accentHover = Color(0xFF2563EB); // Darker blue on hover
  static const Color success = Color(0xFF10B981); // Green
  static const Color error = Color(0xFFEF4444); // Red

  // Shadow colors - Enhanced for better visual hierarchy
  static const Color shadow = Color(0xFF000000); // Base shadow color for opacity usage
  static const Color shadowLight = Color(0x0A000000); // Very light shadow (4% opacity)
  static const Color shadowMedium = Color(0x14000000); // Medium shadow (8% opacity)
  static const Color shadowDark = Color(0x1F000000); // Darker shadow (12% opacity)

  // Enhanced gradients for modern UI
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF3F4F6), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Additional gradients for enhanced UI components
  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFFFAFBFC), Color(0xFFF8F9FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFCFCFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Utility colors for enhanced sections
  static const Color divider = Color(0xFFE5E7EB); // Light divider
  static const Color overlay = Color(0x80000000); // Semi-transparent overlay

  // Status colors for badges and indicators
  static const Color statusActive = Color(0xFF059669); // Active green
  static const Color statusPending = Color(0xFFD97706); // Pending orange
  static const Color statusInactive = Color(0xFF6B7280); // Inactive gray
}