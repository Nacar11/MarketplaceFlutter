// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/models/ProductTypeModel.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/config/buttons.dart';

final controller = Get.put<ProductController>(ProductController());

class ProductTypePage extends StatefulWidget {
  final int productCategoryId;
  final String categoryName;
  const ProductTypePage(
      {Key? key, required this.categoryName, required this.productCategoryId})
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<ProductTypePage> createState() =>
      // ignore: no_logic_in_create_state
      ProductTypePageState(
          productCategoryId: productCategoryId, categoryName: categoryName);
}

class ProductTypePageState extends State<ProductTypePage> {
  final int productCategoryId;
  final String categoryName;
  final productController = ProductController();
  ProductTypePageState(
      {required this.productCategoryId, required this.categoryName});

  @override
  void initState() {
    super.initState();
    print(widget.productCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryName,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        body: FutureBuilder<List<ProductTypeModel>>(
          future: controller.getProductTypeByCategoryId(widget
              .productCategoryId), // Replace 5 with the dynamic category ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Error state
            } else {
              List<ProductTypeModel> productTypes = snapshot.data!;
              return Column(
                children: [
                  for (final productType in productTypes)
                    ExpansiontileButton(
                        text: (productType.name ??
                            "Error on Handling API Responses"),
                        onTap: () {
                          Navigator.of(context).pop(productType);
                        }),
                ],
              );
            }
          },
        ));
  }
}
