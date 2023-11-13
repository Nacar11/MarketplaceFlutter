// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, unused_import

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/models/BillingAddressModel.dart';
import 'package:marketplacedb/models/CountryModel.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddress.dart';

class UserController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  var countryList = <CountryModel>[].obs;
  var addressList = <BillingAddressModel>[].obs;

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

  Future<List<CountryModel>> getCountries() async {
    final response = await AuthInterceptor().get(Uri.parse("${url}countries"));
    if (response.statusCode == 200) {
      isLoading.value = false;
      final List<dynamic> result = jsonDecode(response.body);
      final List<CountryModel> itemList =
          result.map((e) => CountryModel.fromJson(e)).toList();

      countryList.assignAll(itemList);
    }

    return countryList;
  }

  Future<List<BillingAddressModel>> getAddress() async {
    final response = await AuthInterceptor().get(Uri.parse("${url}getAddress"));
    if (response.statusCode == 200) {
      isLoading.value = false;
      final List<dynamic> result = jsonDecode(response.body);
      final List<BillingAddressModel> itemList =
          result.map((e) => BillingAddressModel.fromJson(e)).toList();

      addressList.assignAll(itemList);
    }

    return addressList;
  }

  Future<dynamic> addBillingAddress(data) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor().post(
        Uri.parse('${url}addAddress'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      print(response.body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      return false;
    }
  }
}
