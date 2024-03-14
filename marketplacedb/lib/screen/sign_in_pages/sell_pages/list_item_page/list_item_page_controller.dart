import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/VariantsModel.dart';
import 'package:marketplacedb/data/models/VariantsOptionsModel.dart';
import 'package:marketplacedb/data/models/products/product_category_model.dart';
import 'package:marketplacedb/data/models/products/product_type_model.dart';

class ListItemPageController extends GetxController {
  static ListItemPageController get instance => Get.find();
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final selectedImages = List<File?>.filled(6, null).obs;
  final selectedProductCategory1 = ProductCategoryModel().obs;
  final selectedProductCategory2 = ProductCategoryModel().obs;
  final selectedProductType = ProductTypeModel().obs;
  final itemDescription = TextEditingController().obs;
  final specifiedVariationList = <VariationModel>[].obs;
  final specifiedVariationOptionList = <VariationOptionModel>[].obs;
  final itemPrice = TextEditingController().obs;
  @override
  void onInit() async {
    super.onInit();
    await sampleFunction();
  }

  void updateImagePreviewIndex(index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> sampleFunction() async {}
}
