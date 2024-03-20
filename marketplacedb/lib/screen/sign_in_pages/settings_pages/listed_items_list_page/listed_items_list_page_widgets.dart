import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/styles/shadows.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/layouts/list_view_layout.dart';
import 'package:marketplacedb/common/widgets/texts/product_price_text.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/controllers/order_process/order_line_controller.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';
import 'package:marketplacedb/data/models/product/product_item_model.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_item_page/product_item_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/billing_address_setup/billing_address_setup.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/listed_items_list_page/listed_items_list_page_controller.dart';
import 'package:marketplacedb/util/constants/app_animations.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

class MPNoListedItemsDisplay extends StatelessWidget {
  const MPNoListedItemsDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = NavigationController.instance;
    UserController userController = UserController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Center(
          child: AnimationContainer(
              forever: false,
              width: 1,
              height: 0.3,
              animation: AnimationsUtils.onboardingAnimation3,
              duration: Duration(seconds: 4)),
        ),
        const SizedBox(height: MPSizes.spaceBtwSections),
        Text(
          MPTexts.userListedItemsTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        Text(
          MPTexts.userListedItemsSubTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: MPSizes.spaceBtwItems),
        MPPrimaryButton(
          text: 'Start Selling',
          onPressed: () async {
            await userController.userHasAddress();
            if (userController.userHasAddressValue.value == false) {
              Get.to(() => const BillingAddressSetup());
            } else {
              navigationController.index.value = 2;
              Get.to(() => const Navigation());
            }
          },
        )
      ],
    );
  }
}

class MPListedItems extends StatelessWidget {
  const MPListedItems({super.key});

  @override
  Widget build(BuildContext context) {
    ListedItemsListPageController controller =
        ListedItemsListPageController.instance;
    return SingleChildScrollView(
      child: Column(children: [
        Obx(() => MPListViewLayout(
              itemCount: controller.listedItemsList.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: MPSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                ProductItemModel listedItem = controller.listedItemsList[index];
                return MPSingleListedItem(productItemData: listedItem);
              },
            ))
      ]),
    );
  }
}

class MPSingleListedItem extends StatelessWidget {
  const MPSingleListedItem({super.key, required this.productItemData});

  final ProductItemModel productItemData;
  @override
  Widget build(BuildContext context) {
    ListedItemsListPageController controller =
        ListedItemsListPageController.instance;
    OrderLineController orderLineController = OrderLineController.instance;
    ProductItemController productItemController =
        ProductItemController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [MPShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(MPSizes.productImageRadius),
            color: dark ? MPColors.darkerGrey : MPColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  Get.to(() => const ProductItemPage());
                  await productItemController
                      .getSingleProductItemDetail(productItemData.id!);
                },
                child: MPCircularContainer(
                    height: 150,
                    padding: const EdgeInsets.all(MPSizes.sm),
                    backgroundColor: dark ? MPColors.dark : MPColors.light,
                    child: MPRoundedImage(
                      imageUrl: productItemData.productImages![0].productImage!,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    )),
              ),
            ),
            const SizedBox(width: MPSizes.spaceBtwItems),
            SizedBox(
              width: 120,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: MPSizes.sm, left: MPSizes.sm),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MPProductTitleText(
                                  title: productItemData.product!.name!,
                                  smallSize: true),
                              const SizedBox(height: MPSizes.spaceBtwItems / 2),
                              CategoryNameWithCheckIcon(
                                textStyle:
                                    Theme.of(context).textTheme.labelMedium!,
                                text: productItemData
                                    .product!.productCategory!.categoryName!,
                              ),
                              const SizedBox(height: MPSizes.spaceBtwItems),
                              const MPProductTitleText(
                                  title: 'Status:', smallSize: true),
                              const SizedBox(height: MPSizes.xs),
                              Row(
                                children: [
                                  const Icon(Iconsax.verify4,
                                      color: Colors.green,
                                      size: MPSizes.iconSm),
                                  const SizedBox(width: MPSizes.xs),
                                  Expanded(
                                      child: orderLineController.orderLineList
                                              .any((orderLineItem) =>
                                                  orderLineItem
                                                      .productItem?.id ==
                                                  productItemData.id!)
                                          ? Text('Available',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                              overflow: TextOverflow.ellipsis)
                                          : Text('Available',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ])),
                    const SizedBox(height: MPSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MPProductPriceText(
                          price: productItemData.price.toString(),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                color: MPColors.dark,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(MPSizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        MPSizes.productImageRadius))),
                            child: SizedBox(
                                width: MPSizes.iconLg * 1.2,
                                height: MPSizes.iconLg * 1.2,
                                child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          orderLineController.orderLineList.any(
                                                  (orderLineItem) =>
                                                      orderLineItem
                                                          .productItem?.id ==
                                                      productItemData.id!)
                                              ? MPAlertDialog.openDialog(
                                                  context,
                                                  "Listed Item has been ordered",
                                                  "Another user has ordered your listed item, cannot remove item from the MarketPlace.",
                                                  [
                                                      MaterialButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text("Close",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!))
                                                    ])
                                              : MPAlertDialog.openDialog(
                                                  context,
                                                  "Remove Listed Item?",
                                                  "Are you sure you want to remove your listed item from the MarketPlace?",
                                                  [
                                                      MaterialButton(
                                                          onPressed: () {
                                                            MPAlertDialog
                                                                .popDialog();
                                                          },
                                                          child: Text("Cancel",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!)),
                                                      MaterialButton(
                                                          onPressed: () async {
                                                            MPAlertLoaderDialog
                                                                .openLoadingDialog();
                                                            await controller
                                                                .deleteListedItem(
                                                                    productItemData
                                                                        .id!);
                                                            MPAlertLoaderDialog
                                                                .stopLoading();
                                                            MPAlertDialog
                                                                .popDialog();
                                                          },
                                                          child: Text('Remove',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!))
                                                    ]);
                                        },
                                        icon: const Icon(Iconsax.trash),
                                        color: MPColors.white))))
                      ],
                    )
                  ]),
            )
          ],
        ));
  }
}
