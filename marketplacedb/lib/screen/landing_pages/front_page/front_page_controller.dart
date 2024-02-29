import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/controllers/network_manager/network_manager.dart';
import 'package:marketplacedb/networks/google_signin.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/phone/sign_up_page_phone.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';
import 'package:marketplacedb/util/popups/full_screen_animation_loader.dart';

class FrontPageController extends GetxController {
  static FrontPageController get instance => Get.find();
  final isLoading = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();

  MPLocalStorage localStorage = MPLocalStorage();

  Future<void> simulateLoading(Duration duration) async {
    isLoading.value = true;
    await Future.delayed(duration);
    isLoading.value = false;
  }

  Future login() async {
    try {
      isLoading.value = true;

      MPFullScreenAnimationLoader.openLoadingDialog(
          'Logging in...', AnimationsUtils.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MPFullScreenAnimationLoader.stopLoading();
        return;
      }

      final response = await AuthInterceptor().post(
        Uri.parse("${url}login"),
        body: {
          'email': email.text,
          'password': password.text,
        },
      );
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['message'] == 'success') {
        localStorage.clearAll();
        localStorage.saveData('token', jsonResponse['access_token']);
        localStorage.saveData('username', jsonResponse['username']);
        isLoading.value = false;
        MPFullScreenAnimationLoader.stopLoading();
        Get.offAll(() => const Navigation());
        String text = 'Welcome, ${jsonResponse['username']}';
        getSnackBar(text, MPTexts.successLogin, true);
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

  Future loginGoogle(String? email) async {
    try {
      MPFullScreenAnimationLoader.openLoadingDialog(
          'Logging in...', AnimationsUtils.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MPFullScreenAnimationLoader.stopLoading();
        return;
      }
      isLoading.value = true;
      var response = await AuthInterceptor().post(
        Uri.parse('${url}google/callback'),
        body: {
          'email': email,
        },
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['message'] == 'registerFirst') {
        await GoogleSignAPI.logout();
        localStorage.saveData('email', email);
        isLoading.value = false;
        MPFullScreenAnimationLoader.stopLoading();
        Get.to(() => const SignUpPagePhone());
      } else if (jsonResponse['message'] == 'success') {
        await GoogleSignAPI.logout();
        localStorage.clearAll();
        localStorage.saveData('token', jsonResponse['access_token']);
        localStorage.saveData('username', jsonResponse['username']);
        isLoading.value = false;
        MPFullScreenAnimationLoader.stopLoading();
        Get.offAll(() => const Navigation());
        String text = 'Welcome, ${localStorage.readData('username')}';
        getSnackBar(text, MPTexts.successLogin, true);
      } else {
        getSnackBar(MPTexts.errorLoggingIn, 'error', false);
        MPFullScreenAnimationLoader.stopLoading();
        isLoading.value = false;
      }
    } catch (e) {
      MPFullScreenAnimationLoader.stopLoading();
      isLoading.value = false;
      // getSnackBar(MPTexts.errorLoggingIn, "Error", false);
    }
  }

  // Future loginFacebook(String? email) async {
  //   try {
  //     var data = {'email': email};
  //     isLoading.value = true;
  //     var response = await AuthInterceptor().post(
  //       Uri.parse('${url}facebook/callback'),
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //       body: data,
  //     );

  //     var jsonObject = jsonDecode(response.body);

  //     if (jsonObject['message'] == 'registerFirst') {
  //       final storage = GetStorage();
  //       storage.write('email', email);
  //       storage.write('signInMethod', 'facebook');
  //       isLoading.value = false;
  //       return 0;
  //     } else if (jsonObject['message'] == 'Success') {
  //       final storage = GetStorage();
  //       storage.erase();
  //       storage.write('token', jsonObject['access_token']);
  //       storage.write('username', jsonObject['username']);
  //       storage.write('first_name', jsonObject['first_name']);
  //       storage.write('last_name', jsonObject['last_name']);
  //       storage.write('contact_number', jsonObject['contact_number']);
  //       storage.write('email', jsonObject['email']);
  //       storage.write('userID', jsonObject['user_id']);
  //       return 1;
  //     } else {
  //       return 2;
  //     }
  //   } catch (e) {
  //     print(e);
  //     isLoading.value = false;
  //   }
  // }
}
