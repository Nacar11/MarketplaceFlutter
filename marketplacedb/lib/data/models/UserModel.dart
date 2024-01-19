// ignore_for_file: file_names, non_constant_identifier_names

// import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';

class UserModel {
  String? first_name;
  String? last_name;
  String? contact_number;
  String? email;
  String? birth_date;
  String? username;
  String? gender;
  bool? is_subscribe_to_newsletters;
  bool? is_subscribe_to_promotions;
  String? profile_photo_url;

  UserModel({
    this.first_name,
    this.last_name,
    this.contact_number,
    this.email,
    this.birth_date,
    this.username,
    this.gender,
    this.is_subscribe_to_newsletters,
    this.is_subscribe_to_promotions,
    this.profile_photo_url,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    contact_number = json['contact_number'];
    email = json['email'];
    birth_date = json['date_of_birth'];
    username = json['username'];
    gender = json['gender'];
    json['is_subscribe_to_newsletters'] == 1;
    json['is_subscribe_to_promotions'] == 1;
    profile_photo_url = json['profile_photo_path'];
  }
}
