// ignore_for_file: file_names, non_constant_identifier_names

class ProductItemModel {
  int? id;
  int? product_id;
  int? user_id;
  String? SKU;
  double? price;
  String? description;
  List<ProductItemModel>? children; // Define children property

  ProductItemModel(
      {this.id,
      this.product_id,
      this.user_id,
      this.SKU,
      this.price,
      this.description,
      this.children});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_id = json['product_id'];
    user_id = json['user_id'];
    SKU = json['SKU'];
    price = json['price'];
    description = json['description'];
    if (json['children'] != null) {
      children = (json['children'] as List<dynamic>)
          .map((e) => ProductItemModel.fromJson(e))
          .toList();
    } else {
      children = <ProductItemModel>[]; // Initialize children as an empty list
    } // Initialize children as an empty list
  }
}
