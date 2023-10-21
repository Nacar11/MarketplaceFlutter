// ignore_for_file: file_names, non_constant_identifier_names

class ProductImageModel {
  int? id;
  String? product_image;
  int? product_item_id;

  ProductImageModel({this.id, this.product_image, this.product_item_id});

  ProductImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_image = json['product_image'];
    product_item_id = json['product_id'];
  }
}
