// ignore_for_file: file_names, non_constant_identifier_names

class ProductImageModel {
  int? id;
  String? product_image;

  ProductImageModel({this.id, this.product_image});

  ProductImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_image = json['product_image'];
  }
}
