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
import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class ListItemPageController extends GetxController {
  static ListItemPageController get instance => Get.find();

  MPLocalStorage localStorage = MPLocalStorage();
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

  final itemPrice = TextEditingController().obs;
  final itemDescription = TextEditingController().obs;

  final specifiedVariationList = <VariationModel>[].obs;
  final selectedVariationOptionList = <VariationOptionModel>[].obs;

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
          "${MPConstants.url}getVariationsByProductTypes/${productCategory.id}"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<VariationModel> categoryList =
            result.map((e) => VariationModel.fromJson(e)).toList();

        specifiedVariationList.assignAll(categoryList);
        selectedVariationOptionList.assignAll(List.generate(
            specifiedVariationList.length, (_) => VariationOptionModel()));
        print('length of selectedVariationOptionList');
        print(selectedVariationOptionList.length);
        print('Names of selectedVariationOptionList instances:');
        for (var option in selectedVariationOptionList) {
          print(option.value);
        }
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
  }

  Future<void> onVariationOptionSelected(
      VariationOptionModel variationOption, int variationIndex) async {
    selectedVariationOptionList[variationIndex] = variationOption;
  }

  Future<int> imageUpload() async {
    isLoading.value = true;
    final uri = Uri.parse('${MPConstants.url}addListing');
    final request = http.MultipartRequest('POST', uri);

    final token = localStorage.readData('token');

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    headers.forEach((key, value) {
      request.headers[key] = value;
    });

    for (int i = 0; i < selectedImages.length; i++) {
      final file = selectedImages[i];

      if (file != null) {
        request.files.add(http.MultipartFile(
          'File$i',
          http.ByteStream.fromBytes(file.readAsBytesSync()),
          file.lengthSync(),
          filename: 'image.jpg',
        ));
      }
    }

    request.fields['product_id'] = selectedProductType.value.id.toString();
    request.fields['price'] = itemPrice.value.toString();
    request.fields['description'] = itemDescription.value.text;
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final jsonResponse = json.decode(response.body);

      if (jsonResponse['message'] == 'success') {
        print(jsonResponse['data']['id'].runtimeType);
        final productConfigurationResponse = await addProductConfiguration(
          jsonResponse['data']['id'],
        );
        if (productConfigurationResponse == 1) {
          print('File uploaded successfully');
          isLoading.value = false;
          return 1;
        } else {
          print('Error on Product Configuration');

          isLoading.value = false;
          return 0;
        }
      } else {
        print('File upload failed');

        isLoading.value = false;
        return 0;
      }
    } catch (e) {
      print('Error uploading file: $e');

      isLoading.value = false;
      return 0;
    }
  }

  Future<int> addProductConfiguration(int productItemID) async {
    isLoading.value = true;

    for (final variationOption in selectedVariationOptionList) {
      final variationOptionID = variationOption.id;

      var data = {
        'product_item_id': productItemID.toString(),
        'variation_option_id': variationOptionID.toString(),
      };
      await AuthInterceptor().post(
          Uri.parse("${MPConstants.url}productConfiguration"),
          body: data);
    }
    isLoading.value = false;
    return 1;
  }
}
