import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/order_process/order_line_model.dart';
import 'package:marketplacedb/networks/services/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class OrderLineController extends GetxController {
  static OrderLineController get instance => Get.find();
  final isLoading = false.obs;
  var orderLineList = <OrderLineModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllOrderLines();
  }

  bool isItemNotAvailable(int productItemId) {
    return orderLineList.any((orderLineItem) =>
        orderLineItem.productItem!.id == productItemId &&
        orderLineItem.orderStatus!.status != "Cancelled");
  }

  Future<void> getAllOrderLines() async {
    try {
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getAllOrderLines"));

      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<OrderLineModel> list =
            result.map((e) => OrderLineModel.fromJson(e)).toList();

        orderLineList.assignAll(list);
        isLoading.value = false;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data orderline: $e');
    }
  }
}
