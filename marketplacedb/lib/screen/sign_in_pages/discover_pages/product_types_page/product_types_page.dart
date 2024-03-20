import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/data/models/product/product_category_model.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_types_page/product_types_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_types_page/product_types_page_widgets.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ProductTypesPage extends StatelessWidget {
  const ProductTypesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productTypesPageController = Get.put(ProductTypesPageController());
    ProductController productController = ProductController.instance;
    ProductItemController productItemController =
        ProductItemController.instance;
    return Obx(
      () => productController.isLoading.value
          ? Stack(
              children: [
                DefaultTabController(
                  length: productController.productTypes.length,
                  child: Scaffold(
                    appBar: PrimarySearchAppBar(
                      actions: const [
                        ShoppingCartCounterIcon(),
                      ],
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Store",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    body: NestedScrollView(
                      headerSliverBuilder: (_, innerBoxScrolled) {
                        return [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: true,
                            floating: true,
                            backgroundColor:
                                MPHelperFunctions.isDarkMode(context)
                                    ? MPColors.black
                                    : MPColors.white,
                            expandedHeight:
                                productTypesPageController.expandedHeight.value,
                            flexibleSpace: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: MPSizes.xs),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  const SizedBox(
                                      height: MPSizes.spaceBtwSections * 2),
                                  const MPSearchContainer(text: "Search Here"),
                                  const SizedBox(
                                      height: MPSizes.spaceBtwSections),
                                  MPGridLayout(
                                    mainAxisExtent: 70,
                                    itemCount: productController
                                        .subCategoryList.length,
                                    itemBuilder: (context, index) {
                                      ProductCategoryModel productCategory =
                                          productController
                                              .subCategoryList[index];
                                      return ClickableCategoryCard(
                                        productCategory: productCategory,
                                        index: index,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            bottom: PreferredSize(
                              preferredSize:
                                  const Size.fromHeight(kToolbarHeight),
                              child: Obx(
                                () => MPTabBarProductTypes(
                                  productTypes: productController.productTypes,
                                  onTabPressed: (index, productType) {
                                    productItemController
                                        .getProductItemsByProductType(
                                      productType.id!,
                                    );
                                  },
                                  tabs: productController.productTypes
                                      .map((type) => Tab(text: type.name))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: List.generate(
                          productController.productTypes.length,
                          (index) => MPTabBarViewProductTypes(
                            productItemController: productItemController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            )
          : DefaultTabController(
              length: productController.productTypes.length,
              child: Scaffold(
                appBar: PrimarySearchAppBar(
                  actions: const [
                    ShoppingCartCounterIcon(),
                  ],
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Store",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                body: NestedScrollView(
                  headerSliverBuilder: (_, innerBoxScrolled) {
                    return [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: true,
                        backgroundColor: MPHelperFunctions.isDarkMode(context)
                            ? MPColors.black
                            : MPColors.white,
                        expandedHeight:
                            productTypesPageController.expandedHeight.value,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: MPSizes.xs),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const SizedBox(
                                  height: MPSizes.spaceBtwSections * 2),
                              const MPSearchContainer(text: "Search Here"),
                              const SizedBox(height: MPSizes.spaceBtwSections),
                              MPGridLayout(
                                mainAxisExtent: 70,
                                itemCount:
                                    productController.subCategoryList.length,
                                itemBuilder: (context, index) {
                                  ProductCategoryModel productCategory =
                                      productController.subCategoryList[index];
                                  return ClickableCategoryCard(
                                    productCategory: productCategory,
                                    index: index,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(kToolbarHeight),
                          child: Obx(
                            () => MPTabBarProductTypes(
                              productTypes: productController.productTypes,
                              onTabPressed: (index, productType) {
                                productItemController
                                    .getProductItemsByProductType(
                                  productType.id!,
                                );
                              },
                              tabs: productController.productTypes
                                  .map((type) => Tab(text: type.name))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: List.generate(
                      productController.productTypes.length,
                      (index) => MPTabBarViewProductTypes(
                        productItemController: productItemController,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
