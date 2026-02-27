/// All asset paths in one place
class AppAssets {
  AppAssets._();

  // Base paths
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';
  static const String _animationsPath = 'assets/animations';

  // Images
  static const String logo = '$_imagesPath/logo.png';
  static const String onboarding1 = '$_imagesPath/onboarding1.png';
  static const String onboarding2 = '$_imagesPath/onboarding2.png';
  static const String onboarding3 = '$_imagesPath/onboarding3.png';
  static const String placeholder = '$_imagesPath/placeholder.png';
  static const String avatar = '$_imagesPath/avatar.png';
  static const String emptyState = '$_imagesPath/empty_state.png';
  static const String errorState = '$_imagesPath/error_state.png';

  // Icons
  static const String googleIcon = '$_iconsPath/google.svg';
  static const String homeIcon = '$_iconsPath/home.svg';
  static const String postsIcon = '$_iconsPath/posts.svg';
  static const String usersIcon = '$_iconsPath/users.svg';
  static const String profileIcon = '$_iconsPath/profile.svg';
  static const String settingsIcon = '$_iconsPath/settings.svg';

  // Animations
  static const String loadingAnimation = '$_animationsPath/loading.json';
  static const String successAnimation = '$_animationsPath/success.json';
  static const String errorAnimation = '$_animationsPath/error.json';
}
