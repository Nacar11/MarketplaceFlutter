import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/discover_page/discover_page_widgets.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_types_page/product_types_page.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

ProductController productController = ProductController.static;

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const MPDiscoverAppBar(),
          const SizedBox(height: MPSizes.spaceBtwSections),
          MPRoundedCoverImage(
            onPressed: () {
              productController.subCategoriesInit(0);
              Get.to(() => const ProductTypesPage());
            },
            text: "Jewelry",
            imageUrl: MPImages.productCategoryJewelry,
          ),
          MPRoundedCoverImage(
            onPressed: () {
              productController.subCategoriesInit(1);
              Get.to(() => const ProductTypesPage());
            },
            text: "Men",
            imageUrl: MPImages.productCategoryMale,
          ),
          MPRoundedCoverImage(
            onPressed: () {
              productController.subCategoriesInit(2);
              Get.to(() => const ProductTypesPage());
            },
            text: "Women",
            imageUrl: MPImages.productCategoryFemale,
          ),
        ]),
      ),
    );
  }
}
