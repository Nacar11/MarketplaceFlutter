import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/data/models/shopping_cart_item_model.dart';
import 'package:marketplacedb/screen/signin_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/screen/signin_pages/shopping_cart_page/shopping_cart_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ShoppingCartPageController controller = ShoppingCartPageController.instance;
    return Scaffold(
        bottomNavigationBar: const Padding(
            padding: EdgeInsets.all(MPSizes.defaultSpace),
            child: CheckOutButton()),
        appBar: PrimarySearchAppBar(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Cart", style: Theme.of(context).textTheme.headlineMedium),
        ])),
        body: Obx(() => SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(MPSizes.defaultSpace),
                child: MPListViewLayout(
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
