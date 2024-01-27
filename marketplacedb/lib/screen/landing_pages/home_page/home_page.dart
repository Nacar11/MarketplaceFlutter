import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';

import 'package:marketplacedb/screen/landing_pages/home_page/home_page_widgets.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_screen_controller.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

ProductItemController productItemController = ProductItemController.instance;
HomeScreenController homeScreenController = HomeScreenController.static;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      MPPrimaryHeaderContainer(
          height: 350,
          child: Column(children: [
            const MPHomeAppBar(),
            const SizedBox(height: MPSizes.spaceBtwSections),
            const MPSearchContainer(text: "Search Here"),
            const SizedBox(height: MPSizes.spaceBtwSections),
            const Padding(
              padding: EdgeInsets.only(left: MPSizes.defaultSpace),
              child: Column(
                  children: [MPSectionHeading(title: 'Product Categories')]),
            ),
            const SizedBox(height: MPSizes.spaceBtwItems),
            Obx(() => SizedBox(
                    child: Center(
                  child: homeScreenController.isLoading.value
                      ? const SizedBox(
                          height: MPSizes.imageThumbSize,
                        )
                      : SizedBox(
                          height: MPSizes.imageThumbSize,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: homeScreenController
                                  .preferredSubCategoryList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                ProductCategoryModel productCategories =
                                    homeScreenController
                                        .preferredSubCategoryList[index];
                                return MPVerticalImageText(
                                  isNetworkImage: true,
                                  imageUrl: productCategories.product_image!,
                                  text: productCategories.category_name!,
                                );
                              })),
                )))
          ])),
      HomePageBannerSlider(banners: const [
        MPImages.promotion1,
        MPImages.promotion2,
        MPImages.promotion3,
        MPImages.promotion4,
        MPImages.promotion5
      ]),
      const SizedBox(height: MPSizes.spaceBtwSections),
      const Padding(
        padding: EdgeInsets.only(left: MPSizes.sm),
        child: Column(children: [
          MPSectionHeading(
            title: 'Recently Listed Items',
            showActionButton: true,
          )
        ]),
      ),
      const SizedBox(height: MPSizes.spaceBtwSections),
      Obx(
        () => SizedBox(
          child: Center(
            child: productItemController.isLoading.value
                ? MPGridLayout(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const ShimmerProgressContainer(height: 220);
                    },
                  )
                : MPGridLayout(
                    itemCount: productItemController.productItemList.length,
                    itemBuilder: (context, index) {
                      ProductItemModel productItem =
                          productItemController.productItemList[index];
                      return MPProductCardVertical(
                          productItemData: productItem);
                    },
                  ),
          ),
        ),
      ),
    ])));
  }
}




// (_, index) => const MPProductCardVertical()









