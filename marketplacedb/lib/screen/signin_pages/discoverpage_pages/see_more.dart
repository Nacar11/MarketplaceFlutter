import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:get/get.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:get/get.dart';

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
          category.category_name ?? 'Default Category Name',
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
          FutureBuilder<List<ProductCategoryModel>>(
            future: controller
                .getProductCategories(), // Replace with your actual fetch method
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Display a loading indicator
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Display an error message
              } else {
                return Column(
                  children: [
                    for (final category in category.children ?? [])
                      InkWell(
                        onTap: () {
                          // Handle the click action
                        },
                        child: ListTile(
                          title: Text(category.category_name ??
                              "Error on Handling API Responses"),
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
