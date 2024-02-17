import 'package:get/get.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'dart:convert';
import 'package:marketplacedb/util/constants/app_constant.dart';

class AddressListPageController extends GetxController {
  static AddressListPageController get instance => Get.find();
  final isLoading = false.obs;
  final userAddressList = <UserAddressModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserAddresses();
  }

  Future<void> getUserAddresses() async {
    isLoading.value = true;
    try {
      final response =
          await AuthInterceptor().get(Uri.parse("${url}getAddress"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<UserAddressModel> list =
            result.map((e) => UserAddressModel.fromJson(e)).toList();
        userAddressList.assignAll(list);
        print('--------------------------------');
        print(userAddressList.length);
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
