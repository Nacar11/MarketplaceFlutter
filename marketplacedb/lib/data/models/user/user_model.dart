class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? email;
  String? birthDate;
  String? username;
  String? gender;
  bool? isSubscribeToNewsletters;
  bool? isSubscribeToPromotions;
  String? profilePhotoUrl;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.email,
    this.birthDate,
    this.username,
    this.gender,
    this.isSubscribeToNewsletters,
    this.isSubscribeToPromotions,
    this.profilePhotoUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
    birthDate = json['date_of_birth'];
    username = json['username'];
    gender = json['gender'];
    isSubscribeToNewsletters = json['is_subscribe_to_newsletters'] == "1" ||
        json['is_subscribe_to_newsletters'] == 1;
    isSubscribeToPromotions = json['is_subscribe_to_promotions'] == "1" ||
        json['is_subscribe_to_promotions'] == 1;
    profilePhotoUrl = json['profile_photo_path'];
  }
}
