// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/shoppingcart.dart';

class CustomappBar extends StatefulWidget {
  const CustomappBar({Key? key}) : super(key: key);

  @override
  State<CustomappBar> createState() => CustomappBarState();
}

final searchController = TextEditingController();

class CustomappBarState extends State<CustomappBar> {
  // @override
  // void dispose() {
  //   // Dispose of the controller when no longer needed to prevent memory leaks.
  //   searchController.dispose();
  //   super.dispose();
  // }

  void submitSearch() {
    final query = searchController.text;
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(initialQuery: query), // Pass the query
    );
  }

  void shoppingcartButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Shoppingcart()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      automaticallyImplyLeading: false,
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
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ), // Add the shopping cart icon
            onPressed: () {
              shoppingcartButton(context);
            },
          ),
        ],
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
