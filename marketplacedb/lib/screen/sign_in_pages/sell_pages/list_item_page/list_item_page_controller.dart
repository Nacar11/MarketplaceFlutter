import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/variation_model.dart';
import 'package:marketplacedb/data/models/variation_option_model.dart';
import 'package:marketplacedb/data/models/products/product_category_model.dart';
import 'package:marketplacedb/data/models/products/product_type_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class ListItemPageController extends GetxController {
  static ListItemPageController get instance => Get.find();
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final selectedImages = List<File?>.filled(6, null).obs;

  final productCategoryMainList = <ProductCategoryModel>[].obs;

  final selectedFirstProductCategory = ProductCategoryModel().obs;
  final filteredProductCategoryFirstList = <ProductCategoryModel>[].obs;

  final selectedSecondProductCategory = ProductCategoryModel().obs;
  final filteredProductCategorySecondList = <ProductCategoryModel>[].obs;

  final selectedProductType = ProductTypeModel().obs;
  final productTypeMainList = <ProductTypeModel>[].obs;
  final filteredProductTypeList = <ProductTypeModel>[].obs;

  final itemDescription = TextEditingController().obs;

  final specifiedVariationList = <VariationModel>[].obs;
  final specifiedVariationOptionList = <VariationOptionModel>[].obs;
  final itemPrice = TextEditingController().obs;
  @override
  void onInit() async {
    super.onInit();
    await getProductCategories();
    await getProductTypes();
    await specifyInputFields();
  }

  void updateImagePreviewIndex(index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> getProductCategories() async {
    isLoading.value = true;
    try {
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}productCategories"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductCategoryModel> categoryList =
            result.map((e) => ProductCategoryModel.fromJson(e)).toList();

        productCategoryMainList.assignAll(categoryList);
        print(productCategoryMainList.length);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }

  Future<void> getProductTypes() async {
    isLoading.value = true;
    try {
      final response =
          await AuthInterceptor().get(Uri.parse("${MPConstants.url}product"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductTypeModel> categoryList =
            result.map((e) => ProductTypeModel.fromJson(e)).toList();

        productTypeMainList.assignAll(categoryList);
        print(productTypeMainList.length);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }

  Future<void> specifyInputFields() async {
    filteredProductCategoryFirstList.value = productCategoryMainList
        .where((category) => category.categoryId == null)
        .toList();
  }

  Future<void> onProductCategory1Selected(
      ProductCategoryModel productCategory) async {
    selectedFirstProductCategory.value = productCategory;

    filteredProductCategorySecondList.value = productCategoryMainList
        .where((category) =>
            category.categoryId == selectedFirstProductCategory.value.id)
        .toList();

    print('Items with filteredProductCategorySecondList :');
    for (var item in filteredProductCategorySecondList) {
      print('Category Name: ${item.categoryName}');
    }

    selectedSecondProductCategory.value = ProductCategoryModel();
    filteredProductTypeList.value = <ProductTypeModel>[];
    selectedProductType.value = ProductTypeModel();
  }

  Future<void> onProductCategory2Selected(
      ProductCategoryModel productCategory) async {
    selectedSecondProductCategory.value = productCategory;
    filteredProductTypeList.value = productTypeMainList
        .where((productType) => productType.categoryId == productCategory.id)
        .toList();
    selectedProductType.value = ProductTypeModel();

    try {
      isLoading.value = true;
      final response = await AuthInterceptor().get(Uri.parse(
          "${MPConstants.url}getVariantsByProductTypes/${productCategory.id}"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<VariationModel> categoryList =
            result.map((e) => VariationModel.fromJson(e)).toList();

        specifiedVariationList.assignAll(categoryList);
        print(specifiedVariationList[0].name);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }

  Future<void> onProductTypeSelected(ProductTypeModel productType) async {
    selectedProductType.value = productType;

    print('Category Name: ${selectedFirstProductCategory.value.categoryName}');
    print('Category Name: ${selectedSecondProductCategory.value.categoryName}');
    print('Category Name: ${selectedProductType.value.name}');
  }
}
