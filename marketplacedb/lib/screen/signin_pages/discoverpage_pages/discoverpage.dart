import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';

class CardItem {
  final String urlImage;

  const CardItem({
    required this.urlImage,
  });
}

final controller = Get.put<ProductController>(ProductController());
List<ProductCategoryModel> productCategoryList = controller.productCategoryList;

class Discoverpage extends StatefulWidget {
  const Discoverpage({Key? key}) : super(key: key);

  @override
  State<Discoverpage> createState() => DiscoverpageState();
}

class DiscoverpageState extends State<Discoverpage> {
  final searchController = TextEditingController();
  // String valueChoose = '';
  // List listItem = [
  //   "item 1",
  //   "item 2",
  //   "item 3",
  //   "item 4",
  // ];

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.
    searchController.dispose();
    super.dispose();
  }

  void submitSearch() {
    final query = searchController.text;
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(initialQuery: query), // Pass the query
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              const Icon(Icons.search),
              const SizedBox(width: 8), // Add some spacing
              Expanded(
                child: TextField(
                  controller: searchController,
                  onSubmitted: (_) => submitSearch(),
                  decoration: const InputDecoration(
                    hintText: 'Search for products or users',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ), // Add the shopping cart icon
                onPressed: () {
                  // Handle the shopping cart action here
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 3, // Adjust the height to make the line thicker
                  color: Colors.grey, // Adjust the color as needed
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Headertext(text: 'Womens Wear'),
                    ),
                    // Sidetext(text: 'see all'),
                  ],
                ),
              ],
            ),
            const Womenswear(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Headertext(text: 'Mens Wear'),
                ),
                // Sidetext(text: 'see more'),
              ],
            ),
            const Homepagecon(),
            const Homepagecon(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Headertext(text: 'Our Picks'),
                ),
                // Sidetext(text: 'see more'),
              ],
            ),
            const Homepagecon(),
            const Womenswear(),
            const Homepagecon(),
            const Womenswear(),

//  Column(
//   children: [
//     for (final category in productCategoryList)
//       ExpansionTile(
//         title: Text(category.category_name ?? "asd"),
//         children: [
//           for (final subcategory in category.children ?? [])
//             ListTile(
//               title: Text(subcategory.category_name ?? "Unnamed Subcategory"),
//               onTap: () {
//                 // Handle the tap on the subcategory here
//               },
//             ),
//         ],
//       ),
//   ],
// )
            Column(
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
                            onTap: () {},
                          ),
                    ],
                  ),
              ],
            )
            // Center(
            //     child: Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: DropdownButton(
            //     hint: const Text('Jewelry'),
            //     dropdownColor: Colors.grey,
            //     icon: const Icon(Icons.arrow_drop_down),
            //     iconSize: 36,
            //     isExpanded: true,
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 22,
            //     ),
            //     value: valueChoose,
            //     onChanged: (newValue) {
            //       setState(() {
            //         valueChoose = newValue as String;
            //       });
            //     },
            //     items: listItem.map((valueItem) {
            //       return DropdownMenuItem(
            //         value: valueItem,
            //         child: Text(valueItem),
            //       );
            //     }).toList(),
            //   ),
            // )),
          ],
        ),
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
