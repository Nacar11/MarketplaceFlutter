// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/shoppingcart.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

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
      backgroundColor: MPColors.buttonPrimary,
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

class SignUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignUpAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        MPTexts.getStarted,
        style: TextStyle(
          color: MPColors.textWhite,
          // Set the color to black
        ),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
          )),
      backgroundColor: MPColors.buttonPrimary,
      iconTheme: const IconThemeData(
        color: MPColors.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
