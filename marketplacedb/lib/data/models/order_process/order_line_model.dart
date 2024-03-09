import 'package:marketplacedb/data/models/addresses/address_model.dart';
import 'package:marketplacedb/data/models/order_process/order_status_model.dart';
import 'package:marketplacedb/data/models/products/product_item_model.dart';
import 'package:marketplacedb/data/models/order_process/shipping_method_model.dart';
import 'package:marketplacedb/data/models/user/user_model.dart';

class OrderLineModel {
  int? id;
  UserModel? user;
  String? sku;
  String? price;
  String? orderDate;
  int? paymentMethodId;
  ShippingMethodModel? shippingMethod;
  ProductItemModel? productItem;
  AddressModel? shippingAddress;
  OrderStatusModel? orderStatus;

  OrderLineModel({
    this.id,
    this.sku,
    this.price,
    this.orderDate,
    this.paymentMethodId,
    this.shippingMethod,
    this.productItem,
    this.user,
    this.shippingAddress,
    this.orderStatus,
  });

  OrderLineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['SKU'];
    price = json['price'];
    orderDate = json['order_date'];
    paymentMethodId = json['payment_method_id'];
    shippingMethod = json['shipping_method'] != null
        ? ShippingMethodModel.fromJson(json['shipping_method'])
        : null;
    productItem = json['product_item'] != null
        ? ProductItemModel.fromJson(json['product_item'])
        : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    shippingAddress = json['shipping_address'] != null
        ? AddressModel.fromJson(json['shipping_address'])
        : null;
    orderStatus = json['order_status'] != null
        ? OrderStatusModel.fromJson(json['order_status'])
        : null;
  }
}
