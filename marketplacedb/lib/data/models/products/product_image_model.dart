class ProductImageModel {
  int? id;
  String? productImage;
  int? productItemId;

  ProductImageModel({this.id, this.productImage, this.productItemId});

  ProductImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImage = json['product_image'];
    productItemId = json['product_id'];
  }
}
