import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';
import 'package:marketplacedb/networks/services/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/code/sign_up_page_code.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/password/sign_up_page_password.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';
import 'package:marketplacedb/util/popups/full_screen_animation_loader.dart';

class SignUpPagesController extends GetxController {
  static SignUpPagesController get instance => Get.find();
  final isLoading = false.obs;
  NavigationController controller = NavigationController.instance;

  //SIGN UP PHONE PAGE VARIABLES
  final phoneNumber = TextEditingController();
  final isPhoneValid = false.obs;

  //SIGN UP CODE PAGE VARIABLES
  final otp = ''.obs;

  //SIGN UP NAME PAGE VARIABLES
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final isFirstNameValid = false.obs;
  final isLastNameValid = false.obs;
  GlobalKey<FormState> firstNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> lastNameKey = GlobalKey<FormState>();

  //SIGN UP GENDER / BIRTH DATE PAGE VARIABLES
  final birthDate = TextEditingController();
  final gender = 'Male'.obs;
  final currentDate = DateTime.now();
  final isDateValid = false.obs;

  //SIGN UP USERNAME / AGREEMENTS PAGE VARIABLES
  final username = TextEditingController();
  GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  final isUsernameValid = false.obs;
  final agreements = false.obs;

  final isSubscribedToPromotions = false.obs;
  final isSubscribedToNewsletters = false.obs;

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

      MPAlertLoaderDialog.openLoadingDialog();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MPAlertLoaderDialog.stopLoading();
        return;
      }

      var response = await AuthInterceptor().post(
        Uri.parse('${MPConstants.url}SMSVerificationCode'),
        body: {
          'contact_number': phoneNumber.text,
        },
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        String code = jsonObject['data'].toString();
        localStorage.saveData('SMSVerificationCode', code);
        print(
            'SMS VERIFIFICATION CODE: (IF VONAGE IS NOT DEPLOYED STILL)  ${localStorage.readData('SMSVerificationCode')}');
        localStorage.saveData('contact_number', phoneNumber.text);
        isLoading.value = false;
        MPAlertLoaderDialog.stopLoading();
        Get.to(() => const SignUpPageCode());
      } else {
        MPAlertLoaderDialog.stopLoading();
        isLoading.value = false;
        getSnackBar(jsonObject['message'], 'Error', false);
      }
    } catch (e) {
      isLoading.value = false;
      MPAlertLoaderDialog.stopLoading();
      getSnackBar("Please Try Again", 'Error', false);
    }
  }

  Future checkUsername() async {
    try {
      isLoading.value = true;

      var response = await AuthInterceptor().post(
        Uri.parse('${MPConstants.url}checkUsername'),
        body: {
          'username': username.text,
        },
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'Username is available') {
        localStorage.saveData(
            'is_subscribe_to_promotions', isSubscribedToPromotions.value);
        localStorage.saveData(
            'is_subscribe_to_newsletters', isSubscribedToNewsletters.value);
        localStorage.saveData('username', username.text);
        Get.to(() => const SignUpPagePassword());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        getSnackBar(jsonObject['message'], 'Invalid Username', false);
      }
    } catch (e) {
      isLoading.value = false;
      getSnackBar("Please Try Again", 'Error', false);
    }
  }

  Future register() async {
    try {
      isLoading.value = true;

      MPFullScreenAnimationLoader.openLoadingDialog(
          'Creating your account, this may take a while... ',
          AnimationsUtils.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MPFullScreenAnimationLoader.stopLoading();
        return;
      }
      var data = {
        'email': localStorage.readData('email'),
        'password': localStorage.readData('password'),
        'last_name': localStorage.readData('last_name'),
        'first_name': localStorage.readData('first_name'),
        'username': localStorage.readData('username'),
        'contact_number': localStorage.readData('contact_number'),
        'date_of_birth': localStorage.readData('date_of_birth'),
        'is_subscribe_to_newsletters':
            (localStorage.readData('is_subscribe_to_newsletters') ?? false)
                ? 'true'
                : 'false',
        'is_subscribe_to_promotions':
            (localStorage.readData('is_subscribe_to_promotions') ?? false)
                ? 'true'
                : 'false',
        'gender': localStorage.readData('gender'),
      };

      data.forEach((key, value) {
        print('$key: ${value.runtimeType}');
      });

      var response = await AuthInterceptor().post(
        Uri.parse('${MPConstants.url}register'),
        body: data,
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['message'] == "success") {
        localStorage.clearAll();

        isLoading.value = false;
        localStorage.saveData('token', jsonResponse['access_token']);
        localStorage.saveData('username', jsonResponse['username']);
        isLoading.value = false;
        MPFullScreenAnimationLoader.stopLoading();
        controller.index.value = 0;
        Get.offAll(() => const Navigation());
        String text = 'Welcome, ${jsonResponse['username']}';
        getSnackBar(text, "Successfully Registered!", true);
      } else {
        getSnackBar(jsonResponse['message'], 'Error', false);
        MPFullScreenAnimationLoader.stopLoading();
        isLoading.value = false;
      }
    } catch (e) {
      MPFullScreenAnimationLoader.stopLoading();
      isLoading.value = false;
      getSnackBar(e.toString(), "Error", false);
    }
  }
}
