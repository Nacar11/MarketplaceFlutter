// ignore_for_file: unused_import, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

// void errorSnackBar(BuildContext context, String message, String title) {
//   final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
//   final Color backgroundColor =
//       isDarkMode ? MPColors.darkContainer : MPColors.white;
//   final Color textColor =
//       isDarkMode ? MPColors.textWhite : MPColors.textPrimary;
//   Flushbar(
//     backgroundColor: backgroundColor,
//     titleColor: textColor,
//     messageColor: textColor,
//     icon: const Icon(Icons.error, color: Colors.red),
//     margin: const EdgeInsets.all(MPSizes.sm),
//     duration: const Duration(seconds: 1),
//     message: message,
//     flushbarPosition: FlushbarPosition.TOP,
//     borderRadius:
//         const BorderRadius.all(Radius.circular(MPSizes.borderRadiusMd)),
//     // backgroundGradient: const LinearGradient(
//     //   colors: [
//     //     Color.fromARGB(255, 255, 255, 255),
//     //     Color.fromARGB(255, 240, 186, 186)
//     //   ],
//     //   stops: [0.6, 1],
//     // ),
//     boxShadows: const [
//       BoxShadow(
//         color: Colors.black45,
//         offset: Offset(3, 3),
//         blurRadius: 3,
//       ),
//     ],
//     dismissDirection: FlushbarDismissDirection.VERTICAL,
//     forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
//     title: title,
//   ).show(context);
// }

// void successSnackBar(BuildContext context, String message, String title) {
//   final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
//   final Color backgroundColor =
//       isDarkMode ? MPColors.darkContainer : MPColors.white;
//   final Color textColor =
//       isDarkMode ? MPColors.textWhite : MPColors.textPrimary;
//   Flushbar(
//     backgroundColor: backgroundColor,
//     titleColor: textColor,
//     messageColor: textColor,
//     icon: const Icon(Iconsax.copy_success, color: Colors.green),
//     margin: const EdgeInsets.all(MPSizes.sm),
//     duration: const Duration(seconds: 2),
//     message: message,
//     flushbarPosition: FlushbarPosition.TOP,
//     borderRadius:
//         const BorderRadius.all(Radius.circular(MPSizes.borderRadiusMd)),
//     boxShadows: const [
//       BoxShadow(
//         color: Colors.black45,
//         offset: Offset(3, 3),
//         blurRadius: 3,
//       ),
//     ],
//     dismissDirection: FlushbarDismissDirection.VERTICAL,
//     forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
//     title: title,
//   ).show(context);
// }

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
