class OrderStatusModel {
  int? id;
  String? status;

  OrderStatusModel({
    this.id,
    this.status,
  });

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }
}
