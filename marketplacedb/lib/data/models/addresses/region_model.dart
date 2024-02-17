import 'package:marketplacedb/data/models/addresses/city_model.dart';

class RegionModel {
  int? id;
  String? name;
  int? countryId;
  List<CityModel>? cities;

  RegionModel({this.id, this.name, this.countryId, this.cities});

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((cityJson) {
        cities!.add(CityModel.fromJson(cityJson));
      });
    }
  }
}
