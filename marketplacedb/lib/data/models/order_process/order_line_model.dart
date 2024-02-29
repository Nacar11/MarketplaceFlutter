import 'package:marketplacedb/data/models/products/product_item_model.dart';
import 'package:marketplacedb/data/models/order_process/ShippingMethodModel.dart';

class OrderLineModel {
  int? id;
  int? userId;
  String? sku;
  double? price;
  int? paymentMethodId;
  ShippingMethodModel? shipping;
  ProductItemModel? product;

  OrderLineModel(
      {this.id,
      this.userId,
      this.sku,
      this.price,
      this.paymentMethodId,
      this.shipping,
      this.product});

  OrderLineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sku = json['SKU'];
    price = json['price'];
    paymentMethodId = json['payment_method_id'];
    if (json['shipping'] != null) {
      shipping = ShippingMethodModel.fromJson(json['shipping']);
    } else {
      shipping = null;
    }

    if (json['product'] != null) {
      product = ProductItemModel.fromJson(json['product']);
    } else {
      product = null;
    }
  }
}
