import 'package:flutter/material.dart';
import 'package:marketplacedb/util/theme/custom_themes/text_theme.dart';

class MPAppTheme {
  MPAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 116, 78, 255),
      scaffoldBackgroundColor: Colors.white,
      textTheme: MPTextTheme.lightTextTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: const Color.fromARGB(255, 116, 78, 255),
      scaffoldBackgroundColor: Colors.black,
      textTheme: MPTextTheme.darkTextTheme);
}
