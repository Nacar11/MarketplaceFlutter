import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/product_price_text.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/data/models/shopping_cart_item_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';
import 'package:marketplacedb/util/popups/full_screen_overlay_loader.dart';

class MPCartItem extends StatelessWidget {
  const MPCartItem({
    super.key,
    required this.cartItem,
  });

  final ShoppingCartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          MPRoundedImage(
              isNetworkImage: true,
              imageUrl: cartItem.productItem!.product_images![0].product_image!,
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(MPSizes.sm),
              backgroundColor: MPHelperFunctions.isDarkMode(context)
                  ? MPColors.darkerGrey
                  : MPColors.light),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryNameWithCheckIcon(
                    text: cartItem
                        .productItem!.product!.product_category!.category_name!,
                    textStyle: Theme.of(context).textTheme.bodyMedium!),
                Flexible(
                    child: MPProductTitleText(
                        title: cartItem.productItem!.product!.name!)),
                if (cartItem.productItem!.product_configurations!.isNotEmpty)
                  for (var configuration
                      in cartItem.productItem!.product_configurations!)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${configuration.variationOption!.variation!.name}: ",
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                          TextSpan(
                            text: "${configuration.variationOption!.value}",
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ],
                      ),
                    )
                else
                  Text(
                    "No Variation",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
              ]),
        ])
      ],
    );
  }
}

class SingleCartItemWithFunctionality extends StatelessWidget {
  const SingleCartItemWithFunctionality({
    super.key,
    required this.cartItem,
  });

  final ShoppingCartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    ShoppingCartPageController controller = ShoppingCartPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        MPCartItem(cartItem: cartItem),
        const SizedBox(height: MPSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Row(mainAxisSize: MainAxisSize.min, children: [
              MPCircularIcon(
                width: 32,
                height: 32,
                size: MPSizes.md,
                color: dark ? MPColors.white : MPColors.black,
                backgroundColor: dark ? MPColors.darkerGrey : MPColors.light,
                onPressed: () {
                  MPAlertDialog.openDialog(
                      context,
                      "Remove Item from Cart?",
                      "Are you sure you want to remove this item from your shopping cart?",
                      [
                        MaterialButton(
                            onPressed: () {
                              MPAlertDialog.popDialog();
                            },
                            child: Text("Cancel",
                                style:
                                    Theme.of(context).textTheme.bodyMedium!)),
                        MaterialButton(
                            onPressed: () async {
                              controller.isLoading.value == true
                                  ? null
                                  : {
                                      MPFullScreenOverlayLoader
                                          .openLoadingDialog(),
                                      controller.selectedCartItem.value =
                                          cartItem,
                                      await controller.deleteCartItem(),
                                      MPAlertDialog.popDialog(),
                                      MPFullScreenOverlayLoader.stopLoading(),
                                    };
                            },
                            child: Text('Remove',
                                style: Theme.of(context).textTheme.bodyMedium!))
                      ]);
                },
                icon: Iconsax.trash,
              ),
              const SizedBox(width: MPSizes.spaceBtwItems),
              Text('Available', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: MPSizes.spaceBtwItems),
              Checkbox(
                  shape: const CircleBorder(),
                  activeColor: MPColors.primary,
                  value: cartItem.selectedToCheckout == true,
                  onChanged: (value) {
                    controller.isLoading.value
                        ? null
                        : cartItem.selectedToCheckout == true
                            ? controller.unselectToCheckout(cartItem.id!)
                            : controller.selectToCheckout(cartItem.id!);
                  }),
            ]),
            MPProductPriceText(price: cartItem.productItem!.price.toString())
          ],
        ),
      ],
    );
  }
}
