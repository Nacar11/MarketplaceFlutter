import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/data/models/shopping_cart_item_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingCartPageController controller = ShoppingCartPageController.instance;
    return Scaffold(
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(MPSizes.defaultSpace),
            child: Obx(() => CheckOutButton(
                text:
                    "To Checkout  ${controller.shoppingCartItemListTotalPrice.value}",
                isDisabled: controller
                    .shoppingCartItemListSelectedToCheckout.isEmpty))),
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
        ])),
        body: Obx(() => SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: controller.shoppingCartItemList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MPSizes.defaultSpace),
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
                              MPTexts.shoppingCartPageTitle,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: MPSizes.spaceBtwItems),
                            Text(
                              MPTexts.shoppingCartPageSubTitle,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      )
                    : MPListViewLayout(
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: MPSizes.spaceBtwSections),
                        itemBuilder: (_, index) {
                          ShoppingCartItemModel shoppingCartItem =
                              controller.shoppingCartItemList[index];
                          return SingleCartItemWithFunctionality(
                              cartItem: shoppingCartItem);
                        },
                        itemCount: controller.shoppingCartItemList.length)))));
  }
}
