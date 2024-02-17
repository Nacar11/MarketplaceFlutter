import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/data/models/products/product_configuration_model.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        const Icon(Iconsax.star5, color: Colors.amber, size: 24),
        const SizedBox(width: MPSizes.spaceBtwItems / 2),
        Text.rich(TextSpan(children: [
          TextSpan(text: '5.0', style: Theme.of(context).textTheme.bodyLarge),
          const TextSpan(
            text: '(45)',
          ),
        ]))
      ]),
      IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.information5, size: MPSizes.iconMd))
    ]);
  }
}

class NameValueRow extends StatelessWidget {
  const NameValueRow({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      MPProductTitleText(title: name),
      const SizedBox(width: MPSizes.spaceBtwItems),
      Text(value, style: Theme.of(context).textTheme.titleLarge)
    ]);
  }
}

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: MPSizes.xs),
      child: MPPrimaryButton(
        icon: const Icon(Iconsax.transaction_minus5, color: MPColors.white),
        text: text,
        onPressed: () {},
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: MPSizes.md),
      child: MPCustomOutlinedButton(
        text: text,
        icon: const Icon(Iconsax.shopping_bag),
        onPressed: () async {},
      ),
    );
  }
}

ProductItemController productItemController = ProductItemController.instance;

class ProductDetailVariationList extends StatelessWidget {
  const ProductDetailVariationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: productItemController
              .singleProductItemDetail.value.product_configurations!.length,
          itemBuilder: (context, index) {
            ProductConfigurationModel productConfigurations =
                productItemController.singleProductItemDetail.value
                    .product_configurations![index];
            return Padding(
              padding: const EdgeInsets.only(top: MPSizes.spaceBtwItems),
              child: NameValueRow(
                  name:
                      '${productConfigurations.variationOption!.variation!.name!}:',
                  value:
                      productConfigurations.variationOption!.value.toString()),
            );
          }),
    );
  }
}

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: MPSizes.defaultSpace,
            vertical: MPSizes.defaultSpace / 2),
        decoration: BoxDecoration(
            color: dark ? MPColors.darkerGrey : MPColors.light,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MPSizes.cardRadiusLg),
                topRight: Radius.circular(MPSizes.cardRadiusLg))),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            "Add",
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                  fontWeightDelta:
                      2, // Use a positive value to increase font weight
                ),
          ),
          MPCircularIcon(icon: Iconsax.shopping_bag, onPressed: () {})
        ]));
  }
}

class ProductItemPageShimmerContainer extends StatelessWidget {
  const ProductItemPageShimmerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    return Container(
      color: isDarkMode ? MPColors.dark : MPColors.white,
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MPSizes.defaultSpace / 2,
              horizontal: MPSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 60,
              ),
              SizedBox(height: MPSizes.spaceBtwSections),
              ShimmerProgressContainer(
                height: 250,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 150,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 150,
              ),
              SizedBox(height: MPSizes.spaceBtwInputFields),
              ShimmerProgressContainer(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
