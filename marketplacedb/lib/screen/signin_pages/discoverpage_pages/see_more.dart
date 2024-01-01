// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/controllers/products/ProductController.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/productTypepage.dart';

final controller = Get.put<ProductController>(ProductController());

class Seemore extends StatefulWidget {
  final ProductCategoryModel category;
  const Seemore({Key? key, required this.category}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Seemore> createState() => SeemoreState(category: category);
}

class SeemoreState extends State<Seemore> {
  final ProductCategoryModel category;
  SeemoreState({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.category_name!,
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
          Column(
            children: [
              for (final category in category.children ?? [])
                InkWell(
                  onTap: () {
                    controller.productTypeID = category.id;
                    controller.getProductTypeByCategoryId();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductTypePage(
                          categoryName: category.category_name!),
                    ));
                    // Handle the click action
                  },
                  child: ListTile(
                    title: Text(category.category_name ??
                        "Error on Handling API Responses"),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
