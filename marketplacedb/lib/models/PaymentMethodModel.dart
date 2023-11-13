// ignore_for_file: file_names, non_constant_identifier_names

class PaymentMethodModel {
  int? id;
  String? value;

  PaymentMethodModel({this.id, this.value});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['name'];
  }
}
