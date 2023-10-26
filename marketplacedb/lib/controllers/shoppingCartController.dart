// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, await_only_futures, unused_import

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/models/ProductItemModel.dart';
import 'package:marketplacedb/models/ShoppingCartModel.dart';
import 'package:marketplacedb/models/shoppingCartItemModel.dart';
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/networks/interceptor.dart';
import 'package:marketplacedb/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class ShoppingCartController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  var shoppingCartItemList = <ShoppingCartItemModel>[].obs;

  void storeLocalData(String key, value) async {
    final storage = GetStorage();
    await storage.write(key, value);
  }

  Future<String> addtoCart(String id) async {
    var data = {'product_item_id': id};
    try {
      print(data);
      isLoading.value = true;
      var response = await AuthInterceptor().post(
        Uri.parse('${url}addToCart'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      isLoading.value = false;
      return jsonObject['message'];
    } catch (e) {
      print(e);
      isLoading.value = false;
      return 'fail';
    }
  }

  Future<ShoppingCartModel>? getshoppingcartitem() async {
    final storage = GetStorage();
    final userID = storage.read('userID');
    final response = await AuthInterceptor()
        .get(Uri.parse("${url}getShoppingCartByUser/$userID"));

    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      print(response.body);

      final ShoppingCartModel shoppingCart = ShoppingCartModel.fromJson(result);
      print(shoppingCart.id);
      for (var item in shoppingCart.items!) {
        print(item.product_item_id);
      }
      return shoppingCart;
    } else {
      throw Exception('Failed to load shopping cart data');
    }
  }

  Future<List<ShoppingCartItemModel>?> getCartItemsForUser() async {
    final response =
        await AuthInterceptor().get(Uri.parse("${url}getCartItemsForUser"));

    print(jsonDecode(response.body));
    // print('${jsonDecode(response.body).runtimeType}');
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      final List<ShoppingCartItemModel> shoppingCartItem = result.map((e) {
        // Parse the "productItem" data and create a ProductItemModel instance
        final productItemData = e['productItem'];
        final ProductItemModel productItem =
            ProductItemModel.fromJson(productItemData);
        print(productItemData);
        // Create a ShoppingCartItemModel instance and set the "productItem" property
        final shoppingCartItemModel = ShoppingCartItemModel.fromJson(e);
        shoppingCartItemModel.product_item = productItem;

        return shoppingCartItemModel;
      }).toList();

      return shoppingCartItem;
    } else {
      throw Exception('Failed to load shopping cart data');
    }
  }
}
