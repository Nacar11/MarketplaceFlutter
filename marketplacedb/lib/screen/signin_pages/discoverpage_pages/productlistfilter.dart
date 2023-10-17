// ignore_for_file: unused_import
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/productitempage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/Customappbar.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listitem.dart';

final controller = Get.put<ProductController>(ProductController());

class Filterpage extends StatefulWidget {
  final int productType;
  final String productTypeName; // Add this line

  const Filterpage({
    Key? key,
    required this.productType,
    required this.productTypeName, // Add this parameter
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Filterpage> createState() => FilterpageState(
      productType: productType, productTypeName: productTypeName);
}

final searchController = TextEditingController();

class FilterpageState extends State<Filterpage> {
  int index = 0;
  final int productType;
  final String productTypeName;
  FilterpageState({required this.productType, required this.productTypeName});

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
        body: FutureBuilder<List<ProductItemModel>>(
            future: controller.getProductItemsByProductType(
              productType: productType,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  strokeWidth: 3.0, // Adjust the stroke width as needed
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // Set the desired color
                );
                // Display a loading indicator
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Display an error message
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < snapshot.data!.length) {
                      final item = snapshot.data![index];
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
                                  final product = Product(
                                    imageUrls: item.product_images!
                                        .map((image) => image.product_image!)
                                        .toList(),
                                    price: item.price!,
                                  );

                                  // Perform the desired action when tapped
                                  // For example, navigate to a new page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductItemPage(
                                        product: product,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    if (hasImage)
                                      Image.network(
                                        item.product_images![0].product_image!,
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
                  itemCount: snapshot.data!.length,
                );
              }
            }),
      ),
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
