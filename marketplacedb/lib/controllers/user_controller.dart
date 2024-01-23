// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/data/models/BillingAddressModel.dart';
import 'package:marketplacedb/data/models/CountryModel.dart';
import 'package:marketplacedb/data/models/UserModel.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_screen_controller.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddress.dart';

HomeScreenController home_screen_controller = HomeScreenController.static;

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final isLoading = false.obs;
  final token = ''.obs;
  final userHasAddressValue = false.obs;
  var countryList = <CountryModel>[].obs;
  var addressList = <BillingAddressModel>[].obs;
  final userData = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await userDataInit();
    userHasAddress();
    getCountries();
  }

  Future<void> userDataInit() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}getUserData"));
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      Map<String, dynamic> userDataJson = jsonObject['userData'];

      UserModel userModel = UserModel.fromJson(userDataJson);
      userData.value = userModel;

      home_screen_controller.preferredSubCategory.value =
          userData.value.gender!;
      print('----------------------------');
      print(userData.value.gender);
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      isLoading.value = true;
      var response = await AuthInterceptor().get(
        Uri.parse('${url}logout'),
        headers: {
          'Accept': 'application/json',
        },
      );

      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;

      if (jsonObject['message'] == 'Logged out Successfully') {
        localStorage.clearAll();
        Get.offAll(() => const FrontPage(logoutMessage: true));
      } else {
        print(jsonObject['message']);
        errorSnackBar(
          context,
          'Error Logging Out, Please Try Again',
          'error',
        );
        localStorage.clearAll();
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future userHasAddress() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}userHasAddress"));
      var jsonObject = jsonDecode(response.body);

      userHasAddressValue.value = jsonObject['message'];

      isLoading.value = false;
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
      final responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('message')) {
        if (responseBody['message'] == 'Success') {
          final List<dynamic> result = responseBody['data'];
          final List<BillingAddressModel> itemList =
              result.map((e) => BillingAddressModel.fromJson(e)).toList();
          addressList.assignAll(itemList);
        } else if (responseBody['message'] == 'Error') {
          addressList.clear();
        }
      }
      isLoading.value = false;
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
