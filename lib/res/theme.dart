import 'package:flutter/material.dart';
import 'app_colors.dart';
class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.customPrimaySwatch,
        primaryColorDark: AppColors.darkBlue
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get whiteTheme {
    return ThemeData(
      primaryColor: AppColors.white,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.whitePrimarySwatch,
          primaryColorDark: AppColors.primaryColor,
        accentColor: AppColors.darkBlue
      ),
      scaffoldBackgroundColor: AppColors.primaryColor,
    );
  }
}
