class PaymentTypeModel {
  int? id;
  String? name;
  String? code;
  String? productImage;

  PaymentTypeModel({this.id, this.name, this.code, this.productImage});

  PaymentTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    productImage = json['product_image'];
  }
}
