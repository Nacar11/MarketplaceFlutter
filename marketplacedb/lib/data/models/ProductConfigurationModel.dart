// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/data/models/VariantsOptionsModel.dart';

class ProductConfigurationModel {
  int? id;

  ProductItemModel? productItem;
  VariationOptionModel? variationOption;

  ProductConfigurationModel({
    this.id,
    this.productItem,
    this.variationOption,
  });

  ProductConfigurationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

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
