// ignore_for_file: unused_import, file_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/models/shippingMethodModel.dart';

import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class ShippingController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  var shippingmethodList = <ShippingMethodModel>[].obs;

  // Future<List<ShippingMethodModel>> getShippingMethods() async {

  //   final response =
  //       await AuthInterceptor().get(Uri.parse("${url}getShippingMethods"));
  //   if (response.statusCode == 200) {
  //     final responseBody = jsonDecode(response.body);

  //     if (responseBody.containsKey('message')) {
  //       if (responseBody['message'] == 'Success') {
  //         final List<dynamic> result = responseBody['data'];
  //         final List<ShippingMethodModel> itemList =
  //             result.map((e) => ShippingMethodModel.fromJson(e)).toList();
  //         shippingmethodList.assignAll(itemList);
  //       } else if (responseBody['message'] == 'Error') {
  //         shippingmethodList.clear();
  //       }
  //     }

  //     isLoading.value = false;
  //   }
  //   return shippingmethodList;
  // }

  Future<List<ShippingMethodModel>> getShippingMethods() async {
    final response =
        await AuthInterceptor().get(Uri.parse("${url}getShippingMethods"));
    if (response.statusCode == 200) {
      isLoading.value = false;
      final List<dynamic> result = jsonDecode(response.body);
      final List<ShippingMethodModel> itemList =
          result.map((e) => ShippingMethodModel.fromJson(e)).toList();

      shippingmethodList.assignAll(itemList);
    }

    return shippingmethodList;
  }
}
