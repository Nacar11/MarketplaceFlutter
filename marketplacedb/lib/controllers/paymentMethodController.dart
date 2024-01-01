// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, await_only_futures, unused_import, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class PaymentMethodController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final storage = GetStorage();

  Future paymentRequest(var data) async {
    String jsonData = jsonEncode(data);
    var response = await http.post(
      Uri.parse('https://api.hit-pay.com/v1/payment-requests'),
      headers: {
        "Accept": "application/json",
        "X-BUSINESS-API-KEY":
            "8ad0104877e8dba756b985778403cfb0bb23d3e303c06dc22b9feea964084ab4",
        "X-REQUESTED-WITH": "XMLHttpRequest",
        "Content-Type": "application/json",
      },
      body: jsonData,
    );

    final responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('id')) {
      print(responseBody['url']);
      return responseBody['url'];
    }
  }
}
