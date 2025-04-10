class AssetConstants {
  AssetConstants._(); // Private constructor

  // Base Paths (adjust according to your `pubspec.yaml`)
  static const String _imagesBasePath = 'assets/images';
  static const String _iconsBasePath = 'assets/icons';
  static const String _lottieBasePath = 'assets/lottie';

  // Specific Image Assets
  static const String appLogo = '$_imagesBasePath/logo.png';
  static const String onboarding1 = '$_imagesBasePath/onboarding_1.png';
  static const String placeholderUser = '$_imagesBasePath/placeholder_user.jpg';

  // Specific Icon Assets
  static const String homeIcon =
      '$_iconsBasePath/home_icon.svg'; // Example using SVG
  static const String settingsIcon = '$_iconsBasePath/settings_icon.png';

  // Specific Lottie Assets
  static const String loadingAnimation = '$_lottieBasePath/loading.json';
  static const String successAnimation = '$_lottieBasePath/success.json';
}
