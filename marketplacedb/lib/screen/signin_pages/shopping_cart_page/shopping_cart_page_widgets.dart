import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/product_price_text.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:iconsax/iconsax.dart';

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
              imageUrl:
                  cartItem.product_item!.product_images![0].product_image!,
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
                    text: cartItem.product_item!.product!.product_category!
                        .category_name!,
                    textStyle: Theme.of(context).textTheme.bodyMedium!),
                Flexible(
                    child: MPProductTitleText(
                        title: cartItem.product_item!.product!.name!)),
                if (cartItem.product_item!.product_configurations!.isNotEmpty)
                  for (var configuration
                      in cartItem.product_item!.product_configurations!)
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
                onPressed: () {},
                icon: Iconsax.trash,
              ),
              const SizedBox(width: MPSizes.spaceBtwItems),
              Text('Available', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: MPSizes.spaceBtwItems),
              MPCircularIcon(
                width: 32,
                height: 32,
                size: MPSizes.md,
                color: dark ? MPColors.white : MPColors.black,
                backgroundColor: dark ? MPColors.darkerGrey : MPColors.light,
                onPressed: () {},
                icon: Iconsax.add,
              ),
            ]),
            MPProductPriceText(price: cartItem.product_item!.price.toString())
          ],
        ),
      ],
    );
  }
}
