import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPFullScreenOverlayLoader {
  static void openLoadingDialog() {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
                color: MPHelperFunctions.isDarkMode(Get.context!)
                    ? MPColors.darkerGrey.withOpacity(0.7)
                    : MPColors.white.withOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
                child: const Center(child: CircularProgressIndicator()))));
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
