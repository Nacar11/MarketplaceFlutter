import 'package:marketplacedb/data/models/product/product_item_model.dart';

class ShoppingCartItemModel {
  int? id;
  int? cartId;
  int? productItemId;
  bool? selectedToCheckout;
  ProductItemModel? productItem;

  ShoppingCartItemModel({
    this.id,
    this.cartId,
    this.productItemId,
    this.selectedToCheckout,
    this.productItem,
  });

  ShoppingCartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productItemId = json['product_item_id'];
    selectedToCheckout =
        json['selectedToCheckout'] == 1 || json['selectedToCheckout'] == "1"
            ? true
            : false;
    if (json['product_item'] != null) {
      productItem = ProductItemModel.fromJson(json['product_item']);
    }
  }
}
