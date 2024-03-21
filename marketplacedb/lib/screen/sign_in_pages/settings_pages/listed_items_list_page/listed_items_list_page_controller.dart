import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/order_process/order_line_controller.dart';
import 'package:marketplacedb/data/models/product/product_item_model.dart';
import 'package:marketplacedb/networks/services/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class ListedItemsListPageController extends GetxController {
  static ListedItemsListPageController get instance => Get.find();
  final isLoading = false.obs;
  final listedItemsList = <ProductItemModel>[].obs;

  @override
  void onInit() async {
    OrderLineController orderLineController = OrderLineController.instance;
    isLoading.value = true;
    await orderLineController.getAllOrderLines();
    await getListedItemsByUser();
    super.onInit();
    isLoading.value = false;
  }

  Future<void> getListedItemsByUser() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getProductItemsByUser"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductItemModel> list =
            result.map((e) => ProductItemModel.fromJson(e)).toList();

        listedItemsList.assignAll(list);

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

  Future<void> deleteListedItem(int productItemId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor().delete(
          Uri.parse("${MPConstants.url}deleteListedItem/$productItemId"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await getListedItemsByUser();
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
