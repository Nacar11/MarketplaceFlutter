import 'package:flutter/material.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/productController.dart';

final controller = Get.put<ProductController>(ProductController());

class CategoryListPage extends StatefulWidget {
  final ProductCategoryModel category;
  const CategoryListPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryListPage> createState() =>
      // ignore: no_logic_in_create_state
      CategoryListPageState(category: category);
}

class CategoryListPageState extends State<CategoryListPage> {
  final ProductCategoryModel category;
  CategoryListPageState({required this.category});

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
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: Colors.grey,
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
