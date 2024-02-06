// ignore_for_file: file_names, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_cast, unused_import, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/data/models/VariantsModel.dart';
import 'package:marketplacedb/data/models/VariantsOptionsModel.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';
import 'dart:io';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductTypeModel.dart';
import 'package:get_storage/get_storage.dart';

class ProductItemController extends GetxController {
  static ProductItemController get instance => Get.find();
  var productItemList = <ProductItemModel>[].obs;
  var productItemListUser = <ProductItemModel>[].obs;
  var productItemListByProductType = <ProductItemModel>[].obs;
  final singleProductItemDetail = ProductItemModel().obs;
  int? productTypeID;
  final isLoading = false.obs;
  final token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProductItemsByUser();
    getProductItems();
  }

  Future<void> getSingleProductItemDetail(int itemId) async {
    isLoading.value = true;
    final response =
        await AuthInterceptor().get(Uri.parse(url + "productItem/$itemId"));
    var jsonObject = jsonDecode(response.body);
    if (jsonObject['message'] == 'success') {
      singleProductItemDetail.value =
          ProductItemModel.fromJson(jsonObject['data']);
      print(singleProductItemDetail.value);
    }

    isLoading.value = false;
  }

  Future<void> getProductItems() async {
    isLoading.value = true;
    final response =
        await AuthInterceptor().get(Uri.parse(url + "productItems"));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);

      final List<ProductItemModel> itemList = result
          .map((e) => ProductItemModel.fromJson(e) as ProductItemModel)
          .toList();

      productItemList.assignAll(itemList);
      print(productItemList[2].description);
    }
    isLoading.value = false;
  }

  Future<int> imageUpload(
      List<File?> imageFiles,
      Map<String, TextEditingController> controllers,
      Map<int, VariationOptionModel> selectedOptions) async {
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

      if (jsonResponse['message'] == 'success') {
        print('asda');
        print(jsonResponse['data']['id'].runtimeType);
        final productConfigurationResponse = await addProductConfiguration(
          selectedOptions,
          jsonResponse['data']['id'],
        );
        if (productConfigurationResponse == 1) {
          print('asdasdasa');
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

  Future<int> addProductConfiguration(
      Map<int, VariationOptionModel> selectedOptions, int productItemID) async {
    isLoading.value = true;

    for (final entry in selectedOptions.entries) {
      final variationOptionID = entry.value.id;

      var data = {
        'product_item_id': productItemID.toString(),
        'variation_option_id': variationOptionID.toString(),
      };
      await AuthInterceptor()
          .post(Uri.parse(url + "product-configuration"), body: data);
    }
    isLoading.value = false;
    return 1;
  }

  Future<List<ProductItemModel>> getProductItemsByUser() async {
    isLoading.value = true;
    final response =
        await AuthInterceptor().get(Uri.parse(url + "getProductItemsByUser"));

    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> result = jsonDecode(response.body);
      // print(result);
      final List<ProductItemModel> itemList = result
          .map((e) => ProductItemModel.fromJson(e) as ProductItemModel)
          .toList();

      productItemListUser.assignAll(itemList);
    }
    isLoading.value = false;
    return productItemListUser;
  }

  Future<dynamic> deleteListing(int item_id) async {
    print(item_id);

    final response = await AuthInterceptor()
        .delete(Uri.parse("${url}deleteListingByID/$item_id"));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete item data');
    }
  }

  Future<List<ProductItemModel>> getProductItemsByProductType(
      int productTypeID) async {
    isLoading.value = true;
    final response = await AuthInterceptor()
        .get(Uri.parse(url + "getProductItemsByProductType/$productTypeID"));

    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(response.body); // Parse JSON as a List

      final List<ProductItemModel> itemList = result
          .map((e) => ProductItemModel.fromJson(e) as ProductItemModel)
          .toList();

      productItemListByProductType.assignAll(itemList);
    }
    isLoading.value = false;
    return productItemListByProductType;
  }
}
