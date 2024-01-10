// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, await_only_futures, unused_import, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final storage = GetStorage();
  static AuthenticationController get instance => Get.find();

  Future<void> storeLocalData(String key, dynamic value) async {
    if (value is String) {
      String processedValue = value.trim();

      if (key == 'first_name' || key == 'last_name' || key == 'username') {
        processedValue = _capitalizeFirstLetter(processedValue);
      }
      // Store the cleaned value in local storage
      await storage.write(key, processedValue);
      print(storage.read(key));
    } else {
      // If the value is not a string (e.g., gender), directly store it without processing
      await storage.write(key, value);
      print(storage.read(key));
    }
  }

  String _capitalizeFirstLetter(String value) {
    if (value.isNotEmpty) {
      return value.substring(0, 1).toUpperCase() + value.substring(1);
    }
    return value;
  }

  // String email = '';
  // String first_name = '';
  // String last_name = '';
  // String password = '';
  // String username = '';
  // String gender = '';
  // String date_of_birth = '';
  // String contact_number = '';
  // final is_subscribe_to_newsletter = false;
  // final is_subscribe_to_promotions = false;

  Future test() async {
    final storage = GetStorage();
    print(storage.read('username'));
    print(storage.read('last_name'));
    print(storage.read('first_name'));
    // print('asdasd');
    // final response = await http.get(
    //   Uri.parse(url + 'test'),
    // );
    // print(response.body);
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };
      final urlRequest =
          http.MultipartRequest('POST', Uri.parse('${url}login'));

      urlRequest.fields['email'] = email;
      urlRequest.fields['password'] = password;

      try {
        final streamedResponse = await urlRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        if (jsonResponse['message'] == "Authorized") {
          isLoading.value = false;
          storage.erase();
          storage.write('token', jsonResponse['access_token']);
          storage.write('username', jsonResponse['username']);
          storage.write('first_name', jsonResponse['first_name']);
          storage.write('last_name', jsonResponse['last_name']);
          storage.write('contact_number', jsonResponse['contact_number']);
          storage.write('email', jsonResponse['email']);
          storage.write('userID', jsonResponse['user_id']);

          storage.read('token');
          return 0;
        } else {
          isLoading.value = false;
          return jsonResponse['message'];
        }
      } catch (e) {
        isLoading.value = false;
        print(e);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future getUser({
    required String email,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
      };
      var response = await AuthInterceptor().post(
        Uri.parse('${url}getUserByEmail'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      print(response.body);
      final jsonBody = jsonDecode(response.body);
      if (jsonBody.containsKey('success')) {
        print('asdad');
        final storage = GetStorage();
        storage.write('contact_number', jsonBody['success']);
        storage.write('email', email);
        return 0;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future changePassword(
      {required String email, required String newPassword}) async {
    try {
      final response = await AuthInterceptor().post(
        Uri.parse('${url}changePass'),
        body: {
          'email': email,
          'new_password': newPassword,
        },
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == "Password changed successfully") {
        return 0;
      } else {
        // Handle other status codes (e.g., 404, 422, 500)
        print('Failed to change password: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occur
      print('Exception while changing password: $e');
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
    MPLocalStorage localStorage = MPLocalStorage();
    try {
      isLoading.value = true;

      var data = {
        'email': localStorage.readData('email'),
        'password': localStorage.readData('password'),
        'last_name': localStorage.readData('first_name'),
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

        return 0;
      } else {
        isLoading.value = false;
        return jsonObject['message'];
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future logout() async {
    try {
      isLoading.value = true;
      var response = await AuthInterceptor().get(
        Uri.parse('${url}logout'),
        headers: {
          'Accept': 'application/json',
        },
      );
      final storage = GetStorage();
      print('ASD ${storage.read('token')}'); //
      await storage.erase();
      print(storage.read('token')); //
      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;
      return jsonObject;
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

  Future loginGoogle(String? email) async {
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
        final storage = GetStorage();
        storage.write('email', email);
        storage.write('signInMethod', 'google');
        isLoading.value = false;
        return 0;
      } else if (jsonObject['message'] == 'Success') {
        print('adsad');
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
      print('asdasdas');
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
