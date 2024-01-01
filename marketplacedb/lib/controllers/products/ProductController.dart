// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_cast, unused_import, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/data/models/VariantsModel.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';
import 'dart:io';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductTypeModel.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  var productCategoryList = <ProductCategoryModel>[].obs;
  var productItemList = <ProductItemModel>[].obs;

  var productTypes = <ProductTypeModel>[].obs;
  int? productTypeID;
  final isLoading = false.obs;
  final token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProductCategories();
    // getProductTypeByCategoryId(productTypeID!);
  }

  Future test() async {
    final response = await http.get(
      Uri.parse(url + 'test'),
    );
    print(response.body);
  }

  Future<List<ProductCategoryModel>> getProductCategories() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(url + "product-category"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductCategoryModel> categoryList =
            result.map((e) => ProductCategoryModel.fromJson(e)).toList();

        productCategoryList.assignAll(categoryList);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error scenarios here as needed
    } finally {
      isLoading.value =
          false; // Set isLoading to false when the operation completes
    }
    return productCategoryList;
  }

  // Future<List<VariantsModel>> getVariantsByProductType() async {

  // }

  Future<void> getProductTypeByCategoryId() async {
    isLoading.value = true;
    try {
      final response = await AuthInterceptor()
          .get(Uri.parse(url + "getProductTypesByCategory/$productTypeID"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductTypeModel> productTypesData = result
            .map((e) => ProductTypeModel.fromJson(e) as ProductTypeModel)
            .toList();

        productTypes.assignAll(productTypesData);
        print(productTypes);
      } else {
        throw Exception('Failed to load product types');
      }
    } catch (e) {
      print('Error fetching product types: $e');
      // Handle error scenarios here as needed
    } finally {
      isLoading.value = false;
    }
  }
}
