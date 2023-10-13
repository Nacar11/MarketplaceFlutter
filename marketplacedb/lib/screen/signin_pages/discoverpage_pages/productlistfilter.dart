// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/Customappbar.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/models/ProductItemModel.dart';

final controller = Get.put<ProductController>(ProductController());

class Filterpage extends StatefulWidget {
  final int productType; // Add this line

  const Filterpage({
    Key? key,
    required this.productType, // Add this parameter
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Filterpage> createState() => FilterpageState(productType: productType);
}

final searchController = TextEditingController();

class FilterpageState extends State<Filterpage> {
  int index = 0;
  final int productType;
  FilterpageState({required this.productType});

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
        body: FutureBuilder<List<ProductItemModel>>(
            future: controller.getProductItemsByProductType(
                productType: productType),
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
                return ListView(
                  children: <Widget>[
                    for (final item in snapshot.data!)
                      Column(
                        children: <Widget>[
                          Container(
                            height:
                                3, // Adjust the height to make the line thicker
                            color: Colors.grey, // Adjust the color as needed
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Headertext(text: item.SKU ?? 'asd'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Headertext(
                                      text: item.product!.name ?? 'asd'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Headertext(
                                      text:
                                          'Php ${item.price!.toStringAsFixed(2)}'),
                                ),
                                Column(
                                  children: <Widget>[
                                    for (final product_image
                                        in item.product_images!)
                                      Image.network(
                                        product_image
                                            .product_image!, // Replace with the actual URL property
                                        width: 100, // Set the desired width
                                        height: 100, // Set the desired height
                                        fit: BoxFit
                                            .cover, // Adjust the fit as needed
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
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
