import 'package:flutter/material.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/producttype.dart';

final controller = Get.put<ProductController>(ProductController());

// List<ProductCategoryModel> productCategoryList = controller.productCategoryList;

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Category List',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView(children: [
        Column(
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
                  List<ProductCategoryModel> productCategoryList =
                      snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final category in productCategoryList)
                          ExpansionTile(
                            title: Text(category.category_name ?? "asd"),
                            children: [
                              if (category.children != null)
                                for (final subcategory in category.children!)
                                  ListTile(
                                    title: Text(subcategory.category_name ??
                                        "Unnamed Subcategory"),
                                    onTap: () {
                                      // print(subcategory);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => ProductTypePage(
                                            productCategoryId: subcategory.id!,
                                            categoryName:
                                                subcategory.category_name!),
                                      ))
                                          .then((selectedData) {
                                        if (selectedData != null) {
                                          Navigator.of(context)
                                              .pop(selectedData);
                                        }
                                      });
                                      // Navigator.of(context).pop(subcategory);
                                    },
                                  ),
                            ],
                          ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ]),
    );
  }
}
