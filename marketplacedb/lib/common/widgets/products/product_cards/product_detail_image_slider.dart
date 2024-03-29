import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edge_widget.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_image_page/product_image_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_item_page/product_item_page_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';

class ProductDetailImageSlider extends StatelessWidget {
  const ProductDetailImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductItemController productItemController =
        ProductItemController.instance;
    final productItemPageController = Get.put(ProductItemPageController());
    final dark = MPHelperFunctions.isDarkMode(context);
    return Obx(() => CurvedEdgeWidget(
        child: Container(
            color: dark ? MPColors.darkerGrey : MPColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(MPSizes.productImageRadius),
                    child: Column(children: [
                      CarouselSlider(
                        items: productItemController
                            .singleProductItemDetail.value.productImages
                            ?.map((image) => image.productImage ?? "")
                            .map((url) => MPRoundedImage(
                                  onPressed: () {
                                    productItemPageController
                                        .singleProductImage.value = url;
                                    Get.to(() => const ProductImagePage());
                                  },
                                  imageUrl: url,
                                  hasBorder: true,
                                  isNetworkImage: true,
                                  applyImageRadius: true,
                                  width: 200,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          onPageChanged: (index, _) => productItemPageController
                              .updateImagePreviewIndex(index),
                          autoPlay: false,
                          enableInfiniteScroll: true,
                          initialPage: productItemPageController
                              .carouselCurrentIndex.value,
                        ),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 30,
                  left: MPSizes.defaultSpace,
                  child: SizedBox(
                    height: 70,
                    child: ListView.separated(
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: MPSizes.spaceBtwItems),
                      itemCount: productItemController
                          .singleProductItemDetail.value.productImages!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => MPRoundedImage(
                        onPressed: () {
                          productItemPageController.singleProductImage.value =
                              productItemController.singleProductItemDetail
                                  .value.productImages![index].productImage!;
                          Get.to(() => const ProductImagePage());
                        },
                        isNetworkImage: true,
                        applyImageRadius: true,
                        width: 70,
                        borderRadius: MPSizes.lg,
                        backgroundColor: dark ? MPColors.dark : MPColors.white,
                        border: Border.all(
                            width: index ==
                                    productItemPageController
                                        .carouselCurrentIndex.value
                                ? 2.0
                                : 1.0,
                            color: MPColors.secondary),
                        hasBorder: true,
                        imageUrl: productItemController.singleProductItemDetail
                            .value.productImages![index].productImage!,
                      ),
                    ),
                  ),
                )
              ],
            ))));
  }
}
