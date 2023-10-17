import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplacedb/controllers/imageProvider.dart';
import 'dart:io';

class ImageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  XFile? images;
  File? listimagepath;
  var selectedFileCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectMultipleImages() async {
    images = await picker.pickImage(source: ImageSource.gallery);
    if (images != null) {
      print('images not null');

      listimagepath = File(images!.path);
    } else {
      print('no image selected');
    }
  }

  void uploadImage() async {
    print(listimagepath);
    await ImageUploadProvider().imageUpload(listimagepath!);
  }
}
