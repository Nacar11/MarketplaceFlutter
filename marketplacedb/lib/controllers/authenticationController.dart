// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, await_only_futures

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == "Authorized") {
        isLoading.value = false;
        print(jsonObject['access_token']);
        storage.write('token', jsonObject['access_token']);
        storage.write('username', jsonObject['username']);
        storage.read('token');
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
      var jsonObject = jsonDecode(response.body);

      return jsonObject;
      // if (jsonObject['message'] == "Authorized") {
      //   isLoading.value = false;
      //   print(jsonObject['access_token']);
      //   return 0;
      // } else {
      //   isLoading.value = false;
      //   return jsonObject['errors'];
      // }
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
        final storage = GetStorage();
        storage.erase();
        storage.write('token', jsonObject['access_token']);
        storage.write('username', jsonObject['username']);

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
      var jsonObject = jsonDecode(response.body);
      isLoading.value = false;
      return jsonObject;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
