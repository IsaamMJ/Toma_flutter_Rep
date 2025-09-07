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

  // Shadow colors
  static const Color shadowLight = Color(0x0A000000); // Very light shadow
  static const Color shadowMedium = Color(0x14000000); // Medium shadow

  // Gradients (updated for light theme)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF3F4F6), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}