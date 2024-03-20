import 'package:get/get.dart';
import 'package:marketplacedb/controllers/order_process/order_line_controller.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';
import 'package:marketplacedb/data/models/shopping_cart/shopping_cart_item_model.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'dart:convert';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

OrderLineController orderLineController = OrderLineController.instance;
UserController userController = UserController.instance;

class ShoppingCartPageController extends GetxController {
  static ShoppingCartPageController get instance => Get.find();
  final shoppingCartItemList = <ShoppingCartItemModel>[].obs;
  final isLoading = false.obs;
  final selectedCartItem = ShoppingCartItemModel().obs;
  final shoppingCartItemListTotalPrice = 0.0.obs;
  final shoppingCartItemListSelectedToCheckout = <ShoppingCartItemModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await orderLineController.getAllOrderLines();
    setShoppingCartItems();
    await unselectOrderedItems();
    isLoading.value = false;
  }

  Future<void> unselectOrderedItems() async {
    try {
      for (var item in shoppingCartItemList) {
        bool isItemOrdered = orderLineController.orderLineList.any(
            (orderLineItem) =>
                orderLineItem.productItemId == item.productItemId);

        if (isItemOrdered) {
          await unselectToCheckout(item.id!);
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void setShoppingCartItems() {
    try {
      shoppingCartItemList.value = userController.shoppingCartItemList;
      double totalPrice = 0.0;
      List<ShoppingCartItemModel> selectedItems = [];
      for (var item in shoppingCartItemList) {
        if (item.selectedToCheckout == true &&
            item.productItem != null &&
            item.productItem!.price != null) {
          totalPrice += item.productItem!.price!;
          selectedItems.add(item);
        }
      }
      shoppingCartItemListTotalPrice.value =
          double.parse(totalPrice.toStringAsFixed(2));
      shoppingCartItemListSelectedToCheckout.assignAll(selectedItems);
    } catch (e) {
      print('Error fetching shopping cart data: $e');
    }
  }

  Future<void> deleteCartItem() async {
    try {
      final response = await AuthInterceptor().delete(
        Uri.parse(
            "${MPConstants.url}deleteCartItem/${selectedCartItem.value.id!}"),
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await userController.getShoppingCartItems();
        setShoppingCartItems();
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> unselectToCheckout(int cartItemId) async {
    try {
      MPAlertLoaderDialog.openLoadingDialog();
      final response = await AuthInterceptor().put(
        Uri.parse("${MPConstants.url}unSelectForCheckout/$cartItemId"),
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await userController.getShoppingCartItems();
        setShoppingCartItems();
      } else {
        throw Exception('Failed to fetch data');
      }
      MPAlertLoaderDialog.stopLoading();
    } catch (e) {
      MPAlertLoaderDialog.stopLoading();
      print('Error fetching data: $e');
    }
  }

  Future<void> selectToCheckout(int cartItemId) async {
    try {
      MPAlertLoaderDialog.openLoadingDialog();
      final response = await AuthInterceptor().put(
        Uri.parse("${MPConstants.url}selectForCheckout/$cartItemId"),
      );
      var jsonObject = jsonDecode(response.body);
      if (jsonObject['message'] == 'success') {
        await userController.getShoppingCartItems();
        setShoppingCartItems();
      } else {
        throw Exception('Failed to fetch data');
      }
      MPAlertLoaderDialog.stopLoading();
    } catch (e) {
      MPAlertLoaderDialog.stopLoading();
      print('Error fetching data: $e');
    }
  }
}
