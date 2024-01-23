// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddressSetup.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class Navigation extends StatefulWidget {
  final String? hasSnackbar;

  const Navigation({Key? key, this.hasSnackbar}) : super(key: key);
  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  MPLocalStorage localStorage = MPLocalStorage();
  final userController = Get.put(UserController());
  final productController = Get.put(ProductController());
  final productItemController = Get.put(ProductItemController());
  final navigationController = Get.put(NavigationController());

  @override
  void initState() {
    super.initState();
    print(localStorage.readData('token'));
    print(localStorage.readData('userID'));

    if (widget.hasSnackbar != '') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        switch (widget.hasSnackbar) {
          case 'welcomeMessage':
            showWelcomeMessageSnackBar();
            break;
          case 'listingAdded':
            successSnackBar(context, MPTexts.productListed, MPTexts.success);
            break;
          case 'addedTocart':
            successSnackBar(context, MPTexts.itemAddedToCart, MPTexts.success);
            break;
          default:
        }
      });
    }
  }

  void showWelcomeMessageSnackBar() {
    String text = 'Welcome, ${localStorage.readData('username')}';
    successSnackBar(context, text, MPTexts.successLogin);
  }

  @override
  void dispose() {
    productItemController.dispose();
    navigationController.dispose();
    productController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: navigationController.index.value,
          onDestinationSelected: (index) async {
            if (index == 2) {
              if (userController.userHasAddressValue.value == true) {
                Get.to(() => const BillingAddressSetUp());
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
            NavigationDestination(icon: Icon(Icons.home), label: 'home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Discover'),
            NavigationDestination(
                icon: Icon(Iconsax.buy_crypto), label: 'Sell'),
            NavigationDestination(icon: Icon(Icons.mail), label: 'Messages'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Me'),
          ]),
      //
      body: Obx(
          () => navigationController.screens[navigationController.index.value]),
    );
  }
}
