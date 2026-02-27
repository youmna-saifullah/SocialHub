import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_themes.dart';

/// App theme configuration for light and dark modes
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.textPrimaryLight,
      onError: AppColors.white,
    ),
    textTheme: AppTextThemes.lightTextTheme,
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryLight,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTextThemes.lightTextTheme.titleLarge,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      elevation: 2,
      color: AppColors.cardLight,
      shadowColor: AppColors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextThemes.lightTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        textStyle: AppTextThemes.lightTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: AppTextThemes.lightTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      hintStyle: AppTextThemes.lightTextTheme.bodyMedium?.copyWith(
        color: AppColors.grey400,
      ),
      labelStyle: AppTextThemes.lightTextTheme.bodyMedium,
      prefixIconColor: AppColors.grey500,
      suffixIconColor: AppColors.grey500,
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey500,
      selectedLabelStyle: AppTextThemes.lightTextTheme.labelSmall,
      unselectedLabelStyle: AppTextThemes.lightTextTheme.labelSmall,
      elevation: 8,
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.grey100,
      selectedColor: AppColors.primaryLight,
      labelStyle: AppTextThemes.lightTextTheme.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: AppTextThemes.lightTextTheme.titleLarge,
      contentTextStyle: AppTextThemes.lightTextTheme.bodyMedium,
    ),
    
    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    
    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey800,
      contentTextStyle: AppTextThemes.lightTextTheme.bodyMedium?.copyWith(
        color: AppColors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerLight,
      thickness: 1,
      space: 1,
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.grey400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryLight;
        }
        return AppColors.grey200;
      }),
    ),
    
    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      titleTextStyle: AppTextThemes.lightTextTheme.bodyLarge,
      subtitleTextStyle: AppTextThemes.lightTextTheme.bodySmall,
    ),
  );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.textPrimaryDark,
      onError: AppColors.white,
    ),
    textTheme: AppTextThemes.darkTextTheme,
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryDark,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: AppTextThemes.darkTextTheme.titleLarge,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      elevation: 2,
      color: AppColors.cardDark,
      shadowColor: AppColors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppTextThemes.darkTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: AppColors.primaryLight, width: 1.5),
        textStyle: AppTextThemes.darkTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: AppTextThemes.darkTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey800,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      hintStyle: AppTextThemes.darkTextTheme.bodyMedium?.copyWith(
        color: AppColors.grey500,
      ),
      labelStyle: AppTextThemes.darkTextTheme.bodyMedium,
      prefixIconColor: AppColors.grey400,
      suffixIconColor: AppColors.grey400,
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surfaceDark,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey500,
      selectedLabelStyle: AppTextThemes.darkTextTheme.labelSmall,
      unselectedLabelStyle: AppTextThemes.darkTextTheme.labelSmall,
      elevation: 8,
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.grey800,
      selectedColor: AppColors.primaryDark,
      labelStyle: AppTextThemes.darkTextTheme.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    
    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: AppTextThemes.darkTextTheme.titleLarge,
      contentTextStyle: AppTextThemes.darkTextTheme.bodyMedium,
    ),
    
    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    
    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey700,
      contentTextStyle: AppTextThemes.darkTextTheme.bodyMedium?.copyWith(
        color: AppColors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.dividerDark,
      thickness: 1,
      space: 1,
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.grey500;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryDark;
        }
        return AppColors.grey700;
      }),
    ),
    
    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      titleTextStyle: AppTextThemes.darkTextTheme.bodyLarge,
      subtitleTextStyle: AppTextThemes.darkTextTheme.bodySmall,
    ),
  );
}
