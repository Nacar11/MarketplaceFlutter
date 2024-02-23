import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

SnackbarController getSnackBar(String message, String title, bool isSuccess) {
  final bool isDarkMode = MPHelperFunctions.isDarkMode(Get.context!);
  final Color backgroundColor =
      isDarkMode ? MPColors.darkContainer : MPColors.white;
  final Color textColor =
      isDarkMode ? MPColors.textWhite : MPColors.textPrimary;
  final IconData iconData = isSuccess ? Iconsax.copy_success : Icons.error;
  final Color iconColor = isSuccess ? Colors.green : Colors.red;

  return Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 2),
    backgroundColor: backgroundColor,
    colorText: textColor,
    icon: Icon(iconData, color: iconColor),
    margin: const EdgeInsets.all(MPSizes.sm),
    borderRadius: MPSizes.borderRadiusMd,
    snackPosition: SnackPosition.TOP,
  );
}

SnackbarController warningSnackBar(String title) {
  final bool isDarkMode = MPHelperFunctions.isDarkMode(Get.context!);
  final Color backgroundColor =
      isDarkMode ? MPColors.darkContainer : MPColors.white;
  final Color textColor =
      isDarkMode ? MPColors.textWhite : MPColors.textPrimary;

  return Get.snackbar(
    title,
    '',
    duration: const Duration(seconds: 3),
    isDismissible: true,
    backgroundColor: backgroundColor,
    colorText: textColor,
    icon: const Icon(Iconsax.warning_2, color: Colors.orange),
    margin: const EdgeInsets.all(MPSizes.sm),
    borderRadius: MPSizes.borderRadiusMd,
    snackPosition: SnackPosition.TOP,
  );
}
