import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/user_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final isLoading = false.obs;
  final userHasAddressValue = false.obs;
  final userData = UserModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await userDataInit();
    await userHasAddress();
  }

  Future<void> userDataInit() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}getUserData"));
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
      final response =
          await AuthInterceptor().get(Uri.parse("${url}userHasAddress"));
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
}
