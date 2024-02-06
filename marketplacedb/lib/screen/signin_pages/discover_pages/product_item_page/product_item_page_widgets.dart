import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/data/models/ProductConfigurationModel.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_item_page/product_item_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ProductItemImagesPreview extends StatelessWidget {
  ProductItemImagesPreview({
    super.key,
    required this.banners,
  });

  final List<String> banners;
  final controller = Get.put(ProductItemPageController());
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: banners
            .map((url) => MPRoundedImage(
                  imageUrl: url,
                  hasBorder: true,
                  isNetworkImage: true,
                  applyImageRadius: true,
                  width: 200,
                ))
            .toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          onPageChanged: (index, _) => controller.updatePageIndicator(index),
          autoPlay: false,
          enableInfiniteScroll: true,
        ),
      ),
    ]);
  }
}

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

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: MPSizes.md),
      child: MPPrimaryButton(
        text: "Checkout",
        onPressed: () {},
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
