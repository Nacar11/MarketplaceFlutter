// ignore_for_file: file_names, non_constant_identifier_names

class VariationOptionModel {
  int? id;
  String? value;
  int? variation_id;

  VariationOptionModel({this.id, this.variation_id, this.value});

  VariationOptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    variation_id = json['variation_id'];
  }
}
