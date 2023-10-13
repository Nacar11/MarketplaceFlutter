// ignore_for_file: unused_import

import 'package:flutter/material.dart';
// import 'package:marketplacedb/config/icons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/Customappbar.dart';

class Filterpage extends StatefulWidget {
  final String productType; // Add this line

  const Filterpage({
    Key? key,
    required this.productType, // Add this parameter
  }) : super(key: key);

  @override
  State<Filterpage> createState() => FilterpageState();
}

final searchController = TextEditingController();

class FilterpageState extends State<Filterpage> {
  int index = 0;

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
          toolbarHeight: 80,
          centerTitle: true,
          title: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(children: [
                  Text(
                    widget.productType,
                    style: const TextStyle(fontSize: 30),
                  ),
                ]),
              ),
              Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
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
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // Handle the shopping cart action here
                    },
                  ),
                ],
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
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Headertext(text: 'Suggested for you'),
                      ),
                      // Sidetext(text: 'see more'),
                    ],
                  ),
                ),
              ],
            ),
            const Homepagecon(),
            const Headertext(text: 'Recommended Sellers'),
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
            const Homepagecon(),
            const Homepagecon(),
            const Homepagecon(),
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
