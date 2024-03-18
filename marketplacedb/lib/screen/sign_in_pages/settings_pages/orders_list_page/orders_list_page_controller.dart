import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/data/models/order_process/order_line_model.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';

class OrdersListPageController extends GetxController {
  static OrdersListPageController get instance => Get.find();

  final orderLinesList = <OrderLineModel>[].obs;
  final singleOrderLineDetails = OrderLineModel().obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    await getOrderLinesByUser();
    super.onInit();
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

  Future<void> cancelOrder() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor().post(Uri.parse(
          "${MPConstants.url}cancelOrderLine/${singleOrderLineDetails.value.id}"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        isLoading.value = false;
        await getOrderLinesByUser();
        Get.back();
        getSnackBar('Order Successfully Cancelled', 'Success', true);
      } else {
        isLoading.value = false;
        getSnackBar('Please Try Again', 'Error Cancelling Order', false);
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching data: $e');
    }
  }
}
