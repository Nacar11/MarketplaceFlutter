import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MPHelperFunctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String currency(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: locale.toString(), name: 'PHP');
    return format.currencySymbol;
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

  static double expandedHeightTabBar(int nSubCategory) {
    if (nSubCategory <= 4) {
      return 400;
    } else if (nSubCategory <= 6) {
      return 500;
    } else if (nSubCategory <= 8) {
      return 700;
    } else {
      return 200;
    }
  }
}
