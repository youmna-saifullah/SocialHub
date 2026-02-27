import 'package:flutter/material.dart';

// =============================================================================
// Task 6.2 Step 10: Show SnackBar with success/error message
// =============================================================================

/// Extension methods on BuildContext for easier access to common utilities
extension ContextExtensions on BuildContext {
  // Media Query
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;
  
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  
  // Navigation (using Navigator - for GoRouter use context.go/push)
  NavigatorState get navigator => Navigator.of(this);
  
  // Snackbar
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  
  // Task 6.2 Step 10: Show SnackBar with success/error message
  void showSnackBar(String message, {bool isError = false}) {
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  // Task 6.2 Step 10: Show success SnackBar
  void showSuccessSnackBar(String message) {
    showSnackBar(message, isError: false);
  }
  
  // Task 6.2 Step 10: Show error SnackBar
  void showErrorSnackBar(String message) {
    showSnackBar(message, isError: true);
  }
  
  // Focus
  void unfocus() => FocusScope.of(this).unfocus();
}
