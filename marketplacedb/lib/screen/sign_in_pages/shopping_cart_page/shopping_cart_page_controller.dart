import 'package:get/get.dart';
import 'package:marketplacedb/data/models/shopping_cart_item_model.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';

class ShoppingCartPageController extends GetxController {
  static ShoppingCartPageController get instance => Get.find();

  final shoppingCartItemList = <ShoppingCartItemModel>[].obs;
  final isLoading = false.obs;
  final selectedCartItem = ShoppingCartItemModel().obs;

  final shoppingCartItemListTotalPrice = 0.0.obs;
  // var productTypes = <ProductTypeModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getShoppingCartItems();
  }

  Future<void> getShoppingCartItems() async {
    try {
      isLoading.value = true;
      final response = await AuthInterceptor()
          .get(Uri.parse("${url}getShoppingCartItemsByUser"));
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        final List<dynamic> result = jsonObject['data'];
        final List<ShoppingCartItemModel> list =
            result.map((e) => ShoppingCartItemModel.fromJson(e)).toList();

        shoppingCartItemList.assignAll(list);
        //assign value of shoppingCartItemListTotalPrice here
        double totalPrice = 0.0;
        for (var item in shoppingCartItemList) {
          if (item.selectedToCheckout == true &&
              item.productItem != null &&
              item.productItem!.price != null) {
            totalPrice += item.productItem!.price!;
          }
        }
        shoppingCartItemListTotalPrice.value = totalPrice;

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

  Future<void> addToCart(int productItemId) async {
    try {
      isLoading.value = true;
      final response =
          await AuthInterceptor().post(Uri.parse("${url}addToCart"), body: {
        'product_item_id': productItemId.toString(),
      });
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await getShoppingCartItems();
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

  Future<void> deleteCartItem() async {
    try {
      isLoading.value = true;

      final response = await AuthInterceptor().delete(
        Uri.parse("${url}deleteCartItem/${selectedCartItem.value.id!}"),
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await getShoppingCartItems();
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

  Future<void> unselectToCheckout(int cartItemId) async {
    try {
      isLoading.value = true;

      final response = await AuthInterceptor().put(
        Uri.parse("${url}unSelectForCheckout/$cartItemId"),
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await getShoppingCartItems();
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

  Future<void> selectToCheckout(int cartItemId) async {
    try {
      isLoading.value = true;

      final response = await AuthInterceptor().put(
        Uri.parse("${url}selectForCheckout/$cartItemId"),
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await getShoppingCartItems();
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
