// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/data/models/products/product_item_model.dart';

class ShoppingCartItemModel {
  int? id;
  int? cart_id;
  int? product_item_id;
  ProductItemModel? product_item;

// Define children property

  ShoppingCartItemModel(
      {required this.id,
      required this.cart_id,
      required this.product_item_id,
      required this.product_item});

  ShoppingCartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cart_id = json['cart_id'];
    product_item_id = json['product_item_id'];
    if (json['product_item'] != null) {
      product_item = ProductItemModel.fromJson(json['product_item']);
    }
  }
}
