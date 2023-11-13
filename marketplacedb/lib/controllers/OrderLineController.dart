// ignore_for_file: unused_import, file_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/models/OrderLineModel.dart';
import 'package:marketplacedb/models/shippingMethodModel.dart';

import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class OrderLineController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  var orderLineList = <OrderLineModel>[].obs;

  Future<String> addOrderline(String id) async {
    var data = {'product_item_id': id};
    try {
      isLoading.value = true;
      var response = await AuthInterceptor().post(
        Uri.parse('${url}addToCart'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      var jsonObject = jsonDecode(response.body);

      isLoading.value = false;
      return jsonObject['message'];
    } catch (e) {
      print(e);
      isLoading.value = false;
      return 'fail';
    }
  }

  Future<List<OrderLineModel>> getOrderLine() async {
    final response =
        await AuthInterceptor().get(Uri.parse("${url}getOrderLinesByID"));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('message')) {
        if (responseBody['message'] == 'Success') {
          final List<dynamic> result = responseBody['data'];
          final List<OrderLineModel> itemList =
              result.map((e) => OrderLineModel.fromJson(e)).toList();
          orderLineList.assignAll(itemList);
        } else if (responseBody['message'] == 'Error') {
          orderLineList.clear();
        }
      }

      isLoading.value = false;
    }
    return orderLineList;
  }

  Future<dynamic> deleteOrderline(int item_id) async {
    print(item_id);

    final response = await AuthInterceptor()
        .delete(Uri.parse("${url}deleteOrderLinesByID/$item_id"));

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete order line data');
    }
  }
}
