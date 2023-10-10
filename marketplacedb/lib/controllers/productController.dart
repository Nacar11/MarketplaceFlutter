// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/constants/constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';

import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/models/ProductTypeModel.dart';

class ProductController extends GetxController {
  var productCategoryList = <ProductCategoryModel>[].obs;
  var productTypes = <ProductTypeModel>[].obs;
  final isLoading = false.obs;
  final token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProductCategories();
  }

  Future test() async {
    final response = await http.get(
      Uri.parse(url + 'test'),
    );
    print(response.body);
  }

  Future<List<ProductCategoryModel>> getProductCategories() async {
    final response = await http.get(Uri.parse(url + "product-category"));

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List

      final List<ProductCategoryModel> categoryList =
          result.map((e) => ProductCategoryModel.fromJson(e)).toList();

      productCategoryList.assignAll(categoryList);
    }
    return productCategoryList;
  }

  // Future<List<VariantsModel>> getVariantsByProductType() async {

  // }

  Future<List<ProductTypeModel>> getProductTypeByCategoryId(
      int categoryId) async {
    final response = await AuthInterceptor()
        .get(Uri.parse(url + "getProductTypesByCategory/$categoryId"));

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List

      final List<ProductTypeModel> productTypes = result
          .map((e) => ProductTypeModel.fromJson(e) as ProductTypeModel)
          .toList();
      return productTypes; // Return the productTypes when they are available
    } else {
      throw Exception('Failed to load product types'); // Handle the error case
    }
  }
}
