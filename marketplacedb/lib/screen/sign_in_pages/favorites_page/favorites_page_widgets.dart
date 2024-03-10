import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:marketplacedb/data/models/products/product_item_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

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

class NoFavoritesDisplay extends StatelessWidget {
  const NoFavoritesDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Center(
          child: AnimationContainer(
              forever: true,
              width: 1,
              height: 0.3,
              animation: AnimationsUtils.favorites,
              duration: Duration(seconds: 4)),
        ),
        const SizedBox(height: MPSizes.spaceBtwSections),
        Text(
          MPTexts.favoritesPageTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        Text(
          MPTexts.favoritesPageSubTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
