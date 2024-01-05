import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MPHelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String capitalizeFirstLetter(String value) {
    if (value.isNotEmpty) {
      return value.substring(0, 1).toUpperCase() + value.substring(1);
    }
    return value;
  }
}
