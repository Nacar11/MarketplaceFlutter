// ignore_for_file: file_names, non_constant_identifier_names

class ProductTypeModel {
  int? id;
  String? name;
  int? category_id;
  String? description;
// Define children property

  ProductTypeModel(
      {required this.description,
      required this.id,
      required this.name,
      required this.category_id});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category_id = json['category_id'];
    description = json['description'];
  }
}
