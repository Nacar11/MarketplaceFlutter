// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_cast, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/constants/constant.dart';
import 'package:marketplacedb/models/ProductItemModel.dart';
import 'package:marketplacedb/models/VariantsModel.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';
import 'dart:io';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/models/ProductTypeModel.dart';

class ProductController extends GetxController {
  var productCategoryList = <ProductCategoryModel>[].obs;
  var productItemList = <ProductItemModel>[].obs;

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

  Future<void> addListing({
    required List<File?> product_images,
    required Map<String, TextEditingController> controllers,
  }) async {
    try {
      isLoading.value = true;

      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse('${url}productItem'),
      );

      // Add the product images to the request
      for (var image in product_images) {
        if (image != null) {
          File _file = File(image.path);
          request.files.add(http.MultipartFile(
              'image', _file.readAsBytes().asStream(), _file.lengthSync(),
              filename: _file.path.split('/').last));
        }
      }

      // Add other fields to the request
      request.fields['product_id'] = controllers['productType']!.text;
      request.fields['price'] = controllers['price']!.text;
      request.fields['description'] = controllers['description']!.text;

      // final authInterceptor = AuthInterceptor();

      http.StreamedResponse response = await request.send();

      // Process the response if needed
      print(response);

      // print(response.body);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Future<List<ProductItemModel>> getProductItems() async {
    final response =
        await AuthInterceptor().get(Uri.parse(url + "productItems"));

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List

      final List<ProductItemModel> itemList =
          result.map((e) => ProductItemModel.fromJson(e)).toList();

      productItemList.assignAll(itemList);
    }
    return productItemList;
  }
}
