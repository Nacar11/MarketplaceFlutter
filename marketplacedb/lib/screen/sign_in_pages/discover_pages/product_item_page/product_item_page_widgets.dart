import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/data/models/products/product_configuration_model.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/dialog_container_loader.dart';

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

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key? key,
    required this.productItemId,
  }) : super(key: key);

  final int productItemId;

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    UserController controller = UserController.instance;
    return Obx(() => Container(
          width: double.infinity,
          height: MPSizes.buttonHeight,
          margin: const EdgeInsets.symmetric(vertical: MPSizes.md),
          child: OutlinedButton(
              onPressed: () async {
                if (controller.shoppingCartItemList.any((item) =>
                    item.productItemId ==
                    productItemController.singleProductItemDetail.value.id)) {
                } else {
                  MPAlertLoaderDialog.openLoadingDialog();
                  await controller.addToCart(productItemId);
                  MPAlertLoaderDialog.stopLoading();
                }
              },
              child: controller.isLoading.value
                  ? const Center(
                      child: SizedBox(
                        height: MPSizes.iconSm,
                        width: MPSizes.iconSm,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : controller.shoppingCartItemList.any((item) =>
                          item.productItemId ==
                          productItemController
                              .singleProductItemDetail.value.id)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const Icon(Icons.check, color: Colors.green),
                              const SizedBox(width: MPSizes.sm),
                              Text("Added To Cart",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(Iconsax.shopping_bag,
                                  color:
                                      dark ? MPColors.white : MPColors.black),
                              const SizedBox(width: MPSizes.sm),
                              Text("Add To Cart",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ])),
        ));
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
              .singleProductItemDetail.value.productConfigurations!.length,
          itemBuilder: (context, index) {
            ProductConfigurationModel productConfigurations =
                productItemController.singleProductItemDetail.value
                    .productConfigurations![index];
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
