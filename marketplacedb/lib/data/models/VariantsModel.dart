// ignore_for_file: file_names, non_constant_identifier_names

import 'package:marketplacedb/data/models/VariantsOptionsModel.dart';

class VariationModel {
  int? id;
  String? name;
  int? category_id;
  List<VariationOptionModel>? variation_options;
  VariationModel(
      {this.id, this.category_id, this.name, this.variation_options});

  VariationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category_id = json['category_id'];
    if (json['variation_options'] != null) {
      variation_options = List<VariationOptionModel>.from(
        json['variation_options'].map(
          (option) => VariationOptionModel.fromJson(option),
        ),
      );
    }
  }
}
