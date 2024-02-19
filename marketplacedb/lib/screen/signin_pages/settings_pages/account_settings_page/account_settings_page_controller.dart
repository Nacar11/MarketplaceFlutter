import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/popups/full_screen_loader.dart';

class AccountSettingsPageController extends GetxController {
  static AccountSettingsPageController get static => Get.find();
  final isLoading = false.obs;
  final themeSwitch = true.obs;

  Future<void> logout(BuildContext context) async {
    try {
      isLoading.value = true;
      MPFullScreenLoader.openLoadingDialog(
          'Logging Out...', AnimationsUtils.loading);
      var response = await AuthInterceptor().get(
        Uri.parse('${url}logout'),
        headers: {
          'Accept': 'application/json',
        },
      );

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['message'] == 'Logged out Successfully') {
        localStorage.clearAll();
        isLoading.value = false;
        MPFullScreenLoader.stopLoading();
        Get.offAll(() => const FrontPage());
        getSnackBar('Logged Out Successfully.', "Successful", true);
      } else {
        isLoading.value = false;
        MPFullScreenLoader.stopLoading();
        print(jsonResponse['message']);
        getSnackBar("Error Logging Out, Please Try Again.", 'Error', false);
        localStorage.clearAll();
      }
    } catch (e) {
      MPFullScreenLoader.stopLoading();
      isLoading.value = false;
      getSnackBar(e.toString(), "Error", false);
    }
  }
}
