import 'package:marketplacedb/data/models/product_variation/variation_option_model.dart';

class VariationModel {
  int? id;
  String? name;
  int? categoryId;
  List<VariationOptionModel>? variationOptions;
  VariationModel({this.id, this.categoryId, this.name, this.variationOptions});

  VariationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    if (json['variation_options'] != null) {
      variationOptions = List<VariationOptionModel>.from(
        json['variation_options'].map(
          (option) => VariationOptionModel.fromJson(option),
        ),
      );
    }
  }
}
