import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/loaders/animation_loader.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/device/device_utility.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPDialogContainerLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
                color: MPHelperFunctions.isDarkMode(Get.context!)
                    ? MPColors.dark
                    : MPColors.white,
                width: MPDeviceUtils.getScreenWidth() *
                    0.8, // Adjust the width as needed
                height: MPDeviceUtils.getScreenHeight() * 0.5,
                child: Column(
                  children: [
                    const SizedBox(height: 250),
                    MPAnimationLoaderWidget(text: text, animation: animation),
                  ],
                ))));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
