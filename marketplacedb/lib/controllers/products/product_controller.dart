import 'package:get/get.dart';

import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/data/models/product/product_category_model.dart';
import 'package:marketplacedb/data/models/product/product_type_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final productCategoryList = <ProductCategoryModel>[].obs;
  final subCategoryList = <ProductCategoryModel>[].obs;
  final productTypes = <ProductTypeModel>[].obs;
  final isLoading = false.obs;
  int? subCategoryId;

  @override
  void onInit() async {
    super.onInit();
    await getProductCategories();
    subCategoriesInit(1);
  }

  void subCategoriesInit(int counter) {
    subCategoryList.value = productCategoryList[counter].children!;
  }

  Future<void> getProductCategories() async {
    isLoading.value = true;
    try {
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getOrganizedProductCategories"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductCategoryModel> categoryList =
            result.map((e) => ProductCategoryModel.fromJson(e)).toList();

        productCategoryList.assignAll(categoryList);
        print(productCategoryList.length);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProductTypesByCategoryId(int categoryId) async {
    isLoading.value = true;
    try {
      final response = await AuthInterceptor().get(
          Uri.parse("${MPConstants.url}getProductTypesByCategory/$categoryId"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductTypeModel> productTypesData =
            result.map((e) => ProductTypeModel.fromJson(e)).toList();
        productTypes.assignAll(productTypesData);
        isLoading.value = false;
      } else {
        throw Exception('Failed to load product types');
      }
    } catch (e) {
      print('Error fetching product types: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
