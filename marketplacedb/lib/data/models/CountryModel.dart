// ignore_for_file: file_names, non_constant_identifier_names

class CountryModel {
  int? id;
  String? name;
  String? code;

  CountryModel({this.id, this.name, this.code});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }
}
