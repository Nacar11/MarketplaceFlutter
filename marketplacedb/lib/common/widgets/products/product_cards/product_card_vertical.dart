import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/styles/shadows.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/product_price_text.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/common/widgets/texts/sale_tag.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user/user_controller.dart';
import 'package:marketplacedb/data/models/product/product_item_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_item_page/product_item_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

class MPProductCardVertical extends StatelessWidget {
  const MPProductCardVertical({
    super.key,
    required this.productItemData,
  });
  final ProductItemModel productItemData;

  @override
  Widget build(BuildContext context) {
    ProductItemController productItemController =
        ProductItemController.instance;
    UserController userController = UserController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Container(
        width: 180,
        height: 200,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [MPShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(MPSizes.productImageRadius),
            color: dark ? MPColors.darkerGrey : MPColors.white),
        child: Column(children: [
          GestureDetector(
            onTap: () async {
              Get.to(() => const ProductItemPage());
              await productItemController
                  .getSingleProductItemDetail(productItemData.id!);
            },
            child: MPCircularContainer(
                height: 180,
                padding: const EdgeInsets.all(MPSizes.sm),
                backgroundColor: dark ? MPColors.dark : MPColors.light,
                child: Stack(children: [
                  if (productItemData.productImages != null &&
                      productItemData.productImages!.isNotEmpty)
                    MPRoundedImage(
                      isNetworkImage: true,
                      padding: const EdgeInsets.only(top: MPSizes.xs),
                      applyImageRadius: true,
                      borderRadius: MPSizes.productImageRadius,
                      imageUrl: productItemData.productImages![0].productImage!,
                    ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    child: MPSaleTag(),
                  ),
                  Obx(() =>
                      userController.userData.value.id == productItemData.userId
                          ? const SizedBox()
                          : Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: dark
                                        ? MPColors.black.withOpacity(0.9)
                                        : MPColors.white.withOpacity(0.9),
                                  ),
                                  child: FavoritesIconButton(
                                      iconSize: MPSizes.iconXs,
                                      productItemDataId: productItemData.id!)),
                            ))
                ])),
          ),
          const SizedBox(height: MPSizes.spaceBtwItems / 2),
          Padding(
              padding: const EdgeInsets.only(left: MPSizes.sm),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MPProductTitleText(
                        title: productItemData
                            .product!.productCategory!.categoryName!,
                        smallSize: false),
                    const SizedBox(height: MPSizes.spaceBtwItems / 2),
                    CategoryNameWithCheckIcon(
                        textStyle: Theme.of(context).textTheme.labelMedium!,
                        text: productItemData.product!.name!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MPProductPriceText(
                            price: productItemData.price.toString()),
                        Obx(() => Container(
                            decoration: BoxDecoration(
                                color: userController.userData.value.id ==
                                        productItemData.userId
                                    ? Colors.green
                                    : MPColors.dark,
                                borderRadius: const BorderRadius.only(
                                    topLeft:
                                        Radius.circular(MPSizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        MPSizes.productImageRadius))),
                            child: orderLineController.orderLineList.any(
                                    (orderLineItem) =>
                                        orderLineItem.productItem?.id ==
                                            productItemData.id! &&
                                        orderLineItem.orderStatus!.status !=
                                            "Cancelled")
                                ? SizedBox(
                                    width: MPSizes.iconLg * 1.1,
                                    height: MPSizes.iconLg * 1.1,
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          MPAlertDialog.openDialog(
                                              context,
                                              "Item Not Available",
                                              "Another user may have already ordered this, but the order process is still not completed so this item may be available some other time.",
                                              [
                                                MaterialButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text("Cancel",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!))
                                              ]);
                                        },
                                        child: const Icon(Iconsax.receipt_item,
                                            color: MPColors.white,
                                            size: MPSizes.iconMd),
                                      ),
                                    ),
                                  )
                                : userController.userData.value.id ==
                                        productItemData.userId
                                    ? SizedBox(
                                        width: MPSizes.iconLg * 1.1,
                                        height: MPSizes.iconLg * 1.1,
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              MPAlertDialog.openDialog(
                                                  context,
                                                  "Item Owner",
                                                  "You have listed this item in the marketplace, other users can order this item",
                                                  [
                                                    MaterialButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text("Cancel",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!))
                                                  ]);
                                            },
                                            child: const Icon(
                                                Iconsax.profile_tick,
                                                color: MPColors.white,
                                                size: MPSizes.iconMd),
                                          ),
                                        ),
                                      )
                                    : AddToCartIcon(
                                        productItemId: productItemData.id!)))
                      ],
                    )
                  ]))
        ]));
  }
}

class AddToCartIcon extends StatelessWidget {
  const AddToCartIcon({
    required this.productItemId,
    super.key,
  });

  final int productItemId;
  @override
  Widget build(BuildContext context) {
    UserController userController = UserController.instance;

    return Obx(() => SizedBox(
          width: MPSizes.iconLg * 1.1,
          height: MPSizes.iconLg * 1.1,
          child: Center(
            child: GestureDetector(
                onTap: () async {
                  userController.shoppingCartItemList
                          .any((item) => item.productItemId == productItemId)
                      ? null
                      : MPAlertDialog.openDialog(
                          context,
                          "Add this to Cart?",
                          "Are you sure you want to add this item to your shopping cart?",
                          [
                              MaterialButton(
                                  onPressed: () {
                                    MPAlertDialog.popDialog();
                                  },
                                  child: Text("Cancel",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!)),
                              MaterialButton(
                                  onPressed: () async {
                                    MPAlertLoaderDialog.openLoadingDialog();
                                    await userController
                                        .addToCart(productItemId);
                                    MPAlertDialog.popDialog();
                                    MPAlertLoaderDialog.stopLoading();
                                  },
                                  child: Text('Approve',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!)),
                            ]);
                },
                child: userController.shoppingCartItemList
                        .any((item) => item.productItemId == productItemId)
                    ? const Icon(Icons.check,
                        color: Colors.green, size: MPSizes.iconMd)
                    : const Icon(Iconsax.shopping_cart5,
                        color: MPColors.white, size: MPSizes.iconMd)),
          ),
        ));
  }
}
