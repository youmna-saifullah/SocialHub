import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  AppColors._();

  // Primary Colors - Blue gradient theme
  static const Color primary = Color(0xFF4A90E2);
  static const Color primaryLight = Color(0xFF87CEEB);
  static const Color primaryDark = Color(0xFF2E5A8E);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF6C5CE7);
  static const Color secondaryLight = Color(0xFF9D8DF1);
  static const Color secondaryDark = Color(0xFF4A3DB8);
  
  // Gradient Colors (matching UI mockup)
  static const Color gradientStart = Color(0xFF87CEEB);
  static const Color gradientMiddle = Color(0xFFB8D4E8);
  static const Color gradientEnd = Color(0xFFE8D4F0);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color backgroundDark = Color(0xFF1A1A2E);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF16213E);
  
  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E2746);
  
  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);
  
  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  
  // Divider
  static const Color dividerLight = Color(0xFFE5E7EB);
  static const Color dividerDark = Color(0xFF374151);
  
  // Gradients
  static LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientMiddle, gradientEnd],
  );
  
  static LinearGradient get splashGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF87CEEB),
      Color(0xFFB8D4E8),
      Color(0xFFD4C8F0),
    ],
  );
  
  static LinearGradient get onboardingGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB8E0F0),
      Color(0xFFD4C8F0),
    ],
  );
  
  static LinearGradient get buttonGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary, primaryDark],
  );
}
