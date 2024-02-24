import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';

class ShoppingCartModel {
  int? id;
  int? userId;
  List<ShoppingCartItemModel>? items;

  ShoppingCartModel({
    required this.id,
    required this.userId,
    required this.items,
  });

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];

    if (json['items'] != null) {
      items = (json['items'] as List)
          .map((e) => ShoppingCartItemModel.fromJson(e))
          .toList();
    } else {
      items = <ShoppingCartItemModel>[];
    }
  }
}
