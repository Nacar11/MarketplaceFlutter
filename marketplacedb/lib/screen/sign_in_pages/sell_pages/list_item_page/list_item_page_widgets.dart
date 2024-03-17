import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edge_widget.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/list_item_page/list_item_page_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/pick_image_bottom_sheet.dart';
import 'package:marketplacedb/util/popups/variation_option_dialog.dart';

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
                            return GestureDetector(
                                onTap: () {
                                  PickImageBottomSheet.openBottomSheet(
                                      controller.selectedImages, index);
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: MPSizes.imageThumbSize,
                                ));
                          } else {
                            return MPRoundedFileImage(
                              onPressed: () {},
                              imageUrl: image,
                              hasBorder: true,
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
                        final File? image = controller.selectedImages[index];
                        if (image == null || image.path.isEmpty) {
                          return GestureDetector(
                            onTap: () {
                              PickImageBottomSheet.openBottomSheet(
                                controller.selectedImages,
                                index,
                              );
                            },
                            child: const MPCircularContainer(
                                backgroundColor: Colors.transparent,
                                height: MPSizes.xl * 2,
                                width: MPSizes.xl * 2,
                                showBorder: true,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: MPSizes.iconLg,
                                )),
                          );
                        } else {
                          return MPRoundedFileImage(
                            onPressed: () {},
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
                            imageUrl: image,
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

class ProductDialogContainer extends StatelessWidget {
  const ProductDialogContainer({
    Key? key,
    required this.text,
    this.icon,
    this.width,
  }) : super(key: key);

  final String text;
  final Icon? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MPHelperFunctions.isDarkMode(context);
    return MPCircularContainer(
      backgroundColor: Colors.transparent,
      borderColor: isDarkMode ? MPColors.white : MPColors.black,
      radius: MPSizes.cardRadiusSm,
      height: 60,
      width: width, // Apply the width argument here
      showBorder: true,
      child: Padding(
        padding: const EdgeInsets.only(left: MPSizes.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: MPSizes.xs),
            ],
            const SizedBox(width: MPSizes.sm),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VariationPicker extends StatelessWidget {
  const VariationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListItemPageController controller = ListItemPageController.instance;
    return Column(
      children: [
        for (int index = 0;
            index < controller.specifiedVariationList.length;
            index++)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${controller.specifiedVariationList[index].name}:',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(width: MPSizes.spaceBtwItems),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        VariationOptionDialog.openDialog(
                            context,
                            controller,
                            controller.specifiedVariationList[index]
                                .variationOptions!,
                            index);
                      },
                      child: const ProductDialogContainer(
                          text: 'Select Variation'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MPSizes.spaceBtwSections),
            ],
          ),
      ],
    );
  }
}
