import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/discover_page/discover_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/discover_page/discover_page_widgets.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_types_page/product_types_page.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductItemController productItemController =
        ProductItemController.instance;
    ProductController productController = ProductController.instance;
    DiscoverPageController discoverController = DiscoverPageController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const MPPrimaryHeaderContainer(
            child: Column(children: [
              MPDiscoverAppBar(
                showBackArrow: false,
              ),
              SizedBox(height: MPSizes.spaceBtwSections),
            ]),
          ),
          MPRoundedCoverImage(
            onPressed: () async {
              //Accessories Category ID is 1
              productController.subCategoriesInit(0);
              //First Sub Category ID of Accessories Category is 13
              await productController.getProductTypesByCategoryId(13);
              discoverController.currentClickedSubcategory.value = 0;
              discoverController.expandedHeight.value =
                  MPHelperFunctions.expandedHeightTabBar(
                      productController.subCategoryList.length);
              discoverController.selectedProductTypeId.value =
                  productController.productTypes[0].id!;
              //First Product Type ID of First Sub Category of Jewelry Category is 28
              //which is used to retrieve Product Items
              productItemController.getProductItemsByProductType(64);
              Get.to(() => const ProductTypesPage());
            },
            text: "Accessories",
            imageUrl: MPImages.productCategoryJewelry,
          ),
          MPRoundedCoverImage(
            onPressed: () async {
              //Men Category ID is 2
              productController.subCategoriesInit(1);
              //First Sub Category ID of Men Category is 4
              await productController.getProductTypesByCategoryId(4);
              discoverController.currentClickedSubcategory.value = 0;
              discoverController.expandedHeight.value =
                  MPHelperFunctions.expandedHeightTabBar(
                      productController.subCategoryList.length);
              discoverController.selectedProductTypeId.value =
                  productController.productTypes[0].id!;
              //First Product Type ID of First Sub Category of Men Category is 1
              //which is used to retrieve Product Items
              productItemController.getProductItemsByProductType(1);
              Get.to(() => const ProductTypesPage());
            },
            text: "Men",
            imageUrl: MPImages.productCategoryMale,
          ),
          MPRoundedCoverImage(
            onPressed: () async {
              //Women Category ID is 3
              productController.subCategoriesInit(2);
              //First Sub Category ID of Women Category is 8
              await productController.getProductTypesByCategoryId(8);
              discoverController.currentClickedSubcategory.value = 0;
              discoverController.expandedHeight.value =
                  MPHelperFunctions.expandedHeightTabBar(
                      productController.subCategoryList.length);
              // productTypesController.selectedProductTypeId.value =
              //     productController.productTypes[0].id!;
              //First Product Type ID of First Sub Category of Women Category is 21
              //which is used to retrieve Product Items
              productItemController.getProductItemsByProductType(21);
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
