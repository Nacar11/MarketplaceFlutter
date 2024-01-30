import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

FavoritesPageController favoritesPageController =
    FavoritesPageController.instance;

class MPFavoritesList extends StatelessWidget {
  const MPFavoritesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MPSizes.sm),
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
