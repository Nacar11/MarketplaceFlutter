import 'package:marketplacedb/data/models/product/product_configuration_model.dart';
import 'package:marketplacedb/data/models/product/product_image_model.dart';
import 'package:marketplacedb/data/models/product/product_type_model.dart';
import 'package:marketplacedb/data/models/user/user_model.dart';

class ProductItemModel {
  int? id;
  int? productId;
  int? userId;
  String? sku;
  double? price;
  String? description;
  List<ProductImageModel>? productImages;
  ProductTypeModel? product;
  List<ProductConfigurationModel>? productConfigurations;
  UserModel? user;

  ProductItemModel(
      {this.id,
      this.productId,
      this.userId,
      this.sku,
      this.price,
      this.description,
      this.productImages,
      this.product,
      this.productConfigurations,
      this.user});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    sku = json['SKU'];
    price = json['price']?.toDouble();
    description = json['description'];
    if (json['product_images'] != null) {
      productImages = (json['product_images'] as List)
          .map((e) => ProductImageModel.fromJson(e))
          .toList();
    } else {
      productImages = <ProductImageModel>[];
    }

    if (json['product'] != null) {
      product = ProductTypeModel.fromJson(json['product']);
    } else {
      product = null;
    }
    if (json['product_configurations'] != null) {
      productConfigurations = (json['product_configurations'] as List)
          .map((e) => ProductConfigurationModel.fromJson(e))
          .toList();
    } else {
      productConfigurations = <ProductConfigurationModel>[];
    }
    if (json['user'] != null) {
      user = UserModel.fromJson(json['user']);
    } else {
      user = null;
    }
  }
}
