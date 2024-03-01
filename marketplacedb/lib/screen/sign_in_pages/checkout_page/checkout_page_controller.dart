import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/data/models/order_process/payment_type_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class CheckoutPageController extends GetxController {
  static CheckoutPageController get instance => Get.find();

  final isLoading = false.obs;
  var paymentTypesList = <PaymentTypeModel>[].obs;
  final selectedPaymentMethod = PaymentTypeModel().obs;
  final defaultUserAddress = UserAddressModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getPaymentTypes();
    await getDefaultUserAddress();
  }

  Future<void> getPaymentTypes() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}getPaymentTypes"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<PaymentTypeModel> list =
            result.map((e) => PaymentTypeModel.fromJson(e)).toList();
        paymentTypesList.assignAll(list);
        selectedPaymentMethod.value = paymentTypesList[2];
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

  Future<void> getDefaultUserAddress() async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().get(Uri.parse("${url}getDefaultAddress"));
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
