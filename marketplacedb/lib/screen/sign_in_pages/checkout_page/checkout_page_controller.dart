import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/order_process/payment_type_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class CheckoutPageController extends GetxController {
  static CheckoutPageController get instance => Get.find();

  final currentClickedSubcategory = 0.obs;
  final isLoading = false.obs;
  var paymentTypesList = <PaymentTypeModel>[].obs;
  final selectedPaymentMethod = PaymentTypeModel().obs;

  @override
  void onInit() async {
    super.onInit();
    await getPaymentMethods();
  }

  Future<void> getPaymentMethods() async {
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
}
