// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_cast, unused_import, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

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
import 'package:get_storage/get_storage.dart';

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
    isLoading.value = true;
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

  Future<int> imageUpload(List<File?> imageFiles,
      Map<String, TextEditingController> controllers) async {
    isLoading.value = true;
    final uri =
        Uri.parse('${url}addListing'); // Replace with your Laravel endpoint URL
    final request = http.MultipartRequest('POST', uri);
    final storage = GetStorage();
    final token = storage.read('token');

    final headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer $token', // Replace with your authentication token
    };

    headers.forEach((key, value) {
      request.headers[key] = value;
    });

    for (int i = 0; i < imageFiles.length; i++) {
      final file = imageFiles[i];

      if (file != null) {
        request.files.add(http.MultipartFile(
          'File$i', // This should match the parameter name in your Laravel controller
          http.ByteStream.fromBytes(file.readAsBytesSync()),
          file.lengthSync(),
          filename: 'image.jpg', // You can change the filename if needed
        ));
      }
    }

    request.fields['product_id'] = controllers['productType']!.text;
    request.fields['price'] = controllers['price']!.text;
    request.fields['description'] = controllers['description']!.text;
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        print('File uploaded successfully');
        isLoading.value = false;
        return 1;
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

  Future<List<ProductItemModel>> getProductItems() async {
    final response =
        await AuthInterceptor().get(Uri.parse(url + "productItems"));

    // print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List
      print(result);
      final List<ProductItemModel> itemList = result
          .map((e) => ProductItemModel.fromJson(e) as ProductItemModel)
          .toList();

      productItemList.assignAll(itemList);
    }
    return productItemList;
  }

  Future<List<ProductItemModel>> getProductItemsByProductType(
      {required int productType}) async {
    final response = await AuthInterceptor()
        .get(Uri.parse(url + "getProductItemsByProductType/$productType"));

    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List
      print(result);
      final List<ProductItemModel> itemList = result
          .map((e) => ProductItemModel.fromJson(e) as ProductItemModel)
          .toList();

      productItemList.assignAll(itemList);
    }
    return productItemList;
  }

  Future<List<ProductItemModel>> getProductItemsByUser() async {
    final response =
        await AuthInterceptor().get(Uri.parse(url + "getProductItemsByUser"));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List
      print(result);
      final List<ProductItemModel> itemList = result
          .map((e) => ProductItemModel.fromJson(e) as ProductItemModel)
          .toList();

      productItemList.assignAll(itemList);
    }
    return productItemList;
  }

  Future<dynamic> deleteListing(int item_id) async {
    print(item_id);

    final response = await AuthInterceptor()
        .delete(Uri.parse("${url}deleteListingByID/${item_id}"));

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete item data');
    }
  }
}
