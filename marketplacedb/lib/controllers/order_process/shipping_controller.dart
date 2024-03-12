import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/order_process/shipping_method_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class ShippingController extends GetxController {
  final isLoading = false.obs;
  final shippingMethodList = <ShippingMethodModel>[].obs;

  Future<void> getShippingMethods() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getShippingMethods"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ShippingMethodModel> itemList =
            result.map((e) => ShippingMethodModel.fromJson(e)).toList();

        shippingMethodList.assignAll(itemList);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
