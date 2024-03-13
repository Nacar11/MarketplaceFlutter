import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ListItemPageController extends GetxController {
  static ListItemPageController get instance => Get.find();
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final selectedImages = List<File?>.filled(4, null).obs;

  @override
  void onInit() async {
    super.onInit();
    await sampleFunction();
  }

  void updateImagePreviewIndex(index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> sampleFunction() async {}

  // Future<void> displayBottomSheet(int index) async {
  //   await Get.bottomSheet(const PickImageBottomSheet());

  //   selectedImages.asMap().forEach((index, image) {
  //     print('Image $index: $image');
  //   });
  // }

  // Future<void> pickImage(int index, ImageSource source) async {
  //   try {
  //     final pickedFile = await ImagePicker().pickImage(source: source);
  //     if (pickedFile != null) {
  //       selectedImages[index] = File(pickedFile.path);
  //       print(selectedImages[index]);
  //       print('asd');
  //     }
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }
}
