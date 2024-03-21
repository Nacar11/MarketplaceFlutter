import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/shopping_cart/shopping_cart_item_model.dart';
import 'package:marketplacedb/data/models/user/user_model.dart';
import 'package:marketplacedb/networks/services/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final isLoading = false.obs;
  final userHasAddressValue = false.obs;
  final userData = UserModel().obs;
  final defaultUserAddress = UserAddressModel().obs;
  final shoppingCartItemList = <ShoppingCartItemModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await userDataInit();
    await getDefaultUserAddress();
    await userHasAddress();
    await getShoppingCartItems();
  }

  Future<void> addToCart(int productItemId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .post(Uri.parse("${MPConstants.url}addToCart"), body: {
        'product_item_id': productItemId.toString(),
      });
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await getShoppingCartItems();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }

  Future<void> getShoppingCartItems() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getShoppingCartItemsByUser"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ShoppingCartItemModel> list =
            result.map((e) => ShoppingCartItemModel.fromJson(e)).toList();
        shoppingCartItemList.assignAll(list);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
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
