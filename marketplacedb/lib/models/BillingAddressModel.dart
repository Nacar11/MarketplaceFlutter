// ignore_for_file: file_names, non_constant_identifier_names

class CountryModel {
  int? id;
  String? unit_number;
  String? line_address_1;
  String? line_address_2;
  String? city;
  String? region;
  String? postal_code;
  int? country_id;

  CountryModel(
      {this.id,
      this.unit_number,
      this.line_address_1,
      this.line_address_2,
      this.city,
      this.region,
      this.postal_code,
      this.country_id});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unit_number = json['unit_number'];
    line_address_1 = json['line_address_1'];
    line_address_2 = json['line_address_2'];
    city = json['city'];
    region = json['region'];
    postal_code = json['postal_code'];
    country_id = json['country_id'];
  }
}
