// ignore_for_file: file_names, non_constant_identifier_names

class BillingAddressModel {
  int? id;
  String? unit_number;
  String? address_line_1;
  String? address_line_2;
  String? city;
  String? region;
  String? postal_code;
  int? country_id;

  BillingAddressModel(
      {this.id,
      this.unit_number,
      this.address_line_1,
      this.address_line_2,
      this.city,
      this.region,
      this.postal_code,
      this.country_id});

  BillingAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unit_number = json['unit_number'];
    address_line_1 = json['line_address_1'];
    address_line_2 = json['line_address_2'];
    city = json['city'];
    region = json['region'];
    postal_code = json['postal_code'];
    country_id = json['country_id'];
  }
}
