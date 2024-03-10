import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

FavoritesPageController favoritesPageController =
    FavoritesPageController.instance;

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = NavigationController.instance;
    return Scaffold(
      appBar: PrimarySearchAppBar(
          showBackArrow: false,
          actions: [
            MPCircularIcon(
                onPressed: () {
                  navigationController.index.value = 1;
                  Get.to(() => const Navigation());
                },
                icon: Iconsax.add)
          ],
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Favorites",
                style: Theme.of(context).textTheme.headlineMedium),
          ])),
      body: Obx(() => favoritesPageController.favoriteProductItems.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(MPSizes.defaultSpace),
              child: NoFavoritesDisplay(),
            )
          : const MPFavoritesList()),
    );
  }
}
