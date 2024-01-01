// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/shoppingcart.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => SearchAppBarState();
}

final searchController = TextEditingController();

class SearchAppBarState extends State<SearchAppBar> {
  // @override
  // void dispose() {
  //   // Dispose of the controller when no longer needed to prevent memory leaks.
  //   searchController.dispose();
  //   super.dispose();
  // }

  void shoppingCartButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Shoppingcart()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 116, 78, 255),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            shoppingCartButton(context);
          },
        )
      ],
      title: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: SearchAppBarDelegate());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          child: const Row(
            children: [
              Icon(
                Icons.search, // Replace with your desired icon
                color: Colors.grey, // Change icon color as needed
              ),
              SizedBox(width: 8), // Adjust spacing between icon and text
              Expanded(
                child: Text(
                  'Search for products or users',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              // You can add an icon here if needed
            ],
          ),
        ),
      ),
    );
  }
}

class SearchAppBarDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        },
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        )
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['Tees', 'Dresses', 'Underwear'];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
            },
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) => Center(
      child: Text(query,
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)));
}



  // CustomSearchDelegate({this.initialQuery = ''});
  // List<String> searchTerms = [
  //   'jeans',
  //   'shirt',
  //   'polo',
  //   'polo shirt',
  //   'shoes',
  // ];

  // @override
  // List<Widget> buildActions(BuildContext context) {
  //   return [
  //     IconButton(
  //         onPressed: () {
  //           query = '';
  //         },
  //         icon: const Icon(Icons.clear)),
  //   ];
  // }

  // @override
  // Widget buildLeading(BuildContext context) {
  //   return IconButton(
  //     onPressed: () {
  //       close(context, null);
  //     },
  //     icon: const Icon(Icons.arrow_back),
  //   );
  // }

  // @override
  // Widget buildResults(BuildContext context) {
  //   List<String> matchQuery = [];
  //   for (var clothes in searchTerms) {
  //     if (clothes.toLowerCase().contains(query.toLowerCase())) {
  //       matchQuery.add(clothes);
  //     }
  //   }
  //   return ListView.builder(
  //     itemCount: matchQuery.length,
  //     itemBuilder: (context, index) {
  //       var result = matchQuery[index];
  //       return ListTile(
  //         title: Text(result),
  //       );
  //     },
  //   );
  // }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   List<String> matchQuery = [];
  //   for (var clothes in searchTerms) {
  //     if (clothes.toLowerCase().contains(query.toLowerCase())) {
  //       matchQuery.add(clothes);
  //     }
  //   }
  //   return ListView.builder(
  //     itemCount: matchQuery.length,
  //     itemBuilder: (context, index) {
  //       var result = matchQuery[index];
  //       return ListTile(
  //         title: Text(result),
  //       );
  //     },
  //   );
  // }

