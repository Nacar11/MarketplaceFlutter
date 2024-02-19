import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/password_configuration/pages/change_success.dart';
import 'package:marketplacedb/screen/password_configuration/pages/code_verification.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

class PasswordConfigurationController extends GetxController {
  static PasswordConfigurationController get instance => Get.find();
  final isLoading = false.obs;

  //FORGET PASSWORD VARIABLES
  final isEmailValid = false.obs;
  final email = TextEditingController();

  //PASSWORD RESET VARIABLES
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

  //CODE VERIFICATION VARIABLES
  final otp = ''.obs;

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

  Future getEmailVerificationCode() async {
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
        Uri.parse('${url}getEmailVerificationCode'),
        body: {
          'email': email.text,
        },
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        localStorage.saveData(
            'emailVerificationCode', jsonObject['code'].toString());
        localStorage.saveData('emailResetPassword', email.text);
        isLoading.value = false;
        MPDialogContainerLoader.stopLoading();
        Get.to(() => CodeVerificationForgetPasswordPage());
      } else {
        MPDialogContainerLoader.stopLoading();
        isLoading.value = false;
        getSnackBar(jsonObject['message'], 'Error', false);
      }

      return jsonObject;
    } catch (e) {
      MPDialogContainerLoader.stopLoading();
      getSnackBar("Please Try Again", 'Error', false);
      isLoading.value = false;
    }
  }

  Future changePassword() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor().post(
        Uri.parse('${url}changePass'),
        body: {
          'email': email.text,
          'new_password': password.text.trim(),
        },
      );
      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;
      if (jsonObject['message'] == 'Password changed successfully') {
        Get.offAll(() => const PasswordChangeSuccessPage());
      } else {
        isLoading.value = false;
        getSnackBar(jsonObject['message'], 'Error', false);
      }
    } catch (e) {
      isLoading.value = false;
      getSnackBar("Please Try Again.", 'Error', false);
    }
  }
}
