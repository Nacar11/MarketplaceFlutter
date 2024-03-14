import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplacedb/common/styles/border_radius.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class PickImageBottomSheet {
  static void openBottomSheet(List<File?> selectedImages, int index) {
    final dark = MPHelperFunctions.isDarkMode(
      Get.overlayContext!,
    );
    Get.bottomSheet(
      ClipRRect(
        borderRadius: MPBorderRadiusStyle.bottomSheetBorderRadius,
        child: MPCircularContainer(
          height: MPHelperFunctions.screenHeight() * 0.25,
          backgroundColor: dark ? MPColors.darkerGrey : MPColors.light,
          child: Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MPOutlinedButton(
                  onPressed: () async {
                    selectedImages[index] =
                        await PickImageBottomSheet.pickImage(
                            ImageSource.camera);
                    Get.back();
                  },
                  icon: Icon(Icons.camera_alt_outlined,
                      color: dark ? MPColors.light : MPColors.dark),
                  text: "Take a Photo",
                ),
                const SizedBox(height: MPSizes.spaceBtwItems),
                MPOutlinedButton(
                    onPressed: () async {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    icon: Icon(Iconsax.gallery_add,
                        color: dark ? MPColors.light : MPColors.dark),
                    text: "Pick from Gallery"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static closeBottomSheet() {
    Navigator.of(Get.overlayContext!).pop();
  }

  static Future<File> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return File('');
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return File('');
    }
  }
}
