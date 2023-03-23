import 'package:flutter/material.dart';
import 'app_colors.dart';
class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.customPrimaySwatch,
        // secondarySwatch: Colors.teal,
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
