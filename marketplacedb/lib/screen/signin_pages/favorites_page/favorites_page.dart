import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_page.dart';
import 'package:marketplacedb/screen/signin_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

// FavoritesPage

FavoritesPageController favoritesPageController =
    FavoritesPageController.instance;

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimarySearchAppBar(
            showBackArrow: false,
            actions: [
              MPCircularIcon(
                  onPressed: () {
                    Get.to(const HomePage());
                  },
                  icon: Iconsax.add)
            ],
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Favorites",
                  style: Theme.of(context).textTheme.headlineMedium),
            ])),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: Column(children: [
                  MPGridLayout(
                      itemCount:
                          favoritesPageController.favoriteProductItems.length,
                      itemBuilder: (_, index) {
                        ProductItemModel favoriteProductItem =
                            favoritesPageController.favoriteProductItems[index];
                        return MPProductCardVertical(
                            productItemData: favoriteProductItem);
                      })
                ]))));
  }
}
