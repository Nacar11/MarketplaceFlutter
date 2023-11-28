import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:marketplacedb/controllers/products/ProductController.dart';
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
        body: Obx(() {
          return controller.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )
              : ListView(children: [
                  Column(
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
                          for (final category in controller.productCategoryList)
                            ExpansionTile(
                              title: Text(category.category_name!),
                              children: [
                                if (category.children != null)
                                  for (final subcategory in category.children!)
                                    ListTile(
                                      title: Text(subcategory.category_name!),
                                      onTap: () {
                                        controller.productTypeID =
                                            subcategory.id;
                                        controller.getProductTypeByCategoryId();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ProductTypePage(
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
                    ],
                  ),
                ]);
        }));
  }
}
