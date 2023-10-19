// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/models/ProductTypeModel.dart';
import 'package:marketplacedb/models/VariantsOptionsModel.dart';
import 'package:marketplacedb/models/shoppingCartItemModel.dart';

class ShoppingCartModel {
  int? id;
  int? user_id;
  List<ShoppingCartItemModel>? shopping_cart_items;
  ProductTypeModel? product;
  VariationOptionModel? variation_options;

// Define children property

  ShoppingCartModel(
      {required this.id,
      required this.user_id,
      this.shopping_cart_items,
      required this.product,
      required this.variation_options});

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    product = json['product'];
    variation_options = json['variation_options'];

    if (json['items'] != null) {
      shopping_cart_items = (json['items'] as List)
          .map((e) => ShoppingCartItemModel.fromJson(e))
          .toList();
    } else {
      shopping_cart_items =
          <ShoppingCartItemModel>[]; // Initialize children as an empty list
    }
  }
}
