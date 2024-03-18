import 'package:marketplacedb/data/models/products/product_item_model.dart';
import 'package:marketplacedb/data/models/product_variations/variation_option_model.dart';

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
