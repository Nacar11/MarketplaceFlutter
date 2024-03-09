import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/user/user_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final isLoading = false.obs;
  final userHasAddressValue = false.obs;
  final userData = UserModel().obs;
  final defaultUserAddress = UserAddressModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await userDataInit();
    await getDefaultUserAddress();
    await userHasAddress();
  }

  Future<void> userDataInit() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getUserData"));
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      Map<String, dynamic> userDataJson = jsonObject['data'];

      UserModel userModel = UserModel.fromJson(userDataJson);
      userData.value = userModel;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future userHasAddress() async {
    try {
      isLoading.value = true;
      MPFullScreenOverlayLoader.openLoadingDialog();
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}userHasAddress"));
      var jsonObject = jsonDecode(response.body);
      userHasAddressValue.value = jsonObject['message'];
      MPFullScreenOverlayLoader.stopLoading();
      isLoading.value = false;
    } catch (e) {
      print(e);
      MPFullScreenOverlayLoader.stopLoading();
      isLoading.value = false;
    }
  }

  Future<void> getDefaultUserAddress() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getDefaultAddress"));
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == 'success') {
        final Map<String, dynamic> data = jsonObject['data'];
        final UserAddressModel userAddress = UserAddressModel.fromJson(data);
        defaultUserAddress.value = userAddress;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch default address');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching default address: $e');
    }
  }
}
