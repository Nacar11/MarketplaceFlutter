import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class AccountSettingsPageController extends GetxController {
  static AccountSettingsPageController get static => Get.find();
  final isLoading = false.obs;
  final themeSwitch = true.obs;

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
}
