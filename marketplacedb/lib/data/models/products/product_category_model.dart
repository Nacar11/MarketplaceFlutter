class ProductCategoryModel {
  int? id;
  String? categoryName;
  String? productImage;
  int? categoryId;
  List<ProductCategoryModel>? children;

  ProductCategoryModel(
      {this.id,
      this.categoryName,
      this.categoryId,
      this.children,
      this.productImage});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    productImage = json['product_image'];
    if (json['children'] != null) {
      children = (json['children'] as List<dynamic>)
          .map((e) => ProductCategoryModel.fromJson(e))
          .toList();
    } else {
      children = <ProductCategoryModel>[];
    }
  }
}
