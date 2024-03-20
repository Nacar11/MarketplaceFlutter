import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ShoppingCartCounterIcon extends StatelessWidget {
  const ShoppingCartCounterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserController controller = UserController.instance;
    return Stack(children: [
      IconButton(
          onPressed: () {
            Get.to(() => const ShoppingCartPage());
          },
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
                child: Obx(() => Text(
                    controller.shoppingCartItemList.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: MPColors.white))))),
      )
    ]);
  }
}

class MPCircularIcon extends StatelessWidget {
  const MPCircularIcon(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.width,
      this.height,
      this.size = MPSizes.lg,
      this.color,
      this.backgroundColor});

  final VoidCallback onPressed;
  final IconData icon;
  final double? width, height, size;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor != null
              ? backgroundColor!
              : MPHelperFunctions.isDarkMode(context)
                  ? MPColors.black.withOpacity(0.9)
                  : MPColors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color, size: size),
        ));
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
