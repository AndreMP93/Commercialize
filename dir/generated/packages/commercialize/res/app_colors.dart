import 'dart:ui';
import 'package:flutter/material.dart';


class AppColors{
  static const Color azul0 = Color(0xff0075CD);
  static const Color primaryColor = Color(0xff3154B1);
  static const Color azul2 = Color(0xff02418F);
  static const Color azul3 = Color(0xff29356A);
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
}