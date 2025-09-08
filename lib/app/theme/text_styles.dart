import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Hero section text with Times-style serif fonts
  static TextStyle heroTitle = GoogleFonts.crimsonText(  // Times-like serif font
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static TextStyle heroSubtitle = GoogleFonts.crimsonText(  // Times-like serif font
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Alternative hero styles with different serif fonts
  static TextStyle heroTitleLibreBaskerville = GoogleFonts.libreBaskerville(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static TextStyle heroTitlePlayfairDisplay = GoogleFonts.playfairDisplay(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  // Section headings
  static TextStyle sectionTitle = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Card titles
  static TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body text
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.4,
  );

  // Button text
  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Navigation
  static TextStyle navItem = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Responsive helpers
  static TextStyle heroTitleMobile = heroTitle.copyWith(fontSize: 32);
  static TextStyle heroSubtitleMobile = heroSubtitle.copyWith(fontSize: 16);
  static TextStyle sectionTitleMobile = sectionTitle.copyWith(fontSize: 28);

  // Helper methods for creating serif styles
  static TextStyle getSerifStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double height = 1.2,
  }) {
    return GoogleFonts.crimsonText(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}