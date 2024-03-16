import 'package:marketplacedb/data/models/variation_model.dart';

class VariationOptionModel {
  int? id;
  String? value;
  VariationModel? variation;

  VariationOptionModel({this.id, this.variation, this.value});

  VariationOptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    if (json['variation'] != null) {
      variation = VariationModel.fromJson(json['variation']);
    } else {
      variation = null;
    }
  }
}
