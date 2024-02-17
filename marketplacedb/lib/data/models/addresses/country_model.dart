import 'package:marketplacedb/data/models/addresses/region_model.dart';

class CountryModel {
  int? id;
  String? name;
  String? code;
  List<RegionModel>? regions;

  CountryModel({this.id, this.name, this.code, this.regions});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    if (json['regions'] != null) {
      regions = [];
      json['regions'].forEach((regionJson) {
        regions!.add(RegionModel.fromJson(regionJson));
      });
    } else {
      regions = <RegionModel>[];
    }
  }
}
