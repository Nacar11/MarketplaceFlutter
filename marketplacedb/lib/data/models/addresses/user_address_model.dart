import 'package:marketplacedb/data/models/addresses/address_model.dart';

class UserAddressModel {
  int? userId;
  int? addressId;
  bool? isDefault;
  AddressModel? address;

  UserAddressModel({this.userId, this.addressId, this.isDefault, this.address});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    addressId = json['address_id'];
    isDefault =
        json['is_default'] == 1 || json['is_default'] == "1" ? true : false;
    if (json['address'] != null) {
      address = AddressModel.fromJson(json['address']);
    }
  }
}
