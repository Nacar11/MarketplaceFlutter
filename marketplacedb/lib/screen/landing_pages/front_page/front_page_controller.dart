// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, await_only_futures, unused_import, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/screen/sign_up_pages/phone/sign_up_page_phone.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/full_screen_loader.dart';

class FrontPageController extends GetxController {
  final isLoading = false.obs;

  static FrontPageController get instance => Get.find();
  final rememberMe = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  MPLocalStorage localStorage = MPLocalStorage();

  Future<void> simulateLoading(Duration duration) async {
    isLoading.value = true;
    await Future.delayed(duration);
    isLoading.value = false;
  }

  Future login() async {
    try {
      isLoading.value = true;

      MPFullScreenLoader.openLoadingDialog(
          'Logging in...', AnimationsUtils.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      final urlRequest =
          http.MultipartRequest('POST', Uri.parse('${url}login'));

      urlRequest.fields['email'] = email.text;
      urlRequest.fields['password'] = password.text;

      try {
        final streamedResponse = await urlRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        final jsonResponse = json.decode(response.body);
        print(jsonResponse['message']);
        if (jsonResponse['message'] == 'success') {
          localStorage.saveData('token', jsonResponse['access_token']);
          localStorage.saveData('username', jsonResponse['username']);
          localStorage.saveData('userID', jsonResponse['user_id']);
          isLoading.value = false;
          Get.offAll(() => const Navigation());
          String text = 'Welcome, ${localStorage.readData('username')}';
          getSnackBar(text, MPTexts.successLogin, true);
        } else {
          getSnackBar(jsonResponse['message'], 'Error', false);
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        print(e);
      }
    } catch (e) {
      getSnackBar(e.toString(), "Error", false);
    } finally {
      MPFullScreenLoader.stopLoading();
    }
  }

  Future changePassword(
      {required String email, required String newPassword}) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor().post(
        Uri.parse('${url}changePass'),
        body: {
          'email': email,
          'new_password': newPassword,
        },
      );
      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;
      return jsonObject;
    } catch (e) {
      isLoading.value = false;
      print('Error while changing password: $e');
    }
  }

  Future checkEmail({
    required String email,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
      };
      var response = await http.post(
        Uri.parse('${url}checkEmail'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      print(response.body);
      var jsonObject = jsonDecode(response.body);

      isLoading.value = false;
      return jsonObject;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future checkUsername({
    required String username,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': username,
      };

      var response = await http.post(
        Uri.parse('${url}checkUsername'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      isLoading.value = false;
      return jsonObject;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future register() async {
    try {
      isLoading.value = true;

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

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == "success") {
        isLoading.value = false;
        print(jsonObject['access_token']);
        localStorage.saveData('token', jsonObject['access_token']);
        localStorage.saveData('username', jsonObject['username']);
        localStorage.saveData('userID', jsonObject['user_id']);

        Get.offAll(() => const Navigation());
        String text = 'Welcome, ${localStorage.readData('username')}';
        getSnackBar(text, "Successfully Registered!", true);
      } else {
        isLoading.value = false;

        final text = jsonObject['message'];
        getSnackBar(text, 'Error', false);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future getEmailVerificationCode(String email) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
      };
      var response = await AuthInterceptor().post(
        Uri.parse('${url}getEmailVerificationCode'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;
      print(jsonObject);
      return jsonObject;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future getSMSVerificationCode(String contact_number) async {
    try {
      isLoading.value = true;
      var data = {
        'contact_number': contact_number,
      };
      var response = await AuthInterceptor().post(
        Uri.parse('${url}SMSVerificationCode'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;
      print(jsonObject);
      return jsonObject;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future loginGoogle(BuildContext context, String? email) async {
    try {
      var data = {'email': email};
      isLoading.value = true;
      var response = await AuthInterceptor().post(
        Uri.parse('${url}google/callback'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == 'registerFirst') {
        localStorage.saveData('email', email);
        localStorage.saveData('signInMethod', 'google');
        isLoading.value = false;
        await GoogleSignAPI.logout();
        Get.to(() => const SignUpPagePhone());
      } else if (jsonObject['message'] == 'success') {
        localStorage.clearAll();
        localStorage.saveData('token', jsonObject['access_token']);
        localStorage.saveData('username', jsonObject['username']);
        localStorage.saveData('userID', jsonObject['user_id']);
        isLoading.value = false;
        await GoogleSignAPI.logout();
        Get.offAll(() => const Navigation());
        String text = 'Welcome, ${localStorage.readData('username')}';
        getSnackBar(text, MPTexts.successLogin, true);
      } else {
        isLoading.value = false;
        getSnackBar(MPTexts.errorLoggingIn, 'error', false);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future loginFacebook(String? email) async {
    try {
      var data = {'email': email};
      isLoading.value = true;
      var response = await AuthInterceptor().post(
        Uri.parse('${url}facebook/callback'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      var jsonObject = jsonDecode(response.body);

      if (jsonObject['message'] == 'registerFirst') {
        final storage = GetStorage();
        storage.write('email', email);
        storage.write('signInMethod', 'facebook');
        isLoading.value = false;
        return 0;
      } else if (jsonObject['message'] == 'Success') {
        final storage = GetStorage();
        storage.erase();
        storage.write('token', jsonObject['access_token']);
        storage.write('username', jsonObject['username']);
        storage.write('first_name', jsonObject['first_name']);
        storage.write('last_name', jsonObject['last_name']);
        storage.write('contact_number', jsonObject['contact_number']);
        storage.write('email', jsonObject['email']);
        storage.write('userID', jsonObject['user_id']);
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}