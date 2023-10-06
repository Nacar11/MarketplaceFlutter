// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  Future UserHasAddress() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}userHasAddress"));
      var jsonObject = jsonDecode(response.body);

      if (jsonObject['message'] == 'false') {
        isLoading.value = false;
        return false;
      } else {
        isLoading.value = false;
        return true;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
