// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/models/ProductImageModel.dart';
import 'package:marketplacedb/models/ProductTypeModel.dart';

class ProductItemModel {
  int? id;
  int? product_id;
  int? user_id;
  String? SKU;
  double? price;
  String? description;
  List<ProductImageModel>? product_images;
  ProductTypeModel? product; // Define children property

  ProductItemModel(
      {this.id,
      this.product_id,
      this.user_id,
      this.SKU,
      this.price,
      this.description,
      this.product_images,
      this.product});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_id = json['product_id'];
    user_id = json['user_id'];
    SKU = json['SKU'];
    price = json['price']?.toDouble();
    description = json['description'];
    if (json['product_images'] != null) {
      product_images = (json['product_images'] as List)
          .map((e) => ProductImageModel.fromJson(e))
          .toList();
    } else {
      product_images =
          <ProductImageModel>[]; // Initialize children as an empty list
    }

    if (json['product'] != null) {
      product = ProductTypeModel.fromJson(json['product']);
    } else {
      product = null;
    } // Initialize children as an empty list
  }
}
