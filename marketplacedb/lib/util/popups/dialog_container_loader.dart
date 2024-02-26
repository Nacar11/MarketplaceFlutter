import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPAlertLoaderDialog {
  static void openLoadingDialog() {
    final dark = MPHelperFunctions.isDarkMode(
      Get.overlayContext!,
    );
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: dark ? MPColors.darkerGrey : MPColors.white,
        content: const SizedBox(
          width: MPSizes.productImageSize,
          height: MPSizes.productImageSize,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
