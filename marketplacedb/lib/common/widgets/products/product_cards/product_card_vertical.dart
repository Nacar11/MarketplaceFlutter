import 'package:flutter/material.dart';
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
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_item_page/product_item_page.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

ProductItemController productItemController = ProductItemController.instance;

class MPProductCardVertical extends StatelessWidget {
  const MPProductCardVertical({
    super.key,
    required this.productItemData,
  });
  final ProductItemModel productItemData;

  @override
  Widget build(BuildContext context) {
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
                  if (productItemData.product_images != null &&
                      productItemData.product_images!.isNotEmpty)
                    MPRoundedImage(
                      // isImageCircular: true,
                      isNetworkImage: true,
                      padding: const EdgeInsets.only(top: MPSizes.xs),
                      applyImageRadius: true,
                      borderRadius: MPSizes.productImageRadius,
                      imageUrl:
                          productItemData.product_images![0].product_image!,
                    ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    child: MPSaleTag(),
                  ),
                  Positioned(
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
                  )
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
                            .product!.product_category!.category_name!,
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
                        Container(
                            decoration: const BoxDecoration(
                                color: MPColors.dark,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(MPSizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        MPSizes.productImageRadius))),
                            child: const SizedBox(
                              width: MPSizes.iconLg * 1.1,
                              height: MPSizes.iconLg * 1.1,
                              child: Center(
                                child: Icon(Iconsax.shopping_cart5,
                                    color: MPColors.white,
                                    size: MPSizes.iconMd),
                              ),
                            ))
                      ],
                    )
                  ]))
        ]));
  }
}
