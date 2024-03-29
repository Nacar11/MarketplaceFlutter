// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/device/device_utility.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class MPSearchContainer extends StatelessWidget {
  const MPSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MPSizes.defaultSpace),
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: SearchAppBarDelegate());
        },
        child: Container(
            width: MPDeviceUtils.getScreenWidth(),
            padding: const EdgeInsets.all(MPSizes.inputFieldRadius),
            decoration: BoxDecoration(
                color: showBackground
                    ? dark
                        ? MPColors.dark
                        : MPColors.light
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(MPSizes.cardRadiusLg),
                border: showBorder
                    ? dark
                        ? Border.all(color: MPColors.light)
                        : Border.all(color: MPColors.dark)
                    : null),
            child: Row(children: [
              Icon(icon, color: dark ? MPColors.white : MPColors.darkerGrey),
              const SizedBox(width: MPSizes.spaceBtwInputFields),
              Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ])),
      ),
    );
  }
}

class PrimarySearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PrimarySearchAppBar(
      {super.key,
      this.title,
      this.showBackArrow = true,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: showBackArrow
                ? IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Iconsax.arrow_left))
                : leadingIcon != null
                    ? IconButton(
                        onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                    : null,
            title: title,
            actions: actions != null
                ? [
                    Padding(
                        padding: const EdgeInsets.only(
                            right: MPSizes.md, top: MPSizes.xs),
                        child: Column(children: actions!))
                  ]
                : null));
  }

  @override
  Size get preferredSize => Size.fromHeight(MPDeviceUtils.getAppBarHeight());
}

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => SearchAppBarState();
}

final searchController = TextEditingController();

class SearchAppBarState extends State<SearchAppBar> {
  void shoppingCartButton(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ShoppingCartPage()));
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
                Icons.search,
                color: Colors.grey,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Search for products or users',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
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

class PrimaryAppBarColored extends StatelessWidget
    implements PreferredSizeWidget {
  const PrimaryAppBarColored({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
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

class SignUpAppBarBackToHomeScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const SignUpAppBarBackToHomeScreen({Key? key}) : super(key: key);

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
            Get.offAll(() => const FrontPage());
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

class AppBarBackToHomeScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarBackToHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Get.offAll(() => const FrontPage());
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
