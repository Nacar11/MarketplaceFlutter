import 'dart:convert';
import 'package:get/get.dart';
import 'package:marketplacedb/data/models/products/product_item_model.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class ListedItemsListPageController extends GetxController {
  static ListedItemsListPageController get static => Get.find();
  final isLoading = false.obs;
  final listedItemsList = <ProductItemModel>[].obs;
  final singleListedItem = ProductItemModel().obs;

  @override
  void onInit() async {
    await getListedItemsByUser();
    super.onInit();
  }

  Future<void> getListedItemsByUser() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getProductItemsByUser"));
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
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
}
