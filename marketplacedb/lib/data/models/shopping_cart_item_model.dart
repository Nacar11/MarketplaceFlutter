import 'package:marketplacedb/data/models/products/product_item_model.dart';

class ShoppingCartItemModel {
  int? id;
  int? cartId;
  int? productItemId;
  ProductItemModel? productItem;

  ShoppingCartItemModel(
      {this.id, this.cartId, this.productItemId, this.productItem});

  ShoppingCartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productItemId = json['product_item_id'];
    if (json['product_item'] != null) {
      productItem = ProductItemModel.fromJson(json['product_item']);
    }
  }
}
