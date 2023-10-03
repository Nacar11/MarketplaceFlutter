// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  void storeLocalData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void storeLocalBoolData(String key, bool value) async {
    print("asd");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
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
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('username');
    print(action);

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
      print(data['password'].runtimeType);
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

      if (jsonObject['message'] == "Authorized") {
        isLoading.value = false;
        print(jsonObject['access_token']);
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

  Future register() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      isLoading.value = true;

      var data = {
        'email': prefs.getString('email'),
        'password': prefs.getString('password'),
        'last_name': prefs.getString('first_name'),
        'first_name': prefs.getString('first_name'),
        'username': prefs.getString('username'),
        'contact_number': prefs.getString('contact_number'),
        'date_of_birth': prefs.getString('date_of_birth'),
        'is_subscribe_to_newsletter': 'false',
        'is_subscribe_to_promotions': 'false',
        'gender': "Male"
      };

      var response = await http.post(
        Uri.parse('${url}register'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == "Success") {
        isLoading.value = false;
        print(jsonObject['access_token']);
        return 0;
      } else {
        isLoading.value = false;
        print(jsonObject['errors']);
        return jsonObject['errors'];
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
