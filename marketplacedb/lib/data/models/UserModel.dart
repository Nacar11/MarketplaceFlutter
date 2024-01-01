// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';

class ShoppingCartModel {
  int? id;
  int? user_id;
  List<ShoppingCartItemModel>? items;

// Define children property

  ShoppingCartModel({
    required this.id,
    required this.user_id,
    required this.items,
  });

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];

    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((e) => ShoppingCartItemModel.fromJson(e))
          .toList();
    } else {
      items = <ShoppingCartItemModel>[]; // Initialize children as an empty list
    }
  }
}
