// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/productlistfilter.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/producttype.dart';
import 'package:marketplacedb/models/ProductTypeModel.dart';

import 'package:get/get.dart';

final controller = Get.put<ProductController>(ProductController());

class TypePage extends StatefulWidget {
  final int productCategoryId;
  final String categoryName;

  const TypePage({
    Key? key,
    required this.categoryName,
    required this.productCategoryId,
  }) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<TypePage> createState() => TypePageState(
      productCategoryId: productCategoryId, categoryName: categoryName);
}

class TypePageState extends State<TypePage> {
  final int productCategoryId;
  final String categoryName;
  final productController = ProductController();
  TypePageState({required this.productCategoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          FutureBuilder<List<ProductTypeModel>>(
            future: controller.getProductTypeByCategoryId(widget
                .productCategoryId), // Replace with your actual fetch method
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Display a loading indicator
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Display an error message
              } else {
                List<ProductTypeModel> productTypes = snapshot.data!;

                return Column(
                  children: [
                    for (final productType in productTypes)
                      InkWell(
  onTap: () {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Filterpage(
        productType: productType.id!,
        productTypeName: productType.name ?? "Error on Handling API Responses",
      ),
    ));
  },
  child: ListTile(
    title: Text(productType.name ?? "Error on Handling API Responses"),
  ),
)
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
