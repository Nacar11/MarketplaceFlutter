// ignore_for_file: unused_import, file_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';

import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_page_widgets.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/discover_page/discover_page_widgets.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_types_page/product_types_controller.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_types_page/product_types_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

ProductController productController = ProductController.static;
final productTypesPageController = Get.put(ProductTypesPageController());

class ProductTypesPage extends StatefulWidget {
  const ProductTypesPage({
    Key? key,
  }) : super(key: key);
  @override
  State<ProductTypesPage> createState() => ProductTypesPageState();
}

class ProductTypesPageState extends State<ProductTypesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      const MPDiscoverAppBar(),
      const SizedBox(height: MPSizes.spaceBtwSections),
      const MPSearchContainer(text: "Search Here"),
      const SizedBox(height: MPSizes.spaceBtwSections),
      MPGridLayout(
        mainAxisExtent: 70,
        itemCount: productController.subCategoryList.length,
        itemBuilder: (context, index) {
          ProductCategoryModel productCategories =
              productController.subCategoryList[index];
          return MPClickableCircularContainer(
              index: index,
              onClicked: () {
                productTypesPageController.updatePageIndicator(index);
                productController
                    .getProductTypesByCategoryId(productCategories.id!);
              },
              borderColor: MPHelperFunctions.isDarkMode(context)
                  ? MPColors.white
                  : MPColors.dark,
              padding: const EdgeInsets.all(MPSizes.sm),
              backgroundColor: Colors.transparent,
              child: Row(children: [
                Flexible(
                  child: MPRoundedImage(
                      width: 40,
                      height: 50,
                      isNetworkImage: true,
                      imageUrl: productCategories.product_image!),
                ),
                const SizedBox(width: MPSizes.spaceBtwItems),
                Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryNameWithCheckIcon(
                            textStyle: Theme.of(context).textTheme.labelLarge!,
                            text: productCategories.category_name!),
                        Text('256 Products ',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelMedium)
                      ]),
                )
              ]));
        },
      ),
    ])));
  }
}
