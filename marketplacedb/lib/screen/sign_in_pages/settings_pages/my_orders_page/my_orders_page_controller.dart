import 'package:get/get.dart';
import 'package:marketplacedb/data/models/order_process/order_line_model.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';

class MyOrdersPageController extends GetxController {
  static MyOrdersPageController get instance => Get.find();

  final orderLinesList = <OrderLineModel>[].obs;
  final singleOrderLineDetails = OrderLineModel().obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getOrderLinesByUser();
  }

  Future<void> getOrderLinesByUser() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getOrderLinesByUser"));
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<OrderLineModel> list =
            result.map((e) => OrderLineModel.fromJson(e)).toList();

        orderLinesList.assignAll(list);
        // print('----------------------');
        // print(orderLinesList[0].id!);
        // print(orderLinesList[0].orderStatus!.status);
        // print(orderLinesList[0].shippingAddress!.id);

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
