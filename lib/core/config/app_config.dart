// =============================================================================
// Task 6.1: API Configuration for JSONPlaceholder
// Task 6.4: Image Upload Configuration
// =============================================================================

/// App configuration for different environments
class AppConfig {
  static const String appName = 'SocialHub';
  static const String appVersion = '1.0.0';
  
  // Task 6.1: API Configuration - JSONPlaceholder public API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Task 6.3 Step 11: Pagination configuration
  static const int defaultPageSize = 10;
  static const int initialPage = 1;
  
  // Task 6.4: Image Upload Configuration
  static const String imageUploadUrl = 'https://api.imgbb.com/1/upload';
  static const String imageUploadApiKey = 'YOUR_IMGBB_API_KEY'; // Replace with actual key
  
  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String onboardingKey = 'onboarding_completed';
  static const String userKey = 'current_user';
  static const String tokenKey = 'auth_token';
}
