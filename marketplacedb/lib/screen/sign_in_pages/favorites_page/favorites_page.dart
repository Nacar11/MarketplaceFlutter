import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

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
      body: Obx(() {
        return favoritesPageController.favoriteProductItems.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: Column(
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
                ),
              )
            : const MPFavoritesList();
      }),
    );
  }
}
