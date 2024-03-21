import 'package:get/get.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/data/models/product/product_item_model.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/services/interceptor.dart';

class ProductItemController extends GetxController {
  static ProductItemController get instance => Get.find();
  var productItemList = <ProductItemModel>[].obs;
  var productItemListByProductType = <ProductItemModel>[].obs;
  final singleProductItemDetail = ProductItemModel().obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getProductItems();
  }

  Future<void> getSingleProductItemDetail(int itemId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}productItem/$itemId"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        singleProductItemDetail.value =
            ProductItemModel.fromJson(jsonObject['data']);
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProductItems() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}productItems"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductItemModel> itemList =
            result.map((e) => ProductItemModel.fromJson(e)).toList();
        productItemList.assignAll(itemList);
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProductItemsByProductType(int productTypeID) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor().get(Uri.parse(
          "${MPConstants.url}getProductItemsByProductType/$productTypeID"));

      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ProductItemModel> itemList =
            result.map((e) => ProductItemModel.fromJson(e)).toList();
        productItemListByProductType.assignAll(itemList);
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
