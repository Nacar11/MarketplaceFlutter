import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPAlertDialog {
  static void openDialog(BuildContext context, String title, String content,
      List<Widget> actions) {
    final dark = MPHelperFunctions.isDarkMode(context);
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
            backgroundColor: dark ? MPColors.darkerGrey : MPColors.white,
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            content:
                Text(content, style: Theme.of(context).textTheme.bodyMedium!),
            actions: actions));
  }

  static popDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
