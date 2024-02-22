import 'package:marketplacedb/data/models/addresses/city_model.dart';
import 'package:marketplacedb/data/models/addresses/country_model.dart';
import 'package:marketplacedb/data/models/addresses/region_model.dart';

class AddressModel {
  int? id;
  String? unitNumber;
  String? addressLine1;
  String? addressLine2;
  String? contactNumber; // Added field
  CityModel? city;
  RegionModel? region;
  String? postalCode;
  CountryModel? country;
  int? countryId;
  int? regionId;
  int? cityId;

  AddressModel({
    this.id,
    this.unitNumber,
    this.addressLine1,
    this.addressLine2,
    this.contactNumber, // Added field
    this.city,
    this.region,
    this.postalCode,
    this.country,
    this.countryId,
    this.regionId,
    this.cityId,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitNumber = json['unit_number'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    contactNumber = json['contact_number']; // Parse contactNumber field
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
    region =
        json['region'] != null ? RegionModel.fromJson(json['region']) : null;
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    cityId = json['city_id'];
    country =
        json['country'] != null ? CountryModel.fromJson(json['country']) : null;
  }
}
