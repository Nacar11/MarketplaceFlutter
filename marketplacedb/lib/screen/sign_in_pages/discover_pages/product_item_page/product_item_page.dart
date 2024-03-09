import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/products/product_cards/product_detail_image_slider.dart';
import 'package:marketplacedb/common/widgets/texts/peso_sign.dart';
import 'package:marketplacedb/common/widgets/texts/product_price_text.dart';
import 'package:marketplacedb/common/widgets/texts/product_title_text.dart';
import 'package:marketplacedb/common/widgets/texts/sale_tag.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';

import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_item_page/product_item_page_widgets.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ProductItemPage extends StatelessWidget {
  const ProductItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductItemController productItemController =
        ProductItemController.instance;
    UserController userController = UserController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return Obx(() {
      return productItemController.isLoading.value
          ? const Scaffold(body: ProductItemPageShimmerContainer())
          : Scaffold(
              appBar: PrimarySearchAppBar(
                actions: [
                  userController.userData.value.id ==
                          productItemController
                              .singleProductItemDetail.value.userId
                      ? const SizedBox()
                      : FavoritesIconButton(
                          iconSize: MPSizes.iconMd,
                          productItemDataId: productItemController
                              .singleProductItemDetail.value.id!)
                ],
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product Details",
                        style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const ProductDetailImageSlider(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: MPSizes.defaultSpace,
                        left: MPSizes.defaultSpace,
                        bottom: MPSizes.defaultSpace,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          const RatingRow(),
                          Row(
                            children: [
                              const MPSaleTag(),
                              const SizedBox(width: MPSizes.spaceBtwItems),
                              const PesoSign(),
                              Text(
                                productItemController
                                    .singleProductItemDetail.value.price
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                              const SizedBox(width: MPSizes.spaceBtwItems / 2),
                              MPProductPriceText(
                                price: productItemController
                                    .singleProductItemDetail.value.price
                                    .toString(),
                                isLarge: true,
                              )
                            ],
                          ),
                          const SizedBox(height: MPSizes.spaceBtwItems / 2),
                          const NameValueRow(name: "Status", value: "In Stock"),
                          const SizedBox(height: MPSizes.spaceBtwItems / 2),
                          Row(
                            children: [
                              MPRoundedImage(
                                isNetworkImage: true,
                                width: MPSizes.iconLg,
                                height: MPSizes.iconLg,
                                imageUrl: productItemController
                                    .singleProductItemDetail
                                    .value
                                    .product!
                                    .productCategory!
                                    .productImage!,
                              ),
                              CategoryNameWithCheckIcon(
                                textStyle:
                                    Theme.of(context).textTheme.labelMedium!,
                                text: productItemController
                                    .singleProductItemDetail
                                    .value
                                    .product!
                                    .name!,
                              ),
                            ],
                          ),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          const MPProductTitleText(title: 'Variation'),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          Obx(() => productItemController
                                  .singleProductItemDetail
                                  .value
                                  .productConfigurations!
                                  .isEmpty
                              ? Text(
                                  'No Variation for Item',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              : const ProductDetailVariationList()),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          const Divider(),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          const MPProductTitleText(title: 'Description'),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          MPCircularContainer(
                            height: null,
                            width: double.infinity,
                            padding: const EdgeInsets.all(MPSizes.md),
                            backgroundColor:
                                dark ? MPColors.darkerGrey : MPColors.grey,
                            child: MPProductTitleText(
                              title: productItemController
                                  .singleProductItemDetail.value.description!,
                              maxLines: 6,
                            ),
                          ),
                          const SizedBox(height: MPSizes.spaceBtwItems),
                          userController.userData.value.id ==
                                  productItemController
                                      .singleProductItemDetail.value.userId
                              ? MPCircularContainer(
                                  padding: const EdgeInsets.all(
                                      MPSizes.spaceBtwItems),
                                  showBorder: true,
                                  height: null,
                                  backgroundColor: Colors.transparent,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Listed by you',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium),
                                        const SizedBox(
                                            width: MPSizes.spaceBtwItems),
                                        const Icon(Iconsax.receipt_item)
                                      ],
                                    ),
                                  ))
                              : MPCircularContainer(
                                  height: null,
                                  child: Column(
                                    children: [
                                      CheckOutButton(
                                          onPressed: () async {
                                            Get.to(
                                                () => const ShoppingCartPage());
                                          },
                                          text: "To Checkout"),
                                      AddToCartButton(
                                        productItemId: productItemController
                                            .singleProductItemDetail.value.id!,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}















// SingleChildScrollView(
//                 child: Column(children: [
//               CurvedEdgeWidget(
//                   child: Container(
//                       color: dark ? MPColors.darkerGrey : MPColors.light,
//                       child: Stack(
//                         children: [
//                           Padding(
//                               padding: const EdgeInsets.all(
//                                   MPSizes.productImageRadius * 2),
//                               child: ProductItemImagesPreview(
//                                 banners: productItemController
//                                         .singleProductItemDetail
//                                         .value
//                                         .product_images
//                                         ?.map((image) =>
//                                             image.product_image ?? "")
//                                         .toList() ??
//                                     [],
//                               )),
//                           Positioned(
//                             left: 0,
//                             top: 30,
//                             child: SizedBox(
//                               height: 100,
//                               child: ListView.separated(
//                                 separatorBuilder: (_, __) => const SizedBox(
//                                     width: MPSizes.spaceBtwItems),
//                                 itemCount: productItemController
//                                     .singleProductItemDetail
//                                     .value
//                                     .product_images!
//                                     .length,
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (_, index) => MPRoundedImage(
//                                   isNetworkImage: true,
//                                   applyImageRadius: true,
//                                   width: 100,
//                                   padding: const EdgeInsets.all(MPSizes.md),
//                                   backgroundColor:
//                                       dark ? MPColors.dark : MPColors.white,
//                                   border: Border.all(color: MPColors.primary),
//                                   imageUrl: productItemController
//                                       .singleProductItemDetail
//                                       .value
//                                       .product_images![index]
//                                       .product_image!,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       )))
//             ]))