import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App text styles using Google Fonts
class AppTextThemes {
  AppTextThemes._();

  static TextTheme get lightTextTheme => TextTheme(
    // Display styles
    displayLarge: GoogleFonts.poppins(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
      letterSpacing: -0.25,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),
    
    // Headline styles
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    
    // Title styles
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.1,
    ),
    
    // Body styles
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.4,
    ),
    
    // Label styles
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.1,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.5,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.5,
    ),
  );

  static TextTheme get darkTextTheme => TextTheme(
    // Display styles
    displayLarge: GoogleFonts.poppins(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
      letterSpacing: -0.25,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    ),
    
    // Headline styles
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    
    // Title styles
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.1,
    ),
    
    // Body styles
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryDark,
      letterSpacing: 0.4,
    ),
    
    // Label styles
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.1,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.5,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryDark,
      letterSpacing: 0.5,
    ),
  );
}
