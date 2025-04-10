import 'package:flutter/material.dart';

class UiConstants {
  UiConstants._();

  // Padding and Margins
  static const double paddingZero = 0.0;
  static const double paddingExtraSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;

  static const EdgeInsets horizontalPaddingSmall =
      EdgeInsets.symmetric(horizontal: paddingSmall);
  static const EdgeInsets horizontalPaddingMedium =
      EdgeInsets.symmetric(horizontal: paddingMedium);
  static const EdgeInsets allPaddingMedium = EdgeInsets.all(paddingMedium);

  // Border Radius
  static const double borderRadiusNone = 0.0;
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;
  static const Radius circularRadiusMedium =
      Radius.circular(borderRadiusMedium);

  // Durations for Animations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Default Elevation
  static const double defaultElevation = 2.0;

// NOTE: Colors are generally better defined within the ThemeData in lib/core/theme/
// Only define specific, non-theme related colors here if absolutely necessary.
// static const Color specificErrorColor = Color(0xFFB00020);
}
