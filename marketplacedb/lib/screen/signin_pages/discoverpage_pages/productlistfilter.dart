// ignore_for_file: unused_import, avoid_print
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/productitempage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/controllers/products/ProductItemController.dart';
import 'package:marketplacedb/controllers/products/ProductController.dart';

import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listitem.dart';

final productItemController =
    Get.put<ProductItemController>(ProductItemController());
final productController = Get.put<ProductController>(ProductController());

class Filterpage extends StatefulWidget {
  final String? hasSnackbar;

  final String productTypeName; // Add this line

  const Filterpage(
      {Key? key,
      required this.productTypeName,
      this.hasSnackbar // Add this parameter
      })
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Filterpage> createState() => FilterpageState(
      productTypeName: productTypeName, hasSnackbar: hasSnackbar ?? '');
}

final searchController = TextEditingController();

class FilterpageState extends State<Filterpage> {
  final String? hasSnackbar;
  int index = 0;

  final String productTypeName;
  FilterpageState({required this.productTypeName, this.hasSnackbar});

  void submitSearch() {
    final query = searchController.text;
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(initialQuery: query), // Pass the query
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.productTypeName),
          ),
          body: Obx(() {
            return productItemController.isLoading.value == true
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of items per row
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index <
                          productItemController.productItemList.length) {
                        final item =
                            productItemController.productItemList[index];
                        // Check if there is an image URL
                        final hasImage = item.product_images != null &&
                            item.product_images!.isNotEmpty &&
                            item.product_images![0].product_image != null;

                        return Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Material(
                                color: Colors
                                    .transparent, // Make the Material widget transparent
                                child: InkWell(
                                  onTap: () {
                                    // final product = ProductItemModel(
                                    //   product_images: item.product_images!
                                    //       .map((image) => image.product_image!)
                                    //       .toList(),
                                    //   price: item.price!,
                                    // );

                                    // Perform the desired action when tapped
                                    // For example, navigate to a new page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductItemPage(
                                                product: item,
                                              )),
                                    ).then((selectedData) async {
                                      print(selectedData);
                                      if (selectedData == true) {
                                        showSuccessSnackBar(
                                          context,
                                          'Your Product has been deleted.',
                                          'Success',
                                        );
                                      }
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      if (hasImage)
                                        Image.network(
                                          item.product_images![0]
                                              .product_image!,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Container(
                                          color: Colors.black.withOpacity(0.7),
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            'Php ${item.price!.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      } else {
                        return Container(); // Placeholder for items that are beyond the list length
                      }
                    },
                    itemCount: productItemController.productItemList.length,
                  );
          })),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final String initialQuery;

  CustomSearchDelegate({this.initialQuery = ''});
  List<String> searchTerms = [
    'jeans',
    'shirt',
    'polo',
    'polo shirt',
    'shoes',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var clothes in searchTerms) {
      if (clothes.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(clothes);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var clothes in searchTerms) {
      if (clothes.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(clothes);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
