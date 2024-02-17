class CityModel {
  int? id;
  String? name;
  int? regionId;

  CityModel({this.id, this.name, this.regionId});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    regionId = json['region_id'];
  }
}
