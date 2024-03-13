import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edge_widget.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/pick_image_bottom_sheet.dart';

class ProductListingImagesDisplay extends StatelessWidget {
  const ProductListingImagesDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    ListItemPageController controller = ListItemPageController.instance;
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
                      CarouselSlider.builder(
                        itemCount: controller.selectedImages.length,
                        itemBuilder: (__, int index, _) {
                          final File? image = controller.selectedImages[index];
                          if (image == null || image.path.isEmpty) {
                            return IconButton(
                                iconSize: MPSizes.imageThumbSize,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt,
                                ));
                          } else {
                            return MPRoundedImage(
                              onPressed: () {
                                print(controller.selectedImages.length);
                              },
                              imageUrl: image.path,
                              hasBorder: true,
                              isNetworkImage: false,
                              applyImageRadius: true,
                              width: 200,
                            );
                          }
                        },
                        options: CarouselOptions(
                          viewportFraction: 1,
                          onPageChanged: (index, _) =>
                              controller.updateImagePreviewIndex(index),
                          autoPlay: false,
                          enableInfiniteScroll: true,
                          initialPage: controller.carouselCurrentIndex.value,
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
                      itemCount: controller.selectedImages.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        final productImage = controller.selectedImages[index];
                        if (productImage == null || productImage.path.isEmpty) {
                          return MPCircularContainer(
                            backgroundColor: Colors.transparent,
                            height: MPSizes.xl * 2,
                            width: MPSizes.xl * 2,
                            showBorder: true,
                            child: IconButton(
                                iconSize: MPSizes.iconLg,
                                onPressed: () {
                                  PickImageBottomSheet.openBottomSheet();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                )),
                          );
                        } else {
                          return MPRoundedImage(
                            onPressed: () {},
                            isNetworkImage: true,
                            applyImageRadius: true,
                            width: 70,
                            borderRadius: MPSizes.lg,
                            backgroundColor:
                                dark ? MPColors.dark : MPColors.white,
                            border: Border.all(
                              width:
                                  index == controller.carouselCurrentIndex.value
                                      ? 2.0
                                      : 1.0,
                              color: MPColors.secondary,
                            ),
                            hasBorder: true,
                            imageUrl: productImage.path,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ))));
  }
}
