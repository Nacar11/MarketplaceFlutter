import 'package:get/get.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'dart:convert';
import 'package:marketplacedb/util/constants/app_constant.dart';

class AddressListPageController extends GetxController {
  static AddressListPageController get instance => Get.find();
  final isLoading = false.obs;
  final userAddressList = <UserAddressModel>[].obs;
  final selectedAddress = UserAddressModel().obs;
  final userController = UserController.instance;

  @override
  void onInit() async {
    super.onInit();
    await getUserAddresses();
  }

  Future setDefaultAddress() async {
    try {
      final response = await AuthInterceptor().post(Uri.parse(
          "${MPConstants.url}setDefaultAddress/${selectedAddress.value.address!.id!}"));
      var jsonObject = jsonDecode(response.body);
      print(response.body);
      if (jsonObject['message'] == 'success') {
        getUserAddresses();
        userController.getDefaultUserAddress();
      } else {
        throw Exception('message is not success');
      }
    } catch (e) {
      print('Error in fetching data: $e');
    }
  }

  void deleteAddress() async {
    try {
      final response = await AuthInterceptor().delete(Uri.parse(
          "${MPConstants.url}deleteAddress/${selectedAddress.value.address!.id!}"));
      var jsonObject = jsonDecode(response.body);
      print(response.body);
      if (jsonObject['message'] == 'success') {
        getUserAddresses();
        userController.getDefaultUserAddress();
      } else {
        throw Exception('message is not success');
      }
    } catch (e) {
      print('Error in fetching data: $e');
    }
  }

  Future<void> getUserAddresses() async {
    try {
      isLoading.value = true;

      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getAddresses"));
      var jsonObject = jsonDecode(response.body);
      print(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> addressDataList = jsonObject['data'];
        final List<UserAddressModel> addressList = addressDataList
            .map<UserAddressModel>((data) => UserAddressModel.fromJson(data))
            .toList();
        userAddressList.assignAll(addressList);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('message is not success');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error in fetching data: $e');
    }
  }
}
