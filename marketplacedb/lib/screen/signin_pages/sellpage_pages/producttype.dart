// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/products/ProductController.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';

final controller = Get.put<ProductController>(ProductController());

class ProductTypePage extends StatefulWidget {
  final String categoryName;
  const ProductTypePage({Key? key, required this.categoryName})
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<ProductTypePage> createState() =>
      // ignore: no_logic_in_create_state
      ProductTypePageState(categoryName: categoryName);
}

class ProductTypePageState extends State<ProductTypePage> {
  final String categoryName;
  final productController = ProductController();
  ProductTypePageState({required this.categoryName});

  @override
  void initState() {
    super.initState();
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
        body: Obx(() {
          return controller.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : Column(
                  children: [
                    for (final productType in controller.productTypes)
                      ExpansiontileButton(
                          text: (productType.name ??
                              "Error on Handling API Responses"),
                          onTap: () {
                            Navigator.of(context).pop(productType);
                          }),
                  ],
                );
        }));
  }
}
