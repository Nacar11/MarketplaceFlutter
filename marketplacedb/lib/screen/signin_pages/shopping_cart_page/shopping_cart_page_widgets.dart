import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/product_price_text.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:iconsax/iconsax.dart';

class MPCartItem extends StatelessWidget {
  const MPCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          MPRoundedImage(
              imageUrl: MPImages.femaleCategoryIcon,
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
                    text: "Tops",
                    textStyle: Theme.of(context).textTheme.bodyMedium!),
                const Flexible(child: MPProductTitleText(title: "T-Shirts")),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Color: ",
                      style: Theme.of(context).textTheme.bodyMedium!),
                  TextSpan(
                      text: "Black",
                      style: Theme.of(context).textTheme.bodyMedium!),
                ]))
              ]),
        ])
      ],
    );
  }
}

class SingleCartItemWithFunctionality extends StatelessWidget {
  const SingleCartItemWithFunctionality({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        const MPCartItem(),
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
            const MPProductPriceText(price: "250")
          ],
        ),
      ],
    );
  }
}
