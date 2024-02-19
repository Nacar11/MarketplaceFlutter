import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/code/sign_up_page_code.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

class SignUpPagesController extends GetxController {
  static SignUpPagesController get instance => Get.find();
  final isLoading = false.obs;

  //SIGN UP PHONE PAGE VARIABLES
  final phoneNumber = TextEditingController();
  final isPhoneValid = false.obs;

  //SIGN UP CODE PAGE VARIABLES
  final otp = ''.obs;

  //SIGN UP PASSWORD VARIABLES
  final password = TextEditingController();
  final reEnterPassword = TextEditingController();
  final newPassword = TextEditingController();
  final passwordsMatch = false.obs;
  final isPasswordValid = false.obs;
  final isPasswordEightCharacters = false.obs;
  final isPasswordOneNumber = false.obs;
  final isPasswordOneSpecialChar = false.obs;

  final numericRegex = RegExp(r'[0-9]');
  final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  MPLocalStorage localStorage = MPLocalStorage();

  void onPasswordChange(String password) {
    isPasswordEightCharacters.value = false;
    if (password.length >= 8) {
      isPasswordEightCharacters.value = true;
    }
    isPasswordOneNumber.value = false;
    if (numericRegex.hasMatch(password)) {
      isPasswordOneNumber.value = true;
    }
    isPasswordOneSpecialChar.value = false;
    if (specialCharRegex.hasMatch(password)) {
      isPasswordOneSpecialChar.value = true;
    }
  }

  Future<void> simulateLoading(Duration duration) async {
    isLoading.value = true;
    await Future.delayed(duration);
    isLoading.value = false;
  }

  Future getSMSVerificationCode() async {
    try {
      isLoading.value = true;

      MPDialogContainerLoader.openLoadingDialog(
          'Sending Code to Email...', AnimationsUtils.sendEmail);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MPDialogContainerLoader.stopLoading();
        return;
      }

      var response = await AuthInterceptor().post(
        Uri.parse('${url}SMSVerificationCode'),
        body: {
          'contact_number': phoneNumber.text,
        },
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        String code = jsonObject['data'].toString();
        localStorage.saveData('SMSVerificationCode', code);
        print(localStorage.readData('SMSVerificationCode'));
        localStorage.saveData('contact_number', phoneNumber.text);
        isLoading.value = false;
        MPDialogContainerLoader.stopLoading();
        Get.to(() => const SignUpPageCode());
      } else {
        MPDialogContainerLoader.stopLoading();
        isLoading.value = false;
        getSnackBar(jsonObject['message'], 'Error', false);
      }
    } catch (e) {
      isLoading.value = false;
      MPDialogContainerLoader.stopLoading();
      getSnackBar("Please Try Again", 'Error', false);
    }
  }
}
