import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_page_controller.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/billing_address_setup/billing_address_setup.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  MPLocalStorage localStorage = MPLocalStorage();
  final userController = Get.put(UserController());
  final productController = Get.put(ProductController());
  final productItemController = Get.put(ProductItemController());
  final navigationController = Get.put(NavigationController());
  final favoritesPageController = Get.put(FavoritesPageController());
  final shoppingCartPageController = Get.put(ShoppingCartPageController());
  final homePageController = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    print(localStorage.readData('token'));
    print(localStorage.readData('userID'));

    // if (widget.hasSnackbar != '') {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     switch (widget.hasSnackbar) {
    //       case 'welcomeMessage':
    //         showWelcomeMessageSnackBar();
    //         break;
    //       case 'listingAdded':
    //         successSnackBar(context, MPTexts.productListed, MPTexts.success);
    //         break;
    //       case 'addedTocart':
    //         successSnackBar(context, MPTexts.itemAddedToCart, MPTexts.success);
    //         break;
    //       default:
    //     }
    //   });
    // }
  }

  @override
  void dispose() {
    productItemController.dispose();
    navigationController.dispose();
    productController.dispose();
    favoritesPageController.dispose();
    shoppingCartPageController.dispose();
    print("disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: navigationController.index.value,
          onDestinationSelected: (index) async {
            if (index == 2) {
              await userController.userHasAddress();
              if (userController.userHasAddressValue.value == false) {
                Get.to(() => const BillingAddressSetup());
                navigationController.index.value = 0;
              } else {
                setState(() {
                  navigationController.index.value = index;
                });
              }
            } else {
              setState(() {
                navigationController.index.value = index;
              });
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home4), label: 'home'),
            NavigationDestination(
                icon: Icon(Iconsax.search_favorite), label: 'Discover'),
            NavigationDestination(icon: Icon(Iconsax.shop_add), label: 'Sell'),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Favorites'),
            NavigationDestination(
                icon: Icon(Iconsax.profile_tick), label: 'Me'),
          ]),
      //
      body: Obx(
          () => navigationController.screens[navigationController.index.value]),
    );
  }
}
