// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/models/ProductItemModel.dart';
import 'package:marketplacedb/models/VariantsOptionsModel.dart';

class ProductConfigurationModel {
  int? id;
  int? product_item_id;
  int? variation_option_id;
  ProductItemModel? productItem;
  VariationOptionModel? variationOption;

  ProductConfigurationModel({
    this.id,
    this.product_item_id,
    this.variation_option_id,
    this.productItem,
    this.variationOption,
  });

  ProductConfigurationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_item_id = json['product_item_id'];
    variation_option_id = json['variation_option_id'];
    if (json['productItem'] != null) {
      productItem = ProductItemModel.fromJson(json['productItem']);
    } else {
      productItem = null;
    }
    if (json['variation_option'] != null) {
      variationOption = VariationOptionModel.fromJson(json['variation_option']);
    } else {
      variationOption = null;
    }
  }
}
