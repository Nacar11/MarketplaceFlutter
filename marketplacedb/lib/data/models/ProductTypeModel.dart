// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/data/models/ProductCategoryModel.dart';

class ProductTypeModel {
  int? id;
  String? name;
  ProductCategoryModel? product_category;
  String? description;
// Define children property

  ProductTypeModel(
      {required this.description,
      required this.id,
      required this.name,
      required this.product_category});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['product_category'] != null) {
      product_category =
          ProductCategoryModel.fromJson(json['product_category']);
    } else {
      product_category = null;
    }
    description = json['description'];
  }
}
