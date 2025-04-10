import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  // Font Family
  static const String fontFamily = 'NotoSansJP';

  // Text Color
  static const primary = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontFamily: fontFamily,
  );
  static const black = TextStyle(
    color: AppColors.textBlack,
    fontSize: 16,
    fontFamily: fontFamily,
  );
}

extension AppTextStyleExt on TextStyle {
  // Size
  TextStyle get s12 => copyWith(fontSize: 12);

  TextStyle get s14 => copyWith(fontSize: 14);

  TextStyle get s16 => copyWith(fontSize: 16);

  TextStyle get s20 => copyWith(fontSize: 20);

  TextStyle get s24 => copyWith(fontSize: 24);

  TextStyle get s30 => copyWith(fontSize: 30);

  TextStyle get s32 => copyWith(fontSize: 32);

  // Material size
  TextStyle get bodyTiny => copyWith(fontSize: 10);

  TextStyle get bodySmall => copyWith(fontSize: 12);

  TextStyle get bodyMedium => copyWith(fontSize: 14);

  TextStyle get bodyLarge => copyWith(fontSize: 16);

  TextStyle get titleSmall => copyWith(fontSize: 14);

  TextStyle get titleMedium => copyWith(fontSize: 16);

  TextStyle get titleLarge => copyWith(fontSize: 22);

  TextStyle get headlineSmall => copyWith(fontSize: 24);

  TextStyle get headlineMedium => copyWith(fontSize: 28);

  TextStyle get headlineLarge => copyWith(fontSize: 32);

  // Weight
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);

  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);

  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
}
