import 'dart:convert';

import 'package:get/get.dart';
import 'package:marketplacedb/data/models/products/product_item_model.dart';

import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';

class FavoritesPageController extends GetxController {
  static FavoritesPageController get instance => Get.find();

  final currentClickedSubcategory = 0.obs;
  final isLoading = false.obs;
  var favoriteProductItems = <ProductItemModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getFavoriteProductItems();
  }

  Future<void> getFavoriteProductItems() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${MPConstants.url}getFavoritesByUser"));
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> data = jsonObject['data'];
        final List<Map<String, dynamic>> productItemsDataList = data
            .map((item) => item['product_item'] as Map<String, dynamic>)
            .toList();

        final List<ProductItemModel> favoriteItemsList =
            productItemsDataList.map((item) {
          return ProductItemModel.fromJson(item);
        }).toList();

        favoriteProductItems.assignAll(favoriteItemsList);
        print(favoriteItemsList.length);

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

  Future<void> addToFavorites(int productItemId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .post(Uri.parse("${MPConstants.url}addToFavorites"), body: {
        'product_item_id': productItemId.toString(),
      });
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == 'success') {
        await getFavoriteProductItems();
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

  Future<void> removeFromFavorites(int productItemId) async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .delete(Uri.parse("${MPConstants.url}removeFromFavorites"), body: {
        'product_item_id': productItemId.toString(),
      });
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      if (jsonObject['message'] == 'success') {
        await getFavoriteProductItems();
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
