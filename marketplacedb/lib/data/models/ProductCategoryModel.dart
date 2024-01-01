// ignore_for_file: file_names, non_constant_identifier_names

class ProductCategoryModel {
  int? id;
  String? category_name;
  int? category_id;
  List<ProductCategoryModel>? children; // Define children property

  ProductCategoryModel(
      {this.id, this.category_name, this.category_id, this.children});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category_name = json['category_name'];
    category_id = json['category_id'];
    if (json['children'] != null) {
      children = (json['children'] as List<dynamic>)
          .map((e) => ProductCategoryModel.fromJson(e))
          .toList();
    } else {
      children =
          <ProductCategoryModel>[]; // Initialize children as an empty list
    } // Initialize children as an empty list
  }
}
