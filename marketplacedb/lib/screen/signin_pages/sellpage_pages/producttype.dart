import 'package:flutter/material.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/controllers/productController.dart';

class ProductTypePage extends StatefulWidget {
  final int productCategoryId;

  const ProductTypePage({Key? key, required this.productCategoryId})
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<ProductTypePage> createState() =>
      // ignore: no_logic_in_create_state
      ProductTypePageState(productCategoryId: productCategoryId);
}

class ProductTypePageState extends State<ProductTypePage> {
  final int productCategoryId;
  final productController = ProductController();
  ProductTypePageState({required this.productCategoryId});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
