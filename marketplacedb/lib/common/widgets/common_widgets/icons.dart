import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/screen/signin_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ShoppingCartCounterIcon extends StatelessWidget {
  const ShoppingCartCounterIcon({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag,
              color: MPHelperFunctions.isDarkMode(context)
                  ? MPColors.white
                  : MPColors.dark)),
      Positioned(
        right: 0,
        child: Container(
            width: MPSizes.circularBadgeSize,
            height: MPSizes.circularBadgeSize,
            decoration: BoxDecoration(
                color: MPColors.black,
                borderRadius: BorderRadius.circular(
                  MPSizes.circularBadgeSize,
                )),
            child: Center(
                child: Text('2',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: MPColors.white)))),
      )
    ]);
  }
}

class MPCircularIcon extends StatelessWidget {
  const MPCircularIcon(
      {super.key, required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(icon,
              color: MPHelperFunctions.isDarkMode(context)
                  ? MPColors.white
                  : MPColors.dark)),
    ]);
  }
}

FavoritesPageController favoritesPageController =
    FavoritesPageController.instance;

class FavoritesIconButton extends StatelessWidget {
  const FavoritesIconButton({
    super.key,
    required this.productItemDataId,
    required this.iconSize,
  });

  final int productItemDataId;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
        onPressed: () {
          bool isFavorite = favoritesPageController.favoriteProductItems
              .any((favoriteItem) => favoriteItem.id == productItemDataId);

          // Perform actions based on whether it's a favorite or not
          if (isFavorite) {
            // The product item is in the favorites list
            // You can handle removing it from favorites or any other action
            favoritesPageController.removeFromFavorites(productItemDataId);
          } else {
            // The product item is not in the favorites list
            // You can handle adding it to favorites or any other action
            favoritesPageController.addToFavorites(productItemDataId);
          }
        },
        icon: Icon(
          Iconsax.heart5,
          size: iconSize,
          color: favoritesPageController.favoriteProductItems
                  .any((favoriteItem) => favoriteItem.id == productItemDataId)
              ? Colors.red // Red color if it's a favorite
              : null,
        )));
  }
}
