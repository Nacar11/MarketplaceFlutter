class ShippingMethodModel {
  int? id;
  double? price;
  String? name;

// Define children property

  ShippingMethodModel({
    required this.id,
    required this.price,
    required this.name,
  });

  ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price']?.toDouble();
    name = json['name'];
  }
}
