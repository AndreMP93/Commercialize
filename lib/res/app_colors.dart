import 'dart:ui';
import 'package:flutter/material.dart';


class AppColors{

  static const Color primaryColor = Color(0xff3154B1);
  static const Color lightBlue = Color(0xff0075CD);
  static const Color blue = Color(0xff02418F);
  static const Color darkBlue = Color(0xff29356A);
  static const Color white = Color(0xffffffff);
  static final customPrimaySwatch = MaterialColor(primaryColor.value, {
    50: primaryColor.withOpacity(0.1),
    100: primaryColor.withOpacity(0.2),
    200: primaryColor.withOpacity(0.3),
    300: primaryColor.withOpacity(0.4),
    400: primaryColor.withOpacity(0.5),
    500: primaryColor.withOpacity(0.6),
    600: primaryColor.withOpacity(0.7),
    700: primaryColor.withOpacity(0.8),
    800: primaryColor.withOpacity(0.9),
    900: primaryColor.withOpacity(1),
  });

  static final whitePrimarySwatch = MaterialColor(Colors.white.value, {
    50: Colors.white.withOpacity(0.1),
    100: Colors.white.withOpacity(0.2),
    200: Colors.white.withOpacity(0.3),
    300: Colors.white.withOpacity(0.4),
    400: Colors.white.withOpacity(0.5),
    500: Colors.white.withOpacity(0.6),
    600: Colors.white.withOpacity(0.7),
    700: Colors.white.withOpacity(0.8),
    800: Colors.white.withOpacity(0.9),
    900: Colors.white.withOpacity(1),
  });
}