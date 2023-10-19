// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/models/ProductItemModel.dart';

class ShoppingCartItemModel {
  int? cart_id;
  int? product_item_id;
  ProductItemModel? product_item;

// Define children property

  ShoppingCartItemModel(
      {required this.cart_id,
      required this.product_item_id,
      required this.product_item});

  ShoppingCartItemModel.fromJson(Map<String, dynamic> json) {
    cart_id = json['cart_id'];
    product_item_id = json['product_item_id'];
    product_item = json['product_item'];
  }
}
