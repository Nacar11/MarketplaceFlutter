import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/data/models/product_variations/variation_model.dart';
import 'package:marketplacedb/data/models/product_variations/variation_option_model.dart';
import 'package:marketplacedb/data/models/products/product_category_model.dart';
import 'package:marketplacedb/data/models/products/product_type_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

class ListItemPageController extends GetxController {
  static ListItemPageController get instance => Get.find();
  NavigationController navigationController = NavigationController.instance;
  MPLocalStorage localStorage = MPLocalStorage();
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final variationListWidgetLoading = false.obs;
  final selectedImages = List<File?>.filled(6, null).obs;

  final productCategoryMainList = <ProductCategoryModel>[].obs;

  final selectedFirstProductCategory = ProductCategoryModel().obs;
  final filteredProductCategoryFirstList = <ProductCategoryModel>[].obs;

  final selectedSecondProductCategory = ProductCategoryModel().obs;
  final filteredProductCategorySecondList = <ProductCategoryModel>[].obs;

  final selectedProductType = ProductTypeModel().obs;
  final productTypeMainList = <ProductTypeModel>[].obs;
  final filteredProductTypeList = <ProductTypeModel>[].obs;

  GlobalKey<FormState> itemPriceKey = GlobalKey<FormState>();
  GlobalKey<FormState> itemDescriptionKey = GlobalKey<FormState>();
  final isItemPriceValid = false.obs;
  final isItemDescriptionValid = false.obs;
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

    specifiedVariationList.clear();
    selectedSecondProductCategory.value = ProductCategoryModel();
    filteredProductTypeList.clear();
    selectedProductType.value = ProductTypeModel();
  }

  Future<void> onProductCategory2Selected(
      ProductCategoryModel productCategory) async {
    selectedSecondProductCategory.value = productCategory;
    filteredProductTypeList.value = productTypeMainList
        .where((productType) => productType.categoryId == productCategory.id)
        .toList();
    selectedProductType.value = ProductTypeModel();
    specifiedVariationList.clear();
    selectedVariationOptionList.clear();
    try {
      variationListWidgetLoading.value = true;
      isLoading.value = true;
      final response = await AuthInterceptor().get(Uri.parse(
          "${MPConstants.url}getVariationsByProductCategory/${productCategory.id}"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<VariationModel> categoryList =
            result.map((e) => VariationModel.fromJson(e)).toList();

        specifiedVariationList.assignAll(categoryList);
        selectedVariationOptionList.assignAll(List.generate(
            specifiedVariationList.length, (_) => VariationOptionModel()));
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
      variationListWidgetLoading.value = false;
    }
  }

  Future<void> onProductTypeSelected(ProductTypeModel productType) async {
    selectedProductType.value = productType;
  }

  Future<void> onVariationOptionSelected(
      VariationOptionModel variationOption, int variationIndex) async {
    selectedVariationOptionList[variationIndex] = variationOption;
  }

  Future<void> imageUpload() async {
    try {
      MPAlertLoaderDialog.openLoadingDialog();
      isLoading.value = true;
      final uri = Uri.parse('${MPConstants.url}addListingAndConfiguration');
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
      request.fields['price'] = (double.parse(itemPrice.value.text)).toString();
      request.fields['description'] = itemDescription.value.text;

      for (String item in selectedVariationOptionList
          .map((option) => option.id.toString())
          .toList()) {
        request.files
            .add(http.MultipartFile.fromString('variation_option_ids[]', item));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final jsonResponse = json.decode(response.body);
      MPAlertLoaderDialog.stopLoading();
      if (jsonResponse['message'] == 'success') {
        navigationController.index.value = 0;
        Get.offAll(() => const Navigation());
        getSnackBar(MPTexts.productListed, 'Successful Listing', true);
      } else {
        getSnackBar('Please Try Again', 'Error on Listing', true);
      }
    } catch (e) {
      print('Error creating item file: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> addProductConfiguration(int productItemID) async {
  //   try {
  //     isLoading.value = true;
  //     for (final variationOption in selectedVariationOptionList) {
  //       final variationOptionID = variationOption.id;
  //       var data = {
  //         'product_item_id': productItemID.toString(),
  //         'variation_option_id': variationOptionID.toString(),
  //       };
  //       final response = await AuthInterceptor().post(
  //           Uri.parse("${MPConstants.url}productConfiguration"),
  //           body: data);
  //       final jsonResponse = json.decode(response.body);
  //       if (jsonResponse['message'] == 'success') {
  //         await addProductConfiguration(
  //           jsonResponse['data']['id'],
  //         );
  //         print('File Successfully uploaded with Product Configurations');
  //       } else {
  //         print('File upload failed');
  //         isLoading.value = false;
  //       }
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //   }
  // }
}
