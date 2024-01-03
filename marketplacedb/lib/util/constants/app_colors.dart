import 'package:flutter/material.dart';

class MPColors {
  Map<int, Color> color = {
    50: const Color.fromRGBO(4, 131, 184, .1),
    100: const Color.fromRGBO(4, 131, 184, .2),
    200: const Color.fromRGBO(4, 131, 184, .3),
    300: const Color.fromRGBO(4, 131, 184, .4),
    400: const Color.fromRGBO(4, 131, 184, .5),
    500: const Color.fromRGBO(4, 131, 184, .6),
    600: const Color.fromRGBO(4, 131, 184, .7),
    700: const Color.fromRGBO(4, 131, 184, .8),
    800: const Color.fromRGBO(4, 131, 184, .9),
    900: const Color.fromRGBO(4, 131, 184, 1),
  };

  // App Basic Colors
  static const Color primary = Color.fromARGB(255, 90, 158, 236);
  static const Color secondary = Color.fromARGB(255, 36, 73, 75);
  static const Color accent = Color(0xFF3FACAD);

  //Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  //Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = MPColors.white.withOpacity(0.1);

  //Button Colors
  static const Color buttonPrimary = Color.fromARGB(255, 116, 78, 255);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  //Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const white = Color(0xFFFFFFFF);
}
