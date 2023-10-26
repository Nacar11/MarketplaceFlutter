// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, await_only_futures, unused_import, unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final storage = GetStorage();

  void storeLocalData(String key, value) async {
    final storage = GetStorage();
    await storage.write(key, value);
  }

  String email = '';
  String first_name = '';
  String last_name = '';
  String password = '';
  String username = '';
  String gender = '';
  String date_of_birth = '';
  String contact_number = '';
  final is_subscribe_to_newsletter = false;
  final is_subscribe_to_promotions = false;

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
          storage.write('userID', jsonResponse['user_id']);

          storage.read('token');
          return 0;
        } else {
          isLoading.value = false;
          return jsonResponse['errors'];
        }
      } catch (e) {
        isLoading.value = false;
        print(e);
      }
      //   var response = await http.post(
      //     Uri.parse('${url}login'),
      //     headers: {
      //       'Accept': 'application/json',
      //     },
      //     body: data,
      //   );
      //   var jsonObject = jsonDecode(response.body);
      //   if (jsonObject['message'] == "Authorized") {
      //     isLoading.value = false;

      //     storage.write('token', jsonObject['access_token']);
      //     storage.write('username', jsonObject['username']);
      //     storage.read('token');
      //     return 0;
      //   } else {
      //     isLoading.value = false;
      //     return jsonObject['errors'];
      //   }
    } catch (e) {
      print(e);
      isLoading.value = false;
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
      print(jsonObject);
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

      return jsonObject;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future register() async {
    final storage = await GetStorage();
    try {
      isLoading.value = true;

      var data = {
        'email': storage.read('email'),
        'password': storage.read('password'),
        'last_name': storage.read('first_name'),
        'first_name': storage.read('first_name'),
        'username': storage.read('username'),
        'contact_number': storage.read('contact_number'),
        'date_of_birth': storage.read('date_of_birth'),
        'is_subscribe_to_newsletters':
            (storage.read('is_subscribe_to_newsletters') ?? false)
                ? 'true'
                : 'false',
        'is_subscribe_to_promotions':
            (storage.read('is_subscribe_to_promotions') ?? false)
                ? 'true'
                : 'false',
        'gender': storage.read('gender'),
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
      if (jsonObject['message'] == "Success") {
        isLoading.value = false;
        print(jsonObject['access_token']);
        storage.write('token', jsonObject['access_token']);
        storage.write('username', jsonObject['username']);
        storage.write('userID', jsonObject['user_id']);

        return 0;
      } else {
        isLoading.value = false;
        return jsonObject['errors'];
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

      if (jsonObject['message'] == 'registerFirst') {
        final storage = GetStorage();
        storage.write('email', email);
        storage.write('signInMethod', 'google');
        isLoading.value = false;
        return 0;
      } else if (jsonObject['message'] == 'Success') {
        final storage = GetStorage();
        storage.erase();
        storage.write('token', jsonObject['access_token']);
        storage.write('username', jsonObject['username']);
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
