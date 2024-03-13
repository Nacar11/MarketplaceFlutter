import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class PickImageBottomSheet {
  static void openBottomSheet() {
    final dark = MPHelperFunctions.isDarkMode(
      Get.overlayContext!,
    );
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MPSizes.borderRadiusLg),
          topRight: Radius.circular(MPSizes.borderRadiusLg),
        ),
        child: Scaffold(
          backgroundColor: dark ? MPColors.darkerGrey : MPColors.white,
          body: MPCircularContainer(
            padding: const EdgeInsets.all(0),
            height: null,
            backgroundColor: dark ? MPColors.darkerGrey : MPColors.light,
            child: const Center(
              child: Text('asdad'),
            ),
          ),
        ),
      ),

      // MPCircularContainer(
      //   padding: const EdgeInsets.all(0),
      //   height: null,
      //   showBorder: true,
      //   borderColor: dark ? MPColors.borderPrimary : MPColors.black,
      //   backgroundColor: dark ? MPColors.darkerGrey : MPColors.light,
      //   child: const Center(
      //     child: Text('asdad'),
      //   ),
      // ),
    );
  }

  static closeBottomSheet() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
