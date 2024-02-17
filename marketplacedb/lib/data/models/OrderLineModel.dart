// ignore_for_file: file_names, non_constant_identifier_names
import 'package:marketplacedb/data/models/products/product_item_model.dart';
import 'package:marketplacedb/data/models/ShippingMethodModel.dart';

class OrderLineModel {
  int? id;
  int? user_id;
  String? SKU;
  double? price;
  int? payment_method_id;
  ShippingMethodModel? shipping;
  ProductItemModel? product; // Define children property

  OrderLineModel(
      {this.id,
      this.user_id,
      this.SKU,
      this.price,
      this.payment_method_id,
      this.shipping,
      this.product});

  OrderLineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    SKU = json['SKU'];
    price = json['price'];
    payment_method_id = json['payment_method_id'];
    if (json['shipping'] != null) {
      shipping = ShippingMethodModel.fromJson(json['shipping']);
    } else {
      shipping = null;
    } // Initialize children as an empty list

    if (json['product'] != null) {
      product = ProductItemModel.fromJson(json['product']);
    } else {
      product = null;
    } // Initialize children as an empty list
  }
}
