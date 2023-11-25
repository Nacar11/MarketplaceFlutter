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

class ProductTypePage extends StatefulWidget {
  final String categoryName;

  const ProductTypePage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);
  @override
  State<ProductTypePage> createState() =>
      // ignore: no_logic_in_create_state
      ProductTypePageState(categoryName: categoryName);
}

class ProductTypePageState extends State<ProductTypePage> {
  final String categoryName;
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Column(
                      children: [
                        for (final productType in controller.productTypes)
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Filterpage(
                                  productType: productType.id!,
                                  productTypeName: productType.name ??
                                      "Error on Handling API Responses",
                                ),
                              ));
                            },
                            child: ListTile(
                              title: Text(productType.name ??
                                  "Error on Handling API Responses"),
                            ),
                          )
                      ],
                    ),
                  ],
                );
        }));
  }
}
